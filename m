Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129153AbQJaVNU>; Tue, 31 Oct 2000 16:13:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129201AbQJaVNL>; Tue, 31 Oct 2000 16:13:11 -0500
Received: from web2101.mail.yahoo.com ([128.11.68.245]:49426 "HELO
	web2101.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S129153AbQJaVM4>; Tue, 31 Oct 2000 16:12:56 -0500
Message-ID: <20001031211254.21174.qmail@web2101.mail.yahoo.com>
Date: Tue, 31 Oct 2000 13:12:54 -0800 (PST)
From: Steven Walter <srwalter@yahoo.com>
Subject: Re: UDMA/66 Data Corruption on SiS530
To: Andre Hedrick <andre@linux-ide.org>
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Check your logs and see if their is a speed setting
> block issued, only if
> you are using patched 2.2x or 2.4.0x kernels will
> this report be
> generated.

I haven't been able to recover anything from the root
fs as of yet.  If I do; I will check the logs.

> > Before, on a 40-conductor cable, I was getting
> 11MB/s
> > with hdparm -t .  I bought an 80-conductor cable
> > today, and saw no speed improvement in mode2,
> which is
> 
> This clear indicates a problem in the device pairing
> or you have not
> enable the entire driver.

IOW, that the drive will not work above a certain
speed with the SiS530 IDE chipset?  If it makes any
difference, there is also a UDMA/33 CD-ROM drive on
the same bus, set as slave.
 
> > the only mode I can set it to.  Something that
> striked
> > me as odd about the cable, though, is that the red
> > wire was broken between the Drive 1 socket and the
> > Drive 0 socket.  Is this to differentiate the two?
> 
> Explain...

Well, I noted that one socket is only for drive 0, and
one socket it only for drive 1.  My thoughts were that
the broken wire between the two sockets were akin to
the twist in a floppy cable, i.e., to designate one as
drive 0 and one as drive 1.

It apparently doesn't impair normal operation, as I
can run windows 95 on the machine without problem.

> If you are using "EXT3-fs" journalling and your
> write cache is not
> disable, you are TOAST!  I just now got the drive
> venders to auto-update
> the contents of the identify page that reports the
> features set and
> masked.

That doesn't sound encouraging... yes, I was using
EXT3 journalling on the root partition.  As for
whether write cache is disabled, I do not know.  I
haven't done anything to explicitly disable it.  But,
as I noted, I sync/unmounted the disks before
rebooting.
 
> Regards,
> 
> Andre Hedrick
> CTO Timpanogas Research Group
> EVP Linux Development, TRG
> Linux ATA Development
> 

One other thing I remember is that the HD is now
recognized as being UDMA/33, whereas before it was
recognized as UDMA/66.  AFAIK, this happened
immediately after swapping cables.  My kernel is
2.2.17+ide.  Thanks for your help so far

=====
-Steven
====================================================
"The most foolish mistake we could possibly make would be to allow the subject races to possess arms. History shows that all conquerors who have allowed their subject races to carry arms have prepared their own downfall by doing so."
Adolph Hitler

__________________________________________________
Do You Yahoo!?
Yahoo! Messenger - Talk while you surf!  It's FREE.
http://im.yahoo.com/
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
