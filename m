Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264570AbTLGXSZ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 7 Dec 2003 18:18:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264588AbTLGXSY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Dec 2003 18:18:24 -0500
Received: from ca1.symonds.net ([66.92.42.136]:40714 "EHLO symonds.net")
	by vger.kernel.org with ESMTP id S264570AbTLGXSX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Dec 2003 18:18:23 -0500
Message-ID: <008501c3bd18$697361e0$7a01a8c0@gandalf>
From: "Mark Symonds" <mark@symonds.net>
To: "Marcelo Tosatti" <marcelo.tosatti@cyclades.com>
Cc: "Keith Owens" <kaos@ocs.com.au>, <linux-kernel@vger.kernel.org>,
       "David S. Miller" <davem@redhat.com>,
       "William Lee Irwin III" <wli@holomorphy.com>,
       "Harald Welte" <laforge@netfilter.org>
References: <Pine.LNX.4.44.0312071236430.1283-100000@logos.cnet>
Subject: Re: 2.4.23 hard lock, 100% reproducible.
Date: Sun, 7 Dec 2003 15:18:24 -0800
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

> 
> The first oops looks like:
> 
> Unable to handle kernel NULL pointer
> dereference at virtual address: 00000000
> 
[...]
> 
> 
> Isnt it a bit weird that the full backtrace is not reported ? 
> 
> wli suggests that might stack corruption.
> 

My bad - wrote it down by hand originally since 
it was locked hard.  

> 
> I dont see any suspicious change around tcp_print_conntrack().
> 
> Any clues? 
> 

I'm using ipchains compatability in there, looks like 
this is a possible cause - getting a patch right now,
will test and let y'all know (and then switch to 
iptables, finally). 

-- 
Mark

