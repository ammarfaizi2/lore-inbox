Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267611AbSLFFzn>; Fri, 6 Dec 2002 00:55:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267612AbSLFFzm>; Fri, 6 Dec 2002 00:55:42 -0500
Received: from willy.net1.nerim.net ([62.212.114.60]:6664 "EHLO www.home.local")
	by vger.kernel.org with ESMTP id <S267611AbSLFFzm>;
	Fri, 6 Dec 2002 00:55:42 -0500
Date: Fri, 6 Dec 2002 07:01:35 +0100
From: Willy Tarreau <willy@w.ods.org>
To: Roberto Nibali <ratz@drugphish.ch>
Cc: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: Re: hidden interface (ARP) 2.4.20
Message-ID: <20021206060135.GC21070@alpha.home.local>
References: <A6B0BFA3B496A24488661CC25B9A0EFA333DEF@himl07.hickam.pacaf.ds.af.mil> <1039124530.18881.0.camel@rth.ninka.net> <20021205140349.A5998@ns1.theoesters.com> <3DEFD845.1000600@drugphish.ch> <20021205154822.A6762@ns1.theoesters.com> <3DEFE86A.8060906@drugphish.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3DEFE86A.8060906@drugphish.ch>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 06, 2002 at 12:59:38AM +0100, Roberto Nibali wrote:
<snip>
> Oops, right. I forgot the HW LBs that do triangulation. I wonder 
> however, why one wants to use a HW LB and not configure it to work in 
> NAT mode.

Because when you have to deal with thousands of session per second, NAT is
really a pain in the ass. When you have to consider security, NAT is a pain
too because it makes end to end tracking much more difficult when you deal with
multiple proxy levels. And last but not least, there are protocols that don't
like NAT. Simply think about a farm of FTP servers. It's really easy to
load-balance internet clients on it with redirection (call it as you like) using
a hash algorithm. NAT would be more difficult.

I personnaly suggested and used both NAT and redirection at a big customer's
site. NAT was there only to be compatible with broken systems that would never
handle redirection right, in the event we would have to use them. But at the
moment it's already the first source of architectural problems.

Cheers,
Willy

