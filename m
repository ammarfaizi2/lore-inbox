Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279967AbRJ3PNU>; Tue, 30 Oct 2001 10:13:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279972AbRJ3PNJ>; Tue, 30 Oct 2001 10:13:09 -0500
Received: from [200.248.92.2] ([200.248.92.2]:26372 "EHLO
	inter.lojasrenner.com.br") by vger.kernel.org with ESMTP
	id <S279967AbRJ3PM6>; Tue, 30 Oct 2001 10:12:58 -0500
Message-Id: <200110301609.OAA01973@inter.lojasrenner.com.br>
Content-Type: text/plain; charset=US-ASCII
From: Andre Margis <andre@sam.com.br>
Organization: SAM Informatica Ltda
To: rscuss@omniti.com
Subject: Re: linux-2.4.13 high SWAP
Date: Tue, 30 Oct 2001 13:10:12 -0200
X-Mailer: KMail [version 1.3.1]
Cc: linux-kernel@vger.kernel.org, jesus@omniti.com
In-Reply-To: <3BDE3174.7718D64B@omniti.com>
In-Reply-To: <3BDE3174.7718D64B@omniti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I test 2.4.9 , 2.4.10-ac7, 2.4.13 and all have this problem, I'm not using 
XFS, but reiserfs with LVM and 4 GB RAM. I detected if use tmpfs the kswapd 
eat my all CPU's, in 2.4.13 the system hang after a time. Now I'm testing 
2.4.13-ac3 without tmpfs and he is very better than the others versions. But 
a nice test is disable the HIGHMEM support. I have a machine with 1GB RAM and 
the system is very fine and stable, running 2.4.10-ac7.

 


Em Ter 30 Out 2001 02:49, Robert Scussel escreveu:
> Just thought that I would add our experience.
>
> We have experienced the same kind of swap symptoms described, however we
> have no mounted tmpfs, or ramfs partitions. We have, in fact,
> experienced the same symptoms on the 2.4.2,2.4.5,2.4.7 and 2.4.12
> kernel, haven't yet tried the 2.4.13 kernel.  The symptoms include hung
> processes which can not be killed, system cannot right to disk, and
> files accessed during this time are filled with binary zeros.  As sync
> does not work as well, the only resolution is to do a reboot -f -n.
>
> All systems are comprised of exclusively SGI XFS partitions, with dual
> pentium II/III processors.
>
> Any insight would be helpful,
>
> Robert Scussel
