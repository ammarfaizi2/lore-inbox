Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261494AbULTMZm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261494AbULTMZm (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Dec 2004 07:25:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261497AbULTMZm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Dec 2004 07:25:42 -0500
Received: from khan.acc.umu.se ([130.239.18.139]:14835 "EHLO khan.acc.umu.se")
	by vger.kernel.org with ESMTP id S261494AbULTMZb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Dec 2004 07:25:31 -0500
Date: Mon, 20 Dec 2004 13:25:27 +0100
From: David Weinehall <tao@debian.org>
To: Linux-Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Problem with eject and cd-ripping
Message-ID: <20041220122527.GZ27718@khan.acc.umu.se>
Mail-Followup-To: Linux-Kernel Mailing List <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
X-Editor: Vi Improved <http://www.vim.org/>
X-Accept-Language: Swedish, English
X-GPG-Fingerprint: 7ACE 0FB0 7A74 F994 9B36  E1D1 D14E 8526 DC47 CA16
X-GPG-Key: http://www.acc.umu.se/~tao/files/pubkey_dc47ca16.gpg.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

(Tested kernels: Debian's 2.6.9 and an assortment of home-compiled
 2.6.10-rc3-bk's).

When ripping an extended CD (I tried with the re-releases of Iron
Maiden's older albums) or copy-defected media, I get a bunch of
these messages in the kernlog:

hdc: command error: status=0x51 { DriveReady SeekComplete Error }
hdc: command error: error=0x54
ide: failed opcode was 100
end_request: I/O error, dev hdc, sector 0
Buffer I/O error on device hdc, logical block 0

After these messages have occured, it is no longer possible to eject
the CD as a normal user, and while root can eject it, I get this error
message:

program eject is using a deprecated SCSI ioctl, please convert it to SG_IO
scsi: unknown opcode 0x1e
program eject is using a deprecated SCSI ioctl, please convert it to SG_IO
program eject is using a deprecated SCSI ioctl, please convert it to SG_IO

However, the error persists even with other CD:s after this, I have to
reboot the computer to be able to eject as a normal user after this has
occured.

I don't recall seeing this problem earlier (the machine hasn't been
running since 2.6.5-times or so, so I cannot be absolutely sure).
And unless the quality of copy defections suddenly have increased,
there also seems to be a regression on that front, since I'm no longer
able to rip that kind of CDs at all (it might be the CD I tried with
that had a newer protection though, I'll have to confirm this with one
of my older ones to be sure).

The CD is "_NEC DVD_RW ND-1300A" (IDE), further information available
on request.


Regards: David Weinehall
-- 
 /) David Weinehall <tao@acc.umu.se> /) Northern lights wander      (\
//  Maintainer of the v2.0 kernel   //  Dance across the winter sky //
\)  http://www.acc.umu.se/~tao/    (/   Full colour fire           (/
