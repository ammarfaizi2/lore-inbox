Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262040AbTJNVmj (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Oct 2003 17:42:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262114AbTJNVmj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Oct 2003 17:42:39 -0400
Received: from willy.net1.nerim.net ([62.212.114.60]:16659 "EHLO
	www.home.local") by vger.kernel.org with ESMTP id S262040AbTJNVmh
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Oct 2003 17:42:37 -0400
Date: Tue, 14 Oct 2003 23:42:31 +0200
From: Willy Tarreau <willy@w.ods.org>
To: Javier Govea <jgovea@magma.ca>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Source ports at the  IP layer
Message-ID: <20031014214231.GC16761@alpha.home.local>
References: <200310142113.h9ELDsAp002223@webmail1.magma.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200310142113.h9ELDsAp002223@webmail1.magma.ca>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 
> I also tried  
> struct tcphdr *th = (struct tcphdf *)skb->h.th;
> and then printing out th->source...but i'm still getting 17664...any suggestion on how I
> can get the ports??? All ideas are very very welcome...

I think you forgot to add the IP header length somewhere, because 17664 is
0x4500 = the start of your IP header, and not the TCP header.

Cheers,
Willy

