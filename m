Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286311AbSBYUPf>; Mon, 25 Feb 2002 15:15:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291614AbSBYUP2>; Mon, 25 Feb 2002 15:15:28 -0500
Received: from 25-VALL-X12.libre.retevision.es ([62.83.208.153]:44816 "EHLO
	ragnar-hojland.com") by vger.kernel.org with ESMTP
	id <S286311AbSBYUPT>; Mon, 25 Feb 2002 15:15:19 -0500
Date: Mon, 25 Feb 2002 21:13:46 +0100
From: Ragnar Hojland Espinosa <ragnar@jazzfree.com>
To: Martin Rode <Martin.Rode@zeroscale.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Reiserfs and badblocks?
Message-ID: <20020225211346.B10218@ragnar-hojland.com>
In-Reply-To: <3C7A6D75.A759FBC1@zeroscale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.2.5i
In-Reply-To: <3C7A6D75.A759FBC1@zeroscale.com>; from Martin.Rode@zeroscale.com on Mon, Feb 25, 2002 at 05:59:33PM +0100
Organization: Mediocrity Naysayers Ltd
X-Homepage: http://lightside.eresmas.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 25, 2002 at 05:59:33PM +0100, Martin Rode wrote:
> The questions I have is to clearify a problem encountered a few days
> ago:
> 
> Basic setup:
> 
> - Linux Kernel 2.4.3-20mdk (Mandrake 8.0 I believe)
> - LVM configured
> - Reiserfs on top of LVM (90 GB)
> 
> The setup had worked for a few months flawlessly.
> 
> But after creating an archiver (the archiver is supposed to find new
> files and copies them into an _ARCHIVE_ directory) script which is
> triggered via cron a lot of "stat's" where done on the filesystem. They
> might have caused the messages I'm getting know when accessing certain
> files:
> 
> Feb 25 18:17:20 apu kernel: hda: dma_intr: status=0x51 { DriveReady
> SeekComplete Error }
> Feb 25 18:17:20 apu kernel: hda: dma_intr: error=0x40 {
> UncorrectableError }, LBAsect=70366, sector=70280
> Feb 25 18:17:20 apu kernel: end_request: I/O error, dev 03:01 (hda),
> sector 70280
> 
> I assume my hard disk /dev/hda has bad blocks which have not been used
> before.

I'd backup if I were you.  A thing you can try turning off UDMA on both the
kernel and bios, and see if it improves the situation.  You can then do a
badblocks run and mark with fsck.

But if you havent changed anything, your HD is quite wounded.
-- 
____/|  Ragnar Højland      Freedom - Linux - OpenGL |    Brainbench MVP
\ o.O|  PGP94C4B2F0D27DE025BE2302C104B78C56 B72F0822 | for Unix Programming
 =(_)=  "Thou shalt not follow the NULL pointer for  | (www.brainbench.com)
   U     chaos and madness await thee at its end."      [20 pend. Mar 10]
