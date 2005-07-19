Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261613AbVGSRwu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261613AbVGSRwu (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Jul 2005 13:52:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261604AbVGSRwd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Jul 2005 13:52:33 -0400
Received: from linux01.gwdg.de ([134.76.13.21]:699 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S261480AbVGSRwc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Jul 2005 13:52:32 -0400
Date: Tue, 19 Jul 2005 19:52:31 +0200 (MEST)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Ivan Yosifov <ivan@yosifov.net>
cc: linux-kernel@vger.kernel.org
Subject: Re: Noob question. Why is the for-pentium4 kernel built with
 -march=i686 ?
In-Reply-To: <1121792852.11857.6.camel@home.yosifov.net>
Message-ID: <Pine.LNX.4.61.0507191950020.89@yvahk01.tjqt.qr>
References: <1121792852.11857.6.camel@home.yosifov.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>Hello,
>
>If I set the CPU type to be amd64 in kernel config, the kernel is built
>with -march=k8. If I set it to be k6, the kernel is built with
>-march=k6. If I set the CPU type to be Pentium4, the kernel is built
>with -march=i686 -mtune=pentium4. Why is not the for-P4 kernel built
>with -march=pentium4 ? 
>I tried building the kernel with -march=pentium4  for the sake of
>experiment and got no ill effects.

-march= specifies the instruction set, -mcpu= / -mtune= the tuning factor. 
Maybe it is that the instruction set is the same on i686 and 
pentium4. cmov for example is not present in k6, and k8 is something 
completely different at all.


Jan Engelhardt
-- 
