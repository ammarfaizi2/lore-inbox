Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932108AbWFLTPx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932108AbWFLTPx (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Jun 2006 15:15:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932107AbWFLTPw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Jun 2006 15:15:52 -0400
Received: from omx1-ext.sgi.com ([192.48.179.11]:28829 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S932108AbWFLTPv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Jun 2006 15:15:51 -0400
Date: Mon, 12 Jun 2006 12:15:33 -0700 (PDT)
From: Christoph Lameter <clameter@sgi.com>
To: Andi Kleen <ak@suse.de>
cc: Ingo Molnar <mingo@elte.hu>,
       Michal Piotrowski <michal.k.k.piotrowski@gmail.com>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: broken local_t on i386
In-Reply-To: <200606122011.52841.ak@suse.de>
Message-ID: <Pine.LNX.4.64.0606121212510.20259@schroedinger.engr.sgi.com>
References: <20060609214024.2f7dd72c.akpm@osdl.org> <200606121955.47803.ak@suse.de>
 <Pine.LNX.4.64.0606121156460.20195@schroedinger.engr.sgi.com>
 <200606122011.52841.ak@suse.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 12 Jun 2006, Andi Kleen wrote:

> > I thought you had some funky segment registers on i386 and x86_64. Cant
> > they be switched on context switch? If an inc/dec could work relative to
> > those then you would not need a virtual mapping.
> 
> The segment register needs an offset. So you need the linker to generate
> the offset from the base of the per cpu segment somehow. At compile time the 
> address is not known so it cannot be done then.

Define something like a big struct and use offsetof?

So the compiler is not able to generate an offset to the beginning of a 
data segment? 
