Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261743AbTJMNiH (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Oct 2003 09:38:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261744AbTJMNiH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Oct 2003 09:38:07 -0400
Received: from intra.cyclades.com ([64.186.161.6]:4275 "EHLO
	intra.cyclades.com") by vger.kernel.org with ESMTP id S261743AbTJMNiE
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Oct 2003 09:38:04 -0400
Date: Mon, 13 Oct 2003 10:35:06 -0200 (BRST)
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
X-X-Sender: marcelo@logos.cnet
To: Thom Borton <borton@phys.ethz.ch>
Cc: Dave Jones <davej@redhat.com>, lkml <linux-kernel@vger.kernel.org>
Subject: Re: PCMCIA CD-ROM does not work
In-Reply-To: <200310111314.20368.borton@phys.ethz.ch>
Message-ID: <Pine.LNX.4.44.0310131027060.3684-100000@logos.cnet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sat, 11 Oct 2003, Thom Borton wrote:

> 
> Hey
> 
> If have now compiled a series of kernels starting from 2.4.18 up to 
> 2.4.22. The drive stops working with 2.4.21. That is indeed where the 
> "drivers/ide/legacy" directory was introduced.
> 
> What do you mean by binary search? What's a "pre"?

Try 2.4.21-pre1, 2.4.21-pre2, 2.4.21-pre3 etc. to find exactly where it
stopped working. You can find the patches against 2.4.20 at

ftp.kernel.org/pub/linux/kernel/v2.4/testing/old/


> 
> Further: In 2.4.22 I get an Oops and the whole system stops when I 
> unplug the pcmcia card -> hard reset. 
> 
> It says:
> 
> ///////////
> remove_proc_entry: hde/identify busy, count=1
> remove_proc_entry: ide2/hde busy, count=1
> Unable to handle kernel paging request at virtual address 655f6373
>  printing eip:
> c011c5b5
> *pde = 00000000
> Oops: 0002
> CPU:     0
> .......
> .......
>  <0>Kernel panic: Aiee, killing interrupt handler!
> In interrupt handler - not syncing
> ///////////
> 
> Sound's scarry, but doesnt tell me a lot, except that I have to reboot 
> the system.

Can you please post the full kernel panic message? 

