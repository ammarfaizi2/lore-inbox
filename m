Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262637AbUKQWPU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262637AbUKQWPU (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Nov 2004 17:15:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262673AbUKQWNB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Nov 2004 17:13:01 -0500
Received: from smtp207.mail.sc5.yahoo.com ([216.136.129.97]:9656 "HELO
	smtp207.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S262635AbUKQWJx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Nov 2004 17:09:53 -0500
From: Srihari Vijayaraghavan <sriharivijayaraghavan@yahoo.com.au>
To: Jens Axboe <axboe@suse.de>
Subject: Re: [BUG] Kernel disables DMA on RICOH CD-R/RW
Date: Thu, 18 Nov 2004 09:16:27 +1100
User-Agent: KMail/1.6.2
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-ide@vger.kernel.org
References: <20041116124656.82075.qmail@web52601.mail.yahoo.com> <1100706838.420.47.camel@localhost.localdomain> <20041117210657.GP26240@suse.de>
In-Reply-To: <20041117210657.GP26240@suse.de>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_728mB3xH79CP/sM"
Message-Id: <200411180916.27342.sriharivijayaraghavan@yahoo.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Boundary-00=_728mB3xH79CP/sM
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Thu, 18 Nov 2004 08:06 am, Jens Axboe wrote:
> On Wed, Nov 17 2004, Alan Cox wrote:
> > On Maw, 2004-11-16 at 13:01, Bartlomiej Zolnierkiewicz wrote:
> > > Previously VIA IDE driver ignored DMA blacklists completely
> > > (which was of course wrong), it was fixed.
> > >
> > > Probably this drive should be removed from the blacklist.
> > > Does anybody remember why was it added there?
> >
> > As I said before almost all of our blacklist is junk from when the IDE
> > ATAPI DMA bug wasn't fixed.
>
> I sure don't remember why, so sounds plausible.

Could you please accept this patch? (against vanilla 2.6.10-rc2)

I have tested my RICOH CD-R/RW with this patch (on CD Reading/Writing), and it 
works just fine with DMA enabled.

(Unfortunately I do not have any other drive in the DMA disabled list, and 
hence I could not test for them.)

Thank you.
Hari.

--Boundary-00=_728mB3xH79CP/sM
Content-Type: text/x-diff;
  charset="iso-8859-1";
  name="patch-ide-dma-for-ricoh"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="patch-ide-dma-for-ricoh"

--- 2.6.10-rc2/drivers/ide/ide-dma.c.orig	2004-11-18 08:50:03.000000000 +1100
+++ 2.6.10-rc2/drivers/ide/ide-dma.c	2004-11-18 08:50:24.000000000 +1100
@@ -129,7 +129,6 @@
 	{ "CD-532E-A"		,	"ALL"		},
 	{ "E-IDE CD-ROM CR-840",	"ALL"		},
 	{ "CD-ROM Drive/F5A",	"ALL"		},
-	{ "RICOH CD-R/RW MP7083A",	"ALL"		},
 	{ "WPI CDD-820",		"ALL"		},
 	{ "SAMSUNG CD-ROM SC-148C",	"ALL"		},
 	{ "SAMSUNG CD-ROM SC-148F",	"ALL"		},

--Boundary-00=_728mB3xH79CP/sM--
