Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263285AbTFPD2P (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 Jun 2003 23:28:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263298AbTFPD2P
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 Jun 2003 23:28:15 -0400
Received: from CM-lcon-177-66.cm.vtr.net ([200.83.177.66]:22661 "EHLO tonto")
	by vger.kernel.org with ESMTP id S263285AbTFPD2E (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 Jun 2003 23:28:04 -0400
Message-ID: <34134.127.0.0.1.1055734913.squirrel@127.0.0.1>
Date: Sun, 15 Jun 2003 23:41:53 -0400 (CLT)
Subject: 2.4.20, VIA VT8233, Maxtor 6Y080L0, drive not ready for command
From: "andrew cooke" <andrew@acooke.org>
To: linux-kernel@vger.kernel.org
Reply-To: andrew@acooke.org
X-Mailer: SquirrelMail (version 1.4.0 RC1)
MIME-Version: 1.0
Content-Type: multipart/mixed;charset=iso-8859-1;
     boundary="----=_20030615234153_47819"
X-Priority: 3
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

------=_20030615234153_47819
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: us-ascii

Hi,

[Apologies in advance for posting here - I did google around and couldn't
find a more appropriate forum, but please redirect me if this is not OK. 
Also, I'm not subscribed, so would appreciate CC, but will of course check
the archives (didn't want to get swamped by mail just to be told to post
elsewhere).]

Using 2.4.20 (Debian system, but source from kernel.org) plus ext3 patches
from http://www.zip.com.au/~akpm/linux/ext3/ I am trying to get a Maxtor
DiamondMax Plus9 80Gb functioning.  AK77 Pro MB with VIA VT8233 SB (drive
is ATA133, chipset might do ATA100).  Other disks are SCSI-3 and work
fine.  Under load (copying /home from SCSI drive) the IDE drive gives
errors like:

Jun 15 22:31:08 tonto kernel: hdc: status timeout: status=0xd0 { Busy }
Jun 15 22:31:08 tonto kernel: hdc: drive not ready for command
Jun 15 22:31:08 tonto kernel: ide1: reset: success
Jun 15 22:31:09 tonto kernel: hdc: write_intr error1: nr_sectors=10,
stat=0x59
Jun 15 22:31:09 tonto kernel: hdc: write_intr: status=0x59 { DriveReady
SeekComplete DataRequest Error }
Jun 15 22:31:09 tonto kernel: hdc: write_intr: error=0x01 {
AddrMarkNotFound },
LBAsect=123295591, sector=123295270
(repeated ad infinitum with different values)

tonto:/var/log# hdparm /dev/hdc1

/dev/hdc1:
 multcount    =  0 (off)
 IO_support   =  0 (default 16-bit)
 unmaskirq    =  0 (off)
 using_dma    =  0 (off)
 keepsettings =  0 (off)
 readonly     =  0 (off)
 readahead    =  8 (on)
 geometry     = 158816/16/63, sectors = 160086465, start = 63

The geometry values are correct, according to Maxtor's docs.  (IDE0 is
occupied by CD+CDRW, hende hdc).

Is this a kernel problem?  If not, where should I go for help?

Feel free to ask for more data, tests, recompilation of kernel with
different params, etc - happy to help.  Will include kernel .config as a
bzipped attachment.

Thanks,
Andrew

-- 
http://www.acooke.org/andrew
------=_20030615234153_47819
Content-Type: application/octet-stream; name="config.bz2"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="config.bz2"

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
i7kinChIZQ8u2gA=
------=_20030615234153_47819--

