Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261296AbVCTWBm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261296AbVCTWBm (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Mar 2005 17:01:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261297AbVCTWBm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Mar 2005 17:01:42 -0500
Received: from linux01.gwdg.de ([134.76.13.21]:20952 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S261296AbVCTWBh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Mar 2005 17:01:37 -0500
Date: Sun, 20 Mar 2005 23:01:13 +0100 (MET)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Antonino Daplas <adaplas@pol.net>
cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] remove redundant NULL checks before kfree() in drivers/video/
In-Reply-To: <200503210453.47487.adaplas@hotpop.com>
Message-ID: <Pine.LNX.4.61.0503202259450.19507@yvahk01.tjqt.qr>
References: <Pine.LNX.4.62.0503192339190.5507@dragon.hyggekrogen.localhost>
 <200503210453.47487.adaplas@hotpop.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>>...
>
>This is performance critical, so I would like the check to remain. A comment
>may be added in this section.

Hm, if we used Yoshifuji's inline kfree(), you'd get both. A check and a clean 
code. (Though I would not move kfree to __kfree, but make the inline variant 
explicitly different named.)



Jan Engelhardt
-- 
