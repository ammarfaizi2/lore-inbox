Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278922AbRJ2Ttt>; Mon, 29 Oct 2001 14:49:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279408AbRJ2Ttj>; Mon, 29 Oct 2001 14:49:39 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:26377 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S278922AbRJ2Ttb>; Mon, 29 Oct 2001 14:49:31 -0500
Subject: Re: opl3sa2 sound driver and mixers
To: agd5f@yahoo.com (Alex Deucher)
Date: Mon, 29 Oct 2001 19:56:43 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20011029193932.64498.qmail@web11301.mail.yahoo.com> from "Alex Deucher" at Oct 29, 2001 11:39:32 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15yIWa-0003lV-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> sound works, but an extra mixer seems to always load. 
> I always suspected t was because of code sharing or
> somthing, but I thought I'd ask here to see if it was
> a bug or just a quirk of the driver.  I don't have the
> notebook on hand right, now do these are from memory. 
> When I load sound, several modules get loaded, opl3sa2
> and AD18?? (can't remember the number off hand). 

AD1848 - this is correct. The opl3sa2 is an AD1848 compatible device
and an MPU401 compatible device (and some other oddments). 

> What's strange is that 2 mixers seem to get loaded. 
> The first is for a CS4??? (can't recall the exact

CS4232 - that mixer shouldnt be getting created. That is a bug. I'll take
a look at it
