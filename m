Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129581AbQKUXQ5>; Tue, 21 Nov 2000 18:16:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130132AbQKUXQs>; Tue, 21 Nov 2000 18:16:48 -0500
Received: from note.orchestra.cse.unsw.EDU.AU ([129.94.242.29]:17677 "HELO
	note.orchestra.cse.unsw.EDU.AU") by vger.kernel.org with SMTP
	id <S129581AbQKUXQa>; Tue, 21 Nov 2000 18:16:30 -0500
From: Neil Brown <neilb@cse.unsw.edu.au>
To: Anil kumar <anils_r@yahoo.com>
Date: Wed, 22 Nov 2000 09:19:54 +1100 (EST)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <14874.62730.601259.997774@notabene.cse.unsw.edu.au>
Cc: linux-kernel@vger.kernel.org
Subject: Re: RAID Benchmarking
In-Reply-To: message from Anil kumar on Tuesday November 21
In-Reply-To: <20001121194018.9178.qmail@web6103.mail.yahoo.com>
X-Mailer: VM 6.72 under Emacs 20.7.2
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday November 21, anils_r@yahoo.com wrote:
> Hi,
>  I want to know , how to Benchmark the performance of
>  RAID.Is there any tool for benchmarking?
> 

It all depends on what you want to measure.
If you want to measure "how well will this work for me", then you need
a tool that generates a load that has similar characteristics to the
load that you are likely to impose on the system.

If that is large single threaded sequential reads or sequential
writes, then bonnie is a pretty good tool.  However, this isn't a very
typical load for me.

I have been using bonnie and dbench which can be found at
   ftp://samba.org/pub/tridge/dbench/

I have heard that iozone is pretty good too, though I haven't tried it
yet:
     http://www.iozone.org/

If you are looking at software raid5 in 2.4, you might like to look at
    http://www.cse.unsw.edu.au/~neilb/wiki/?LinuxRaidTest

which has a number of neat graphs and links to some patches that make
raid5 in 2.4 much faster.

You might also like to look at Gary Murakami's page at

  http://www.research.att.com/~gjm/linux/ide-i75raid.html

particularly if you are thinking IDE raid.

Hope this helps.

NeilBrown
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
