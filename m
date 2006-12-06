Return-Path: <linux-kernel-owner+willy=40w.ods.org-S937566AbWLFTqh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S937566AbWLFTqh (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Dec 2006 14:46:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S937568AbWLFTqg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Dec 2006 14:46:36 -0500
Received: from mx1.redhat.com ([66.187.233.31]:50116 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S937566AbWLFTqf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Dec 2006 14:46:35 -0500
From: David Howells <dhowells@redhat.com>
In-Reply-To: <Pine.LNX.4.64.0612061130030.3542@woody.osdl.org> 
References: <Pine.LNX.4.64.0612061130030.3542@woody.osdl.org>  <20061206164314.19870.33519.stgit@warthog.cambridge.redhat.com> <Pine.LNX.4.64.0612061054360.27047@schroedinger.engr.sgi.com> <Pine.LNX.4.64.0612061103260.3542@woody.osdl.org> <20061206192647.GW3013@parisc-linux.org> 
To: Linus Torvalds <torvalds@osdl.org>
Cc: Matthew Wilcox <matthew@wil.cx>, Christoph Lameter <clameter@sgi.com>,
       Russell King <rmk+lkml@arm.linux.org.uk>,
       David Howells <dhowells@redhat.com>, Andrew Morton <akpm@osdl.org>,
       linux-arm-kernel@lists.arm.linux.org.uk,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-arch@vger.kernel.org
Subject: Re: [PATCH] WorkStruct: Implement generic UP cmpxchg() where an arch doesn't support it 
X-Mailer: MH-E 8.0; nmh 1.1; GNU Emacs 22.0.50
Date: Wed, 06 Dec 2006 19:45:40 +0000
Message-ID: <28631.1165434340@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds <torvalds@osdl.org> wrote:

> Also, I don't see quite why you think "cmpxchg()" and "atomic_cmpxchg()" 
> would be different. ANY cmpxchg() needs to be atomic - if it's not, 
> there's no point to the operation at all, since you'd just write it as

It's not that atomic_cmpxchg() is different to cmpxchg(), it's that
atomic_set() is different to direct assignment.

atomic_set() on PA-RISC, for example, has spinlocks in it.

David
