Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263574AbRFAQS6>; Fri, 1 Jun 2001 12:18:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263597AbRFAQSs>; Fri, 1 Jun 2001 12:18:48 -0400
Received: from perninha.conectiva.com.br ([200.250.58.156]:12556 "HELO
	perninha.conectiva.com.br") by vger.kernel.org with SMTP
	id <S263574AbRFAQS1>; Fri, 1 Jun 2001 12:18:27 -0400
Date: Fri, 1 Jun 2001 11:42:11 -0300 (BRT)
From: Marcelo Tosatti <marcelo@conectiva.com.br>
To: Marcin Kowalski <kowalski@datrix.co.za>
Cc: alan@lxorguk.ukuu.org.uk, linux-kernel@vger.kernel.org
Subject: Re: 2.4.5 VM
In-Reply-To: <Pine.LNX.4.10.10106011121460.6653-100000@webman.medikredit.co.za>
Message-ID: <Pine.LNX.4.21.0106011141450.15837-100000@freak.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 1 Jun 2001, Marcin Kowalski wrote:

> Relating to Huge Dcache and InodeCache Entries and < 2xMem Swap.
> I have a server with > 1.1gig of RAM which I have limited to 1gig (due to
> stability - BUG at HIGHMEM.c: 155 crashes)...
> 
> The size of the Swap space is 620mb... my memory usage is below :
> 
> Mem:        900008     892748       7260          0      14796     171796
> -/+ buffers/cache:     706156     193852
> Swap:       641016       1792     639224
> 
> The extract out of slabinfo is:
> inode_cache       903876 930840    480 116355 116355    1 :  124   62
> bdev_cache          1160   1357     64   23   23    1 :  252  126
> sigqueue             261    261    132    9    9    1 :  252  126
> dentry_cache      775520 934560    128 31152 31152    1 :  252  126
> 
> As you can see the usage is crazy....bearing in mind a number of things.
> The system is running hardware raid5, reiserfs and massive amount of files
> > 500000 in >2000 directories..
> 
> It is a 2x933mhz PIII + 1.1gig of ram NEtservers
> 
> What I really want to know is DOES THIS REALLY Matter. IE If memory is
> needed by and application are these entries simply purged then.. In which
> case there is no problem????

Could you check if they are purged heavily enough for you case when you
start a big app? 




