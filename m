Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271626AbRIGIqq>; Fri, 7 Sep 2001 04:46:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271625AbRIGIqh>; Fri, 7 Sep 2001 04:46:37 -0400
Received: from thebsh.namesys.com ([212.16.0.238]:17931 "HELO
	thebsh.namesys.com") by vger.kernel.org with SMTP
	id <S271620AbRIGIqZ>; Fri, 7 Sep 2001 04:46:25 -0400
Message-ID: <3B987D2A.41C975B3@namesys.com>
Date: Fri, 07 Sep 2001 11:54:18 +0400
From: Hans Reiser <reiser@namesys.com>
Organization: Namesys
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.4.4 i686)
X-Accept-Language: en, ru
MIME-Version: 1.0
To: Nerijus Baliunas <nerijus@users.sourceforge.net>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: replaying reiserfs journal and bad blocks (was: Re[3]: Basic 
 reiserfs question)
In-Reply-To: <F45bR99kQgkV07DPT1p00005d9e@hotmail.com>
	 <3B97729B.1F49AACA@namesys.com>
	 <20010907000239.26A738F91C@mail.delfi.lt> <20010907002247.6A4418F703@mail.delfi.lt>
Content-Type: text/plain; charset=koi8-r
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nerijus Baliunas wrote:
> 
> NB> If you think it's RedHat, you probably are wrong - I use RH with reiserfs
> NB> a long time (more than a year - 6.2, now 7.1), and never got a message about
> NB> replaying journal if system was shut down correctly.
> 
> After just written that, I got a real problem. There was a power loss a few minutes ago,
> and I think when hdd was active. Trying to boot 2.4.7 kernel I got a message about
> replaying journal, then hdd error:
> 
> hdd: dma_intr: status=0x51 { DriveReady SeekComplete Error }
> hdd: dma_intr: error=0x40 { UncorrectableError }, LBAsect=84415, sector=36216
> 
> and kernel panic. Please note that I mount root read-write with this kernel.
> 
> Then I rebooted 2.2.19 kernel (which mounts root as read-only if that matters):
> 
> Checking ReiserFS transaction log (device 16:42) ...
> Warning, log recovery starting on readonly filesystem
> hdd: dma_intr: status=0x51 { DriveReady SeekComplete Error }
> hdd: dma_intr: error=0x40 { UncorrectableError }, LBAsect=84415, sector=36216
> end_request: I/O error, dev 16:42 (hdd), sector 36216
> Replayed 33 transactions in 6 seconds
> Using r5 hash to sort names
> ...
> ReiserFS version 3.5.32
> VFS: Mounted root (reiserfs filesystem) readonly.
> 
> and system booted normally.
> Now I rebooted back to 2.4.7 and everything seems to be OK.
> So what to do now? Run badblocks? Change disk? Any suggestions?
> 
> Regards,
> Nerijus
My guess is turn off UDMA, I think we have a www.namesys.com/faq.html entry on
that which you can read and see if my memory of the typical symptoms of flaky
udma are correct.  Commenting on the cause of flaky udma I will leave to others
familiar with your mob's interaction with Linux, except to say that one should
always check cables at a time like this.

Hans
