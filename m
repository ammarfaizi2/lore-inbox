Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262695AbTJPEWf (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Oct 2003 00:22:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262705AbTJPEWf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Oct 2003 00:22:35 -0400
Received: from modemcable137.219-201-24.mtl.mc.videotron.ca ([24.201.219.137]:40833
	"EHLO montezuma.fsmlabs.com") by vger.kernel.org with ESMTP
	id S262695AbTJPEWf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Oct 2003 00:22:35 -0400
Date: Thu, 16 Oct 2003 00:22:14 -0400 (EDT)
From: Zwane Mwaikambo <zwane@arm.linux.org.uk>
To: Andrew Morton <akpm@osdl.org>
cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH][2.6] constant_test_bit doesn't like my gcc
In-Reply-To: <20031015212134.41a427d3.akpm@osdl.org>
Message-ID: <Pine.LNX.4.53.0310160020060.2328@montezuma.fsmlabs.com>
References: <Pine.LNX.4.53.0310152244330.2328@montezuma.fsmlabs.com>
 <20031015211012.5daac8fc.akpm@osdl.org> <Pine.LNX.4.53.0310160008530.2328@montezuma.fsmlabs.com>
 <20031015212134.41a427d3.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 15 Oct 2003, Andrew Morton wrote:

> >   static __inline__ int constant_test_bit(int nr, const volatile unsigned long * addr)
> >   {
> >  -	return ((1UL << (nr & 31)) & (((const volatile unsigned int *) addr)[nr >> 5])) != 0;
> >  +	return ((1UL << (nr & 31)) & (addr[nr >> 5])) != 0;
> >   }
> >  
> 
> Looks fine.  Does your compiler get this right? 

Yep, thanks.
