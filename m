Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265369AbTLHKck (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Dec 2003 05:32:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265371AbTLHKck
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Dec 2003 05:32:40 -0500
Received: from intra.cyclades.com ([64.186.161.6]:53971 "EHLO
	intra.cyclades.com") by vger.kernel.org with ESMTP id S265369AbTLHKci
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Dec 2003 05:32:38 -0500
Date: Mon, 8 Dec 2003 08:17:30 -0200 (BRST)
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
X-X-Sender: marcelo@logos.cnet
To: Mark Symonds <mark@symonds.net>
Cc: linux-kernel@vger.kernel.org, "David S. Miller" <davem@redhat.com>,
       William Lee Irwin III <wli@holomorphy.com>,
       Harald Welte <laforge@netfilter.org>
Subject: Re: 2.4.23 hard lock, 100% reproducible.
In-Reply-To: <008501c3bd18$697361e0$7a01a8c0@gandalf>
Message-ID: <Pine.LNX.4.44.0312080815460.30140-100000@logos.cnet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Cyclades-MailScanner-Information: Please contact the ISP for more information
X-Cyclades-MailScanner: Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sun, 7 Dec 2003, Mark Symonds wrote:

> 
> Hi,
> 
> > 
> > The first oops looks like:
> > 
> > Unable to handle kernel NULL pointer
> > dereference at virtual address: 00000000
> > 
> [...]
> > 
> > 
> > Isnt it a bit weird that the full backtrace is not reported ? 
> > 
> > wli suggests that might stack corruption.
> > 
> 
> My bad - wrote it down by hand originally since 
> it was locked hard.  
> 
> > 
> > I dont see any suspicious change around tcp_print_conntrack().
> > 
> > Any clues? 
> > 
> 
> I'm using ipchains compatability in there, looks like 
> this is a possible cause - getting a patch right now,
> will test and let y'all know (and then switch to 
> iptables, finally). 

Mark,

Please try the latest BK tree. There was a known bug in the netfilter code 
which could cause the lockups. 

 



