Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030190AbWKEEnk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030190AbWKEEnk (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Nov 2006 23:43:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030195AbWKEEnk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Nov 2006 23:43:40 -0500
Received: from ozlabs.org ([203.10.76.45]:15582 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S1030190AbWKEEnj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Nov 2006 23:43:39 -0500
Subject: Re: [PATCH 1/7] paravirtualization: header and stubs
	for	paravirtualizing critical operations
From: Rusty Russell <rusty@rustcorp.com.au>
To: Andi Kleen <ak@suse.de>
Cc: Zachary Amsden <zach@vmware.com>, Chris Wright <chrisw@sous-sol.org>,
       virtualization@lists.osdl.org, linux-kernel@vger.kernel.org,
       akpm@osdl.org
In-Reply-To: <200611032209.40235.ak@suse.de>
References: <20061029024504.760769000@sous-sol.org>
	 <200611030356.54074.ak@suse.de> <454BA7F7.8030205@vmware.com>
	 <200611032209.40235.ak@suse.de>
Content-Type: text/plain
Date: Sun, 05 Nov 2006 15:43:35 +1100
Message-Id: <1162701815.29777.6.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-11-03 at 22:09 +0100, Andi Kleen wrote:
> > 
> > Sounds like desc.h got reordered.  Somewhere, there was a broken patch 
> > once that did this, I thought we fixed that.
> 
> I think I got Rusty's latest patches that I found in my mailbox.
> 
> I haven't looked at desc.h, but at least processor.h ordering was totally
> b0rken (e.g. #define __cpuid native_cpuid was after several uses). I fixed
> that to make at least the CONFIG_PARAVIRT not set case compile.
> 
> I can't see how this ever worked either.
> 
> Haven't attempted the CONFIG_PARAVIRT case which apparently needs more work
> (it is currently marked CONFIG_BROKEN) 
> 
> Can someone double check this is the correct patchkit?
> 
> ftp://ftp.frstfloor.org/pub/ak/x86_64/quilt/patches/paravirt*

Andi, the patches work against Andrew's tree, and he's merged them in
rc4-mm2.  There are a few warnings to clean up, but it seems basically
sound.

At this point I our think time is better spent on beating those patches
up, rather than going back and figuring out why they don't work in your
tree.

Sorry,
Rusty.


