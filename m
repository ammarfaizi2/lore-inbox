Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263784AbTK2QOq (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 29 Nov 2003 11:14:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263785AbTK2QOq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 29 Nov 2003 11:14:46 -0500
Received: from 3E6B2019.rev.stofanet.dk ([62.107.32.25]:12422 "EHLO sysrq.dk")
	by vger.kernel.org with ESMTP id S263784AbTK2QOp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 29 Nov 2003 11:14:45 -0500
Subject: Re: Airo Net 340 PCMCIA WiFi Card trouble
From: Martin Willemoes Hansen <mwh@sysrq.dk>
To: xcytame@yahoo.es
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <200310260334.31185.xcytame@yahoo.es>
References: <1062498150.356.9.camel@spiril.sysrq.dk>
	 <3F55FC69.7050404@terra.es> <1067096661.214.35.camel@hugoboss.sysrq.dk>
	 <200310260334.31185.xcytame@yahoo.es>
Content-Type: text/plain
Message-Id: <1070122478.219.5.camel@spiril.sysrq.dk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Sat, 29 Nov 2003 17:14:38 +0100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2003-10-26 at 03:34, xcytame wrote:
> Well, we had some advance :-)
> 
> I have really no clue about what can cause your system getting no interrupt 
> free for pcmcia. 
> 
> >>airo: register interrupt 0 failed, rc -16
> 
> Googling for "pcmcia-cs register interrupt 0 failed" i found this:
> http://www.linuxquestions.org/questions/archive/3/2003/07/4/48965 where it 
> points to a ISA related issue.

After enabling ISA in the kernel it worked like a charm :o)

Thank you.

The whole solution is:
	1. include memory 0xc0040000-0xc004ffff
	2. Enable ISA in kernel

This works for me with: 
	o Cisco pcmcia, aironet 350 card
	o Linux-2.4.22
	o pcmcia-cs-3.2.5


-- 
Martin Willemoes Hansen

--------------------------------------------------------
E-Mail	mwh@sysrq.dk	Website	mwh.sysrq.dk
IRC     MWH, freenode.net	
--------------------------------------------------------              

