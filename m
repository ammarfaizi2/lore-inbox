Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267458AbUGNQ5y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267458AbUGNQ5y (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Jul 2004 12:57:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267461AbUGNQ5y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Jul 2004 12:57:54 -0400
Received: from chaos.analogic.com ([204.178.40.224]:16005 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S267458AbUGNQ5v
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Jul 2004 12:57:51 -0400
Date: Wed, 14 Jul 2004 12:57:04 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
X-X-Sender: root@chaos
Reply-To: root@chaos.analogic.com
To: lya755@ece.northwestern.edu
cc: linux-kernel@vger.kernel.org
Subject: Re: question about ramdisk
In-Reply-To: <1089822621.40f55f9dd4278@core.ece.northwestern.edu>
Message-ID: <Pine.LNX.4.53.0407141253050.16532@chaos>
References: <1089651469.40f2c30d44364@core.ece.northwestern.edu> 
 <ccugqu$tun$1@terminus.zytor.com>  <1089727279.40f3eb2f82a6c@core.ece.northwestern.edu>
  <1089749203.22026.17.camel@mindpipe>  <1089753034.40f44fca074c2@core.ece.northwestern.edu>
 <1089753955.22175.8.camel@mindpipe> <1089817172.40f54a540e0c1@core.ece.northwestern.edu>
 <Pine.LNX.4.53.0407141154120.16363@chaos> <1089822621.40f55f9dd4278@core.ece.northwestern.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 14 Jul 2004 lya755@ece.northwestern.edu wrote:

> Thanks so much for the hint! Really appreciate it. I'll try out your
> suggestions.
>
> I am still a bit confused, though. If the code is in ramdisk, then it will be
> mapped to the process address space, which as I understand, does not involve
> any actual data copy and transfer. This sounds very reasonable. But what if
> the code is in hard disk? Would the kernel copy it to memory (somewhere
> allocated) then map this region as the text section for the address space, and
> then run the instructions from ram? That's the way I understand it, but I
> don't know whether that is correct.
>
> Thanks!
> Lei

The instructions are always executed from RAM even if the executable
file is on a physical disk. The file is memory-mapped. Execute
`man mmap`. One of the parameters is MAP_FILE. The whole file
is mapped, however, only that which is necessary at a particular
time is actually read from the disk, one page at a time.

Cheers,
Dick Johnson
Penguin : Linux version 2.4.26 on an i686 machine (5570.56 BogoMips).
            Note 96.31% of all statistics are fiction.


