Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277581AbRJREDU>; Thu, 18 Oct 2001 00:03:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277585AbRJREDK>; Thu, 18 Oct 2001 00:03:10 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:32701 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S277581AbRJRECw>;
	Thu, 18 Oct 2001 00:02:52 -0400
Date: Thu, 18 Oct 2001 00:03:25 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: linux-kernel@vger.kernel.org
Subject: Re: MODULE_LICENSE and EXPORT_SYMBOL_GPL
In-Reply-To: <8658.1003375433@kao2.melbourne.sgi.com>
Message-ID: <Pine.GSO.4.21.0110172353530.18689-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 18 Oct 2001, Keith Owens wrote:

> EXPORT_SYMBOL_GPL() may only be used for new exported symbols, Linus
> has spoken.  I believe the phrase involved killer penguins with
> chainsaws for anybody who changed existing exported interfaces.

... and if somebody thinks that replacing

int foo(void *bar);
plus
EXPORT_SYMBOL(foo);

with

int __foo(void *bar, int baz);
static int foo(void *bar)
{
	return __foo(bar, 0);
}
plus
EXPORT_SYMBOL_GPL(__foo);

is going to save you from aforementioned killer penguins, keep in mind
that there are worse and slower ways to go and you might not like learning
them first-hand.

				Al "have pincer, will travel" Viro

