Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267068AbTAUNsH>; Tue, 21 Jan 2003 08:48:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267070AbTAUNsH>; Tue, 21 Jan 2003 08:48:07 -0500
Received: from pc-62-31-74-42-ed.blueyonder.co.uk ([62.31.74.42]:33153 "EHLO
	sisko.scot.redhat.com") by vger.kernel.org with ESMTP
	id <S267068AbTAUNsG>; Tue, 21 Jan 2003 08:48:06 -0500
Subject: Re: 2.4.21-pre3 - problems with ext3 (long)
From: "Stephen C. Tweedie" <sct@redhat.com>
To: Lukasz Trabinski <lukasz@wsisiz.edu.pl>
Cc: akpm@zip.com.au, Andreas Dilger <adilger@clusterfs.com>,
       linux-kernel@vger.kernel.org,
       Bartlomiej Solarz-Niesluchowski <solarz@wsisiz.edu.pl>
In-Reply-To: <Pine.LNX.4.51.0301210029010.30053@oceanic.wsisiz.edu.pl>
References: <Pine.LNX.4.51.0301141401260.6636@oceanic.wsisiz.edu.pl>
	<1043102297.13050.59.camel@sisko.scot.redhat.com> 
	<Pine.LNX.4.51.0301210029010.30053@oceanic.wsisiz.edu.pl>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 21 Jan 2003 13:56:26 +0000
Message-Id: <1043157386.2447.56.camel@sisko.scot.redhat.com>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, 2003-01-21 at 00:25, Lukasz Trabinski wrote:

> system boot  2.4.20:
> Dec 15 15:27:01 oceanic kernel: Assertion failure in journal_start_Rsmp_c2be780a
> () at transaction.c:248: "handle->h_transaction->t_journal == journal

> With earlier kernels 2.4.X (for example 2.4.20-rc2) this machine has much 
> longer uptime.

OK, which was the last one which ran stable for you?  I note that you've
got a failure marked "2.4.20" in the log.

> Dec 15 15:27:01 oceanic kernel: Kernel panic: EXT3-fs panic (device sd(8,23)): load_block_bitmap: block_group >= groups_count - block_group = 524287, groups_count = 2126

Do you have the backtrace for that?  I can't see any way that particular
error can happen unless the kernel's memory is getting corrupt, or
there's a corrupt superblock coming in from the disk.  

Also, are you sure you've been ksymoops'ing these from the right
System.map files?  The traces really don't make a lot of sense.

Finally,

> By the way, last crash was with messages:
> Jan 19 11:50:20 oceanic kernel: kernel BUG at highmem.c:159!
> Jan 19 11:50:20 oceanic kernel: invalid operand: 0000
> Jan 19 11:50:20 oceanic kernel: CPU:    1

If that happens again, serial console is the best way of getting the
full oops.  How much memory does your system have?  Have you ever seen
this error before?  

Cheers,
 Stephen

