Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265375AbTLHLXW (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Dec 2003 06:23:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265376AbTLHLXV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Dec 2003 06:23:21 -0500
Received: from intra.cyclades.com ([64.186.161.6]:37345 "EHLO
	intra.cyclades.com") by vger.kernel.org with ESMTP id S265375AbTLHLXR
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Dec 2003 06:23:17 -0500
Date: Mon, 8 Dec 2003 09:06:02 -0200 (BRST)
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
X-X-Sender: marcelo@logos.cnet
To: Tim Timmerman <Tim.Timmerman@asml.com>
Cc: Mark Symonds <mark@symonds.net>, <linux-kernel@vger.kernel.org>,
       Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Subject: Re: 2.4.23 hard lock, 100% reproducible.
In-Reply-To: <16340.9329.913657.900605@asml.com>
Message-ID: <Pine.LNX.4.44.0312080845120.30140-100000@logos.cnet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Cyclades-MailScanner-Information: Please contact the ISP for more information
X-Cyclades-MailScanner: Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 8 Dec 2003, Tim Timmerman wrote:

> >>>>> "Mark" == Mark Symonds <mark@symonds.net> writes:
> 
> Mark> Hi,
> 
> >> 
> >> The first oops looks like:
> >> 
> >> Unable to handle kernel NULL pointer
> >> dereference at virtual address: 00000000
> >> 
> Mark> [...]
> 
> Mark> I'm using ipchains compatability in there, looks like 
> Mark> this is a possible cause - getting a patch right now,
> Mark> will test and let y'all know (and then switch to 
> Mark> iptables, finally). 
>       Let me just add a me-too here. 
> 
>       Haven't got the oops on my desk, here, but from what I could
>       see, the error occurred in find_appropriate_src, somewhere in
>       ipchains.  
> 
>       Further, possibly irrelevant datapoint: ABIT BP6, ne2k-pci and
>       3Com590 network cards. When the oops occurs, everything locks,
>       capslock and scrolllock are lit. 
> 
>       I can reproduce the error by letting a second system ping the
>       first, on the internal network. Sometimes it doesn't even
>       complete a full boot. 
>       
>       I'll try and capture more detail tonight. 

Tim,

Please try the updated 2.4 BK tree (you can use -bk5, 
http://www.kernel.org/pub/linux/kernel/v2.4/snapshots/patch-2.4.23-bk5.bz2).

It contains a fix for a known bug in the netfilter which might what you're 
hitting.


