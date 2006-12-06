Return-Path: <linux-kernel-owner+willy=40w.ods.org-S937722AbWLFWQN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S937722AbWLFWQN (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Dec 2006 17:16:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S937709AbWLFWQN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Dec 2006 17:16:13 -0500
Received: from omx1-ext.sgi.com ([192.48.179.11]:59252 "EHLO omx1.sgi.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S937722AbWLFWQL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Dec 2006 17:16:11 -0500
Date: Wed, 6 Dec 2006 14:15:43 -0800 (PST)
From: Christoph Lameter <clameter@sgi.com>
To: Matthew Wilcox <matthew@wil.cx>
cc: David Howells <dhowells@redhat.com>, torvalds@osdl.org, akpm@osdl.org,
       linux-arm-kernel@lists.arm.linux.org.uk, linux-kernel@vger.kernel.org,
       linux-arch@vger.kernel.org
Subject: Re: [PATCH] WorkStruct: Implement generic UP cmpxchg() where an arch
 doesn't support it
In-Reply-To: <20061206220532.GF3013@parisc-linux.org>
Message-ID: <Pine.LNX.4.64.0612061413001.28987@schroedinger.engr.sgi.com>
References: <20061206164314.19870.33519.stgit@warthog.cambridge.redhat.com>
 <Pine.LNX.4.64.0612061054360.27047@schroedinger.engr.sgi.com>
 <20061206190025.GC9959@flint.arm.linux.org.uk>
 <Pine.LNX.4.64.0612061111130.27263@schroedinger.engr.sgi.com>
 <20061206195820.GA15281@flint.arm.linux.org.uk> <20061206213626.GE3013@parisc-linux.org>
 <Pine.LNX.4.64.0612061345160.28672@schroedinger.engr.sgi.com>
 <20061206220532.GF3013@parisc-linux.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 6 Dec 2006, Matthew Wilcox wrote:

> To be honest, it'd be much easier if we only defined these operations on
> atomic_t's.  We have all the infrastructure in place for them, and
> they're fairly well understood.  If you need different sizes, I'm OK
> with an atomic_pointer_t, or whatever.

An pointer is probably one of the most important entities to use with 
cmpxchg (aside from the ints and longs that we already support).

A pointer can be defined to point to any other type. So we would need
atomic_pointer_t(<type_pointed_to>)?
