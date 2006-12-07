Return-Path: <linux-kernel-owner+willy=40w.ods.org-S937930AbWLGBhB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S937930AbWLGBhB (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Dec 2006 20:37:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S937927AbWLGBhB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Dec 2006 20:37:01 -0500
Received: from smtp.osdl.org ([65.172.181.25]:35210 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S937925AbWLGBhA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Dec 2006 20:37:00 -0500
Date: Wed, 6 Dec 2006 17:36:29 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Roman Zippel <zippel@linux-m68k.org>
cc: Matthew Wilcox <matthew@wil.cx>, Christoph Lameter <clameter@sgi.com>,
       David Howells <dhowells@redhat.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Subject: Re: [PATCH] WorkStruct: Implement generic UP cmpxchg() where an arch
 doesn't support it
In-Reply-To: <Pine.LNX.4.64.0612070219540.1867@scrub.home>
Message-ID: <Pine.LNX.4.64.0612061735150.3542@woody.osdl.org>
References: <20061206164314.19870.33519.stgit@warthog.cambridge.redhat.com>
 <Pine.LNX.4.64.0612061054360.27047@schroedinger.engr.sgi.com>
 <20061206190025.GC9959@flint.arm.linux.org.uk>
 <Pine.LNX.4.64.0612061111130.27263@schroedinger.engr.sgi.com>
 <20061206195820.GA15281@flint.arm.linux.org.uk> <20061206213626.GE3013@parisc-linux.org>
 <Pine.LNX.4.64.0612061345160.28672@schroedinger.engr.sgi.com>
 <20061206220532.GF3013@parisc-linux.org> <Pine.LNX.4.64.0612070130240.1868@scrub.home>
 <Pine.LNX.4.64.0612061650240.3542@woody.osdl.org> <Pine.LNX.4.64.0612070203520.1867@scrub.home>
 <Pine.LNX.4.64.0612061717030.3542@woody.osdl.org> <Pine.LNX.4.64.0612070219540.1867@scrub.home>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 7 Dec 2006, Roman Zippel wrote:
>
> m68060 produces a trap for unaligned atomic access, unfortunately standard 
> alignment is smaller than this.

Umm. on 68060, since it's 32-bit, you'd only have the 32-bit case. Are you 
saying that you can't do a 32-bit atomic access at any 32-bit aligned 
boundary? Or are you saying that gcc aligns normal 32-bit entities at 
16-bit alignment? Neither of those sound very likely.

		Linus
