Return-Path: <linux-kernel-owner+w=401wt.eu-S932330AbXAIVVx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932330AbXAIVVx (ORCPT <rfc822;w@1wt.eu>);
	Tue, 9 Jan 2007 16:21:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932374AbXAIVVw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Jan 2007 16:21:52 -0500
Received: from iona.labri.fr ([147.210.8.143]:32963 "EHLO iona.labri.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932330AbXAIVVw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Jan 2007 16:21:52 -0500
X-Greylist: delayed 1421 seconds by postgrey-1.27 at vger.kernel.org; Tue, 09 Jan 2007 16:21:51 EST
Date: Tue, 9 Jan 2007 21:57:58 +0100
From: Samuel Thibault <samuel.thibault@ens-lyon.org>
To: Sascha Sommer <saschasommer@freenet.de>
Cc: LKML <linux-kernel@vger.kernel.org>, rmk+mmc@arm.linux.org.uk
Subject: Re: Experimental driver for Ricoh Bay1Controller SD Card readers
Message-ID: <20070109205758.GA6643@bouh.residence.ens-lyon.fr>
Mail-Followup-To: Samuel Thibault <samuel.thibault@ens-lyon.org>,
	Sascha Sommer <saschasommer@freenet.de>,
	LKML <linux-kernel@vger.kernel.org>, rmk+mmc@arm.linux.org.uk
References: <200701070032.27234.saschasommer@freenet.de>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="envbJBWh7q8WU6mo"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <200701070032.27234.saschasommer@freenet.de>
User-Agent: Mutt/1.5.12-2006-07-14
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--envbJBWh7q8WU6mo
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

Hi,

Sascha Sommer, le Sun 07 Jan 2007 00:32:26 +0100, a écrit :
> Attached is a very experimental driver for a Ricoh SD Card reader that can be 
> found in some notebooks like the Samsung P35.

Yehaaaw! That reader can be found on DELL X300 too. It works almost fine
for me, see attached dmesg. These I/O errors didn't prevent me from
mounting a card, though.

> In order to write this driver I hacked qemu to have access to the cardbus 
> bridge containing this card. I then logged the register accesses of the 
> windows xp driver and tryed to analyse them.

Great to see people brave enough to do such tedious work :D

> - I only tested with a 128 MB SD card, no idea what would be needed to support
>   other card types

Unfortunately, I don't have other cards either.

> - only tested with kernel 2.6.18

Tested with 2.6.19 without source change.

> apart from all these problems reading an image from my sd card seems to have 
> worked ;) 

The IO errors make dd stop on my box. I tried to set TIMEOUT to 1000
(this is a slow card) without better results. Tell me if there are
things I can test.

I'm not subscribed to linux-kernel, so please remember to Cc me when
posting updates, etc. so I can test them.

Samuel

--envbJBWh7q8WU6mo
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=dmesg

pccard: PCMCIA card inserted into slot 0
pcmcia: registering new device pcmcia0.0
sdricoh_cs: no version for "struct_module" found: kernel tainted.
mmcblk0: mmc0:b370 SD128 123008KiB (ro)
 mmcblk0: p1
sdricoh_cs: timeout waiting for data
sdricoh_cs: timeout waiting for data
sdricoh_cs: timeout waiting for data
sdricoh_cs: timeout waiting for data
sdricoh_cs: timeout waiting for data
sdricoh_cs: timeout waiting for data
sdricoh_cs: timeout waiting for data
sdricoh_cs: timeout waiting for data
mmcblk0: error 1 sending read/write command
end_request: I/O error, dev mmcblk0, sector 32
Buffer I/O error on device mmcblk0, logical block 4
sdricoh_cs: timeout waiting for data
sdricoh_cs: timeout waiting for data
sdricoh_cs: timeout waiting for data
sdricoh_cs: timeout waiting for data
sdricoh_cs: timeout waiting for data
sdricoh_cs: timeout waiting for data
sdricoh_cs: timeout waiting for data
sdricoh_cs: timeout waiting for data
mmcblk0: error 1 sending read/write command
end_request: I/O error, dev mmcblk0, sector 56
Buffer I/O error on device mmcblk0, logical block 7
sdricoh_cs: timeout waiting for data
sdricoh_cs: timeout waiting for data
sdricoh_cs: timeout waiting for data
sdricoh_cs: timeout waiting for data
sdricoh_cs: timeout waiting for data
sdricoh_cs: timeout waiting for data
sdricoh_cs: timeout waiting for data
sdricoh_cs: timeout waiting for data
mmcblk0: error 1 sending read/write command
end_request: I/O error, dev mmcblk0, sector 80
Buffer I/O error on device mmcblk0, logical block 10
sdricoh_cs: timeout waiting for data
sdricoh_cs: timeout waiting for data
sdricoh_cs: timeout waiting for data
sdricoh_cs: timeout waiting for data
sdricoh_cs: timeout waiting for data
sdricoh_cs: timeout waiting for data
sdricoh_cs: timeout waiting for data
sdricoh_cs: timeout waiting for data
mmcblk0: error 1 sending read/write command
end_request: I/O error, dev mmcblk0, sector 112
Buffer I/O error on device mmcblk0, logical block 14
pccard: card ejected from slot 0

--envbJBWh7q8WU6mo--
