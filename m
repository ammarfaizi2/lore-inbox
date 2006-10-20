Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932280AbWJTROE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932280AbWJTROE (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Oct 2006 13:14:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932281AbWJTROD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Oct 2006 13:14:03 -0400
Received: from e6.ny.us.ibm.com ([32.97.182.146]:55528 "EHLO e6.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S932280AbWJTRN6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Oct 2006 13:13:58 -0400
Subject: Re: kernel BUG in __cache_alloc_node at
	linux-2.6.git/mm/slab.c:3177!
From: Will Schmidt <will_schmidt@vnet.ibm.com>
Reply-To: will_schmidt@vnet.ibm.com
To: Andy Whitcroft <apw@shadowen.org>
Cc: Paul Mackerras <paulus@samba.org>, Christoph Lameter <clameter@sgi.com>,
       Anton Blanchard <anton@samba.org>, akpm@osdl.org,
       linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org,
       Mel Gorman <mel@csn.ul.ie>, Mike Kravetz <kravetz@us.ibm.com>
In-Reply-To: <4538F2A2.5040305@shadowen.org>
References: <1161026409.31903.15.camel@farscape>
	 <Pine.LNX.4.64.0610161221300.6908@schroedinger.engr.sgi.com>
	 <1161031821.31903.28.camel@farscape>
	 <Pine.LNX.4.64.0610161630430.8341@schroedinger.engr.sgi.com>
	 <17717.50596.248553.816155@cargo.ozlabs.ibm.com>
	 <Pine.LNX.4.64.0610180811040.27096@schroedinger.engr.sgi.com>
	 <17718.39522.456361.987639@cargo.ozlabs.ibm.com>
	 <Pine.LNX.4.64.0610181448250.30710@schroedinger.engr.sgi.com>
	 <17719.1849.245776.4501@cargo.ozlabs.ibm.com>
	 <Pine.LNX.4.64.0610190906490.7852@schroedinger.engr.sgi.com>
	 <20061019163044.GB5819@krispykreme>
	 <Pine.LNX.4.64.0610190947110.8310@schroedinger.engr.sgi.com>
	 <17719.64246.555371.701194@cargo.ozlabs.ibm.com>
	 <Pine.LNX.4.64.0610191527040.10880@schroedinger.engr.sgi.com>
	 <17720.30804.180390.197567@cargo.ozlabs.ibm.com>
	 <4538DACC.5050605@shadowen.org>  <4538F2A2.5040305@shadowen.org>
Content-Type: text/plain
Organization: IBM
Date: Fri, 20 Oct 2006 12:13:49 -0500
Message-Id: <1161364430.8946.67.camel@farscape>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-20-10 at 17:00 +0100, Andy Whitcroft wrote:
> Andy Whitcroft wrote:
> > Paul Mackerras wrote:
> >> Christoph Lameter writes:

> Ok, I've just gotten a successful boot on this box for the first time in
> like 15 git releases.  I needed the three patches below:
> 
> clameter-fallback_alloc_fix2 -- from earlier in this thread, under the
> message ID below:
>     <Pine.LNX.4.64.0610131515200.28279@schroedinger.engr.sgi.com>
> 
> Reintroduce-NODES_SPAN_OTHER_NODES-for-powerpc -- the patch I just
> submitted, under the message ID below:
>     <8a76dfd735e544016c5f04c98617b87d@pinky>
> 
> ibmveth-fix-index-increment-calculation -- this patch is already in -mm.
> 
> Feel free to take this as an ACK for the patches other than mine.
> 
> Acked-by: Andy Whitcroft <apw@shadowen.org>
> 
> -apw

I've applied these three blobs to the linux-2.6.git tree and verified
that it does fix the problem.        
And a "Thanks!" to Christoph for being responsive.. even when the
problem wasnt introduced by him. :)

Acked-by: Will Schmidt <will_schmidt@vnet.ibm.com>




