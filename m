Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317315AbSFGSLw>; Fri, 7 Jun 2002 14:11:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317317AbSFGSLv>; Fri, 7 Jun 2002 14:11:51 -0400
Received: from khms.westfalen.de ([62.153.201.243]:8632 "EHLO
	khms.westfalen.de") by vger.kernel.org with ESMTP
	id <S317315AbSFGSLv>; Fri, 7 Jun 2002 14:11:51 -0400
Date: 07 Jun 2002 20:08:00 +0200
From: kaih@khms.westfalen.de (Kai Henningsen)
To: dsrelist@yahoo.com
cc: linux-kernel@vger.kernel.org
Message-ID: <8QRbBdkXw-B@khms.westfalen.de>
In-Reply-To: <20020607165154.29392.qmail@web20809.mail.yahoo.com>
Subject: Re: Stream Lined Booting - SCSI Hold Up
X-Mailer: CrossPoint v3.12d.kh9 R/C435
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Organization: Organisation? Me?! Are you kidding?
X-No-Junk-Mail: I do not want to get *any* junk mail.
Comment: Unsolicited commercial mail will incur an US$100 handling fee per received mail.
X-Fix-Your-Modem: +++ATS2=255&WO1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

dsrelist@yahoo.com (Shane Walton)  wrote on 07.06.02 in <20020607165154.29392.qmail@web20809.mail.yahoo.com>:

> Thank you all for your replies.  Disabling the SCSI
> reset helps much, but not enough.  I ended up loading
> a RAM disk to start key binaries to fulfill this
> requirement, afterwards I then load the aic7xxx module
> and pivot_root to the real root.  My biggest problem
> is
> the BIOS level resets and POST.  Thanks for your time.

* Generic BIOS:
  On modern BIOSes, there are usually several options that can be changed
  to speed up that part - switching off the memory check, the floppy seek,
  and so on.

* Adaptec BIOS:
  It's been a while since I saw that, but there's often stuff that can be
  switched in a SCSI BIOS as well. Such as which targets and LUNs it will
  look at, what options it will try, if those options can be negotiated,
  if it will try to spin up disks, and so on. Some of those options also
  affect boot speed.

You might need to experiment some to determine the fastest setting.

But beware that *some* settings can at least theoretically make a reboot  
hang that's not coming from power-off. (If the boot disk doesn't spin up  
by itself, that can usually be changed by a jumper; the BIOS should not  
*need* to spin up disks.) And turning off error checks means - just like  
one would expect - that some errors aren't checked for.

MfG Kai
