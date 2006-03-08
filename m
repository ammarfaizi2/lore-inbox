Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030191AbWCHRUB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030191AbWCHRUB (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Mar 2006 12:20:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964811AbWCHRUB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Mar 2006 12:20:01 -0500
Received: from mx1.redhat.com ([66.187.233.31]:20613 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S964799AbWCHRUA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Mar 2006 12:20:00 -0500
From: David Howells <dhowells@redhat.com>
In-Reply-To: <20060308154157.GI7301@parisc-linux.org> 
References: <20060308154157.GI7301@parisc-linux.org>  <31492.1141753245@warthog.cambridge.redhat.com> <29826.1141828678@warthog.cambridge.redhat.com> <20060308145506.GA5095@devserv.devel.redhat.com> 
To: Matthew Wilcox <matthew@wil.cx>
Cc: Alan Cox <alan@redhat.com>, David Howells <dhowells@redhat.com>,
       torvalds@osdl.org, akpm@osdl.org, mingo@redhat.com,
       linux-arch@vger.kernel.org, linuxppc64-dev@ozlabs.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Document Linux's memory barriers [try #2] 
X-Mailer: MH-E 7.92+cvs; nmh 1.1; GNU Emacs 22.0.50.4
Date: Wed, 08 Mar 2006 17:19:41 +0000
Message-ID: <10095.1141838381@warthog.cambridge.redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Matthew Wilcox <matthew@wil.cx> wrote:

> > That might be worth an example with an if() because PPC will do this and
> > if its a read with a side effect (eg I/O space) you get singed..
> 
> PPC does speculative memory accesses to IO?  Are you *sure*?

Can you do speculative reads from frame buffers?

> # define smp_read_barrier_depends()     do { } while(0)

What's this one meant to do?

> Port space is deprecated though.  PCI 2.3 says:

That's sort of irrelevant for the here. I still need to document the
interaction.

> Since memory write transactions may be posted in bridges anywhere
> in the system, and I/O writes may be posted in the host bus bridge,

I'm not sure whether this is beyond the scope of this document. Maybe the
document's scope needs to be expanded.

David
