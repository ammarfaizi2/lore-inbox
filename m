Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292792AbSCMIcs>; Wed, 13 Mar 2002 03:32:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292796AbSCMIci>; Wed, 13 Mar 2002 03:32:38 -0500
Received: from angband.namesys.com ([212.16.7.85]:10880 "HELO
	angband.namesys.com") by vger.kernel.org with SMTP
	id <S292792AbSCMIc2>; Wed, 13 Mar 2002 03:32:28 -0500
Date: Wed, 13 Mar 2002 11:32:21 +0300
From: Oleg Drokin <green@namesys.com>
To: Troels Walsted Hansen <troels@thule.no>
Cc: "'lkml'" <linux-kernel@vger.kernel.org>, reiserfs-list@namesys.com
Subject: Re: [reiserfs-list] [OOPS] Reiserfs corruption causing oops in VFS code? (Kernel 2.4.16)
Message-ID: <20020313113221.B871@namesys.com>
In-Reply-To: <001301c1ca0a$08e1bd20$0300000a@samurai>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <001301c1ca0a$08e1bd20$0300000a@samurai>
User-Agent: Mutt/1.3.22.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

On Tue, Mar 12, 2002 at 10:08:17PM +0100, Troels Walsted Hansen wrote:

> Mar 12 10:46:01 shogun kernel: is_leaf: item location seems wrong
> (second one): *OLD*[93946 93947 1436783232(0) DIR], item_len 3904,
> item_location 64, free_space(entry_count) 63
Have you tried to run reiserfsck on this partition?
What does it report?

> Mar 12 10:46:02 shogun kernel: Unable to handle kernel paging request at
> virtual address 43b279f0
> Mar 12 10:46:02 shogun kernel: EIP:    0010:[d_lookup+100/288]    Not
> tainted
> >>EIP; c0142ca4 <d_lookup+64/120>   <=====
> Trace; c013a6b0 <cached_lookup+10/50>
> Trace; c013ade8 <link_path_walk+538/790>
> Trace; c013a48e <getname+5e/a0>

d_lookup oopses are usually signs of bad memory.

Bye,
    Oleg
