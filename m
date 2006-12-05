Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1759760AbWLEVsX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759760AbWLEVsX (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Dec 2006 16:48:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759819AbWLEVsX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Dec 2006 16:48:23 -0500
Received: from gate.crashing.org ([63.228.1.57]:57071 "EHLO gate.crashing.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758499AbWLEVsG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Dec 2006 16:48:06 -0500
Subject: Re: [PATCH 0/3] New firewire stack
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Stefan Richter <stefanr@s5r6.in-berlin.de>
Cc: Kristian =?ISO-8859-1?Q?H=F8gsberg?= <krh@redhat.com>,
       David Miller <davem@davemloft.net>, linux-kernel@vger.kernel.org,
       linux1394-devel@lists.sourceforge.net
In-Reply-To: <4575BF51.1070109@s5r6.in-berlin.de>
References: <20061205052229.7213.38194.stgit@dinky.boston.redhat.com>
	 <1165297363.29784.54.camel@localhost.localdomain>
	 <20061204.230502.35014139.davem@davemloft.net>
	 <4575A170.2030805@redhat.com>  <4575BF51.1070109@s5r6.in-berlin.de>
Content-Type: text/plain; charset=utf-8
Date: Wed, 06 Dec 2006 08:41:49 +1100
Message-Id: <1165354909.5469.11.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.1 
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-12-05 at 19:49 +0100, Stefan Richter wrote:
> Kristian Høgsberg wrote:
> > David Miller wrote:
> >> From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> >>>  DO NOT USE BITFIELDS FOR DATA ON THE WIRE !!!
> 
> Actually we do so in some places of the existing FireWire drivers.
> Didn't go wrong so far. :-)

Yeah, because you used 

#if defined __BIG_ENDIAN_BITFIELD

and

#if defined __LITTLE_ENDIAN_BITFIELD

which relies on the fact that it -seems- that by luck, gcc only has two
representations around and they match little/big endian archs (though
have we verified that is always correct, especially between 32 and 64
bits archs ?)

It's still wrong to do.

Cheers,
Ben.


