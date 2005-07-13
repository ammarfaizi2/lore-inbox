Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262416AbVGMKK2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262416AbVGMKK2 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Jul 2005 06:10:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262545AbVGMKK2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Jul 2005 06:10:28 -0400
Received: from linux01.gwdg.de ([134.76.13.21]:29890 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S262416AbVGMKKX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Jul 2005 06:10:23 -0400
Date: Wed, 13 Jul 2005 12:10:09 +0200 (MEST)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Gijs Hillenius <gijs@hillenius.net>
cc: Frank Sorenson <frank@tuxrocks.com>, hdaps-devel@lists.sourceforge.net,
       linux-kernel@vger.kernel.org
Subject: Re: Updating hard disk firmware & parking hard disk
In-Reply-To: <878y0bozf8.fsf@hillenius.net>
Message-ID: <Pine.LNX.4.61.0507131208540.14635@yvahk01.tjqt.qr>
References: <20050707171434.90546.qmail@web32604.mail.mud.yahoo.com>
 <42CD7E0C.3060101@tuxrocks.com> <878y0bozf8.fsf@hillenius.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>however, the firmware update did not solve the 'head not park'
>issue. :-(
>
>sudo ./park /dev/hda
>head not parked 4c

Head parking while the system running is almost useless, since sooner or 
later, someone's going to write/read something.
If you want head parking at shutdown, I suggest using hdparm -y. This puts the 
drive to sleep, which includes spindle spindown and, included, appropriate 
head parking.


Jan Engelhardt
-- 

