Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136534AbRATIk4>; Sat, 20 Jan 2001 03:40:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136740AbRATIkq>; Sat, 20 Jan 2001 03:40:46 -0500
Received: from anchor-post-31.mail.demon.net ([194.217.242.89]:16141 "EHLO
	anchor-post-31.mail.demon.net") by vger.kernel.org with ESMTP
	id <S136534AbRATIke>; Sat, 20 Jan 2001 03:40:34 -0500
Date: Thu, 20 Jan 2000 08:38:12 +0000
To: safemode <safemode@voicenet.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Via apollo KX133 ide bug in 2.4.x
Message-ID: <20000120083812.A945@colonel-panic.com>
Mail-Followup-To: pdh, safemode <safemode@voicenet.com>,
	linux-kernel@vger.kernel.org
In-Reply-To: <3A68DCD1.FACB4135@voicenet.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="a8Wt8u1KmwUX3Y2C"
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3A68DCD1.FACB4135@voicenet.com>; from safemode@voicenet.com on Fri, Jan 19, 2001 at 07:33:21PM -0500
From: Peter Horton <pdh@colonel-panic.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--a8Wt8u1KmwUX3Y2C
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jan 19, 2001 at 07:33:21PM -0500, safemode wrote:
> I'm sorry I can't be more descriptive than that, but there aren't any
> errors ever displayed.  What happened was after about a day of uptime, I
> began seeing IO errors when trying to access files.  I realized that the
> IO errors occurred on any file I had created.  I rebooted since the
> computer became impossible to use and fsck removed everything that I had
> created since upgrading to the release kernel.  This is all on ext2fs.
> I tried making bootdisks but they all showed up as being bad.  I tried
> copying files to another ext2fs but upon fsck, they too were all removed
> due to corruption.  These ext2fs' were not created by the release
> kernel.  I had to go back to 2.4.0-test11 before the kernel would write
> to the fs correctly.  For the record, I disabled DMA in the kernel and
> i'm compiling for athlon using gcc 2.95.3.  I saw the same thing happen
> though when I booted for a kernel compiled for Pentium 2.    Since
> reverting back to 2.4.0-test11, however, no FS corruption has been
> observed.  Anyone have any idea what this is about?  i'm compiling with
> the same options between kernels but 2.4.x (release and newer) do not
> seem to be able to write to the ext2fs correctly.  Could this be because
> it was formatted by a 2.2.x kernel?   Anyone using this chipset I would
> caution to have backups ready when using it with 2.4.x, as I lost
> hundreds of files to it.  Also, no errors were reported anywhere,  IO
> errors when trying to stat dirs just started appearing after a couple
> days uptime ...then they would occur whenever you wrote to the FS.  Even
> after a reboot.    If you need any extra iinfo about kernel options and
> computer config, just ask.
> 

I think I'm suffering the same thing on my new Asus A7V. Yesterday I got a
single "error in bitmap, remounting read only" type error, and today I got
some files in /tmp that returned I/O error when stat()ed. I do have DMA
enabled, but only UDMA33. I've done several kernel compiles with no
problems at all so looks like something is on the edge. Think I might go
back to 2.2.x for a bit and see what happens, or maybe just remove the VIA
driver :-((.

P.

I've attached lspci -vxxx output, and kernel config, in case anyone is
investigating.

/dev/hda is Seagate ST330621A.

----------VIA BusMastering IDE Configuration----------------
Driver Version:                     2.1e
South Bridge:                       VIA vt82c686a rev 0x22
Command register:                   0x7
Latency timer:                      32
PCI clock:                          33MHz
Master Read  Cycle IRDY:            0ws
Master Write Cycle IRDY:            0ws
FIFO Output Data 1/2 Clock Advance: off
BM IDE Status Register Read Retry:  on
Max DRDY Pulse Width:               No limit
-----------------------Primary IDE-------Secondary IDE------
Read DMA FIFO flush:           on                  on
End Sect. FIFO flush:          on                  on
Prefetch Buffer:               on                  on
Post Write Buffer:             on                  on
FIFO size:                      8                   8
Threshold Prim.:              1/2                 1/2
Bytes Per Sector:             512                 512
Both channels togth:          yes                 yes
-------------------drive0----drive1----drive2----drive3-----
BMDMA enabled:        yes        no        no        no
Transfer Mode:       UDMA   DMA/PIO   DMA/PIO   DMA/PIO
Address Setup:       30ns     120ns      30ns     120ns
Active Pulse:        90ns     330ns      90ns     330ns
Recovery Time:       30ns     270ns      30ns     270ns
Cycle Time:          60ns     600ns     120ns     600ns
Transfer Rate:   33.0MB/s   3.3MB/s  16.5MB/s   3.3MB/s

--a8Wt8u1KmwUX3Y2C
Content-Type: application/octet-stream
Content-Disposition: attachment; filename="lspci+config.gz"
Content-Transfer-Encoding: base64

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
ANhpBC/ZBQAXKxchTl8AAA==

--a8Wt8u1KmwUX3Y2C--
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
