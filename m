Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264477AbTK0LAw (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Nov 2003 06:00:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264478AbTK0LAw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Nov 2003 06:00:52 -0500
Received: from fgwmail7.fujitsu.co.jp ([192.51.44.37]:17045 "EHLO
	fgwmail7.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S264477AbTK0LAr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Nov 2003 06:00:47 -0500
Date: Thu, 27 Nov 2003 20:00:15 +0900
From: Hironobu Ishii <ishii.hironobu@jp.fujitsu.com>
Subject: Re: Hp/Compaq Fibre HBA
To: knobi@knobisoft.de, linux-kernel@vger.kernel.org
Cc: fms@istop.com
Message-id: <016501c3b4d5$aa4b2130$2987110a@lsd.css.fujitsu.com>
MIME-version: 1.0
X-MIMEOLE: Produced By Microsoft MimeOLE V6.00.2800.1165
X-Mailer: Microsoft Outlook Express 6.00.2800.1158
Content-type: text/plain;	charset="ISO-8859-1"
Content-transfer-encoding: 7bit
X-Priority: 3
X-MSMail-priority: Normal
References: <20031126110558.16044.qmail@web13906.mail.yahoo.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dan and Martin,


> >Did I send this question to the wrong group?
> >
> >On Mon, 2003-11-24 at 13:18, Danny Brow wrote:
> >> Any one know if there are drivers for a storageworks fibre channel
> host
> >> bus adapter /p. The chip set is Tachyon HPFC-5000c/3.0, the card
> also
> >> has this number on it HHBA - 5000A.
> >>
> >> TIA,
> >>
> >> Dan.
> >>
> Dan,

I'm afraid there is no linux driver for that card.
Agilent calls HPFC-5000C as "Classic Tachyon".

"drivers/net/fc" is a driver that controls Classic Tachyon.
But I don't know whether it works as SCSI driver.
(I'm afraid it doesn't.)
Basically, it's a driver for Interphase 5526 PCI FC card.

Classic Tachyon has a TSI(Tachyon System Interface) bus.
So every Classic Tachyon based PCI-HBA has its own bus bridge chip.

Interphase's bridge chip was called as i-chip.
If HHBA-5000A uses a i-chip as a bridge, you might be able to use
that driver.
Are there any Interphase logo on HHBA-5000A?

> 
>  not sure about the group. Maybe it is just that nobody has a good
> answer. I was having similar problems with regard to another Tachyon
> [XL2]based HP card.Lack of Linux support prevented basically a working
> dual-boot solution (HP-UX vs. Linux) on couple of rx5670 boxes.
> 
>  At that time a nice folk at HP basically told me that: "it could be
> done, but we are looking for funding one or two consultants".
> 
>  One of the problems involved seems to be documentation on the Tachyon
> chips. As usual.  Another reason (for those liking conspiracy theories)
> might be market(ing) segmentation by HP. But I'm just being paranoid
> here :-)
> 
> Martin
> PS: have a look at http://sourceforge.net/projects/cpqfc - but I fear
> it is not very actively maintained :-(

cpqfc is a driver for Tachyon TL/TS(HPFC-51xx), XL2(HPFC-5200) and
DX2(HPFC-5400).


Hironobu Ishii.

