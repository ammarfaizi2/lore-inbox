Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751103AbWCaRpa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751103AbWCaRpa (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 31 Mar 2006 12:45:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751152AbWCaRpa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 31 Mar 2006 12:45:30 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:54468 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S1751103AbWCaRp3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 31 Mar 2006 12:45:29 -0500
Date: Fri, 31 Mar 2006 09:45:18 -0800 (PST)
From: Christoph Lameter <clameter@sgi.com>
To: Andi Kleen <ak@suse.de>
cc: Zoltan Menyhart <Zoltan.Menyhart@bull.net>,
       "Boehm, Hans" <hans.boehm@hp.com>,
       "Grundler, Grant G" <grant.grundler@hp.com>,
       "Chen, Kenneth W" <kenneth.w.chen@intel.com>, akpm@osdl.org,
       linux-kernel@vger.kernel.org, linux-ia64@vger.kernel.org
Subject: Re: Synchronizing Bit operations V2
In-Reply-To: <p73vetu921a.fsf@verdi.suse.de>
Message-ID: <Pine.LNX.4.64.0603310943480.6628@schroedinger.engr.sgi.com>
References: <Pine.LNX.4.64.0603301300430.1014@schroedinger.engr.sgi.com>
 <Pine.LNX.4.64.0603301615540.2023@schroedinger.engr.sgi.com>
 <p73vetu921a.fsf@verdi.suse.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 31 Mar 2006, Andi Kleen wrote:

> Christoph Lameter <clameter@sgi.com> writes:
> > MODE_BARRIER
> > 	An atomic operation that is guaranteed to occur between
> > 	previous and later memory operations.
> I think it's a bad idea to create such an complicated interface.
> The chances that an average kernel coder will get these right are
> quite small. And it will be 100% untested outside IA64 I guess
> and thus likely be always slightly buggy as kernel code continues
> to change.

Powerpc can do similar things AFAIK. Not sure what other arches have 
finer grained control over barriers but it could cover a lot of special 
cases for other processors as well.

