Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277046AbRJHSBk>; Mon, 8 Oct 2001 14:01:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277044AbRJHSBa>; Mon, 8 Oct 2001 14:01:30 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:49679 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S277046AbRJHSBN>; Mon, 8 Oct 2001 14:01:13 -0400
Subject: Re: linux-2.4.10-acX
To: louisg00@bellsouth.net (Louis Garcia)
Date: Mon, 8 Oct 2001 19:07:12 +0100 (BST)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <1002562837.8724.4.camel@tiger> from "Louis Garcia" at Oct 08, 2001 01:40:37 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15qeo4-0001MW-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Has Alan's tree been fully merged with Linus's?? Or are their bits in
> Linus's tree that is not in Alan's?

There are measurable differences between the two trees. Notably

-	Linus uses the Andrea VM in 2.4.10
	-ac uses the Riel VM in 2.4.10-ac

The -ac tree also has the following major additions

-	Platform support for x86_64, usermode linux , etc
-	32bit uid safe quota
-	Ext3 file system
-	PnPBIOS support
-	Various PPro and Pentium workarounds
-	Simple boot flag
-	Faster x86 syscall path
-	PPPoATM
-	Elevator flow control
-	DRM 4.0 and 4.1 support not just 4.1 (ie XFree 4.0.x works)
-	CMS file system
-	Intermezzo file system
-	isofs compression

and drivers for

-	IB700
-	IBM Mwave 
-	Lots more MTD devices
-	SA1100 PCMCIA
-	Various USB toys

and then lots of bug fixes

Much of that will go on to Linus. Some he has refused (faster syscall path,
elevator flow control, ..). It takes time to feed stuff on and often I want
to test it in -ac first. Because so much changed in 2.4.10/11pre it's now
getting very hard to merge a lot of the fixes like the truncate standards
compliance stuff so they may not make Linus tree until 2.5


Alan
