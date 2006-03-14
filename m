Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750775AbWCNUfL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750775AbWCNUfL (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Mar 2006 15:35:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750816AbWCNUfL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Mar 2006 15:35:11 -0500
Received: from mx1.redhat.com ([66.187.233.31]:46026 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1750775AbWCNUfJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Mar 2006 15:35:09 -0500
From: David Howells <dhowells@redhat.com>
In-Reply-To: <878xrecypp.fsf@javad.com> 
References: <878xrecypp.fsf@javad.com>  <16835.1141936162@warthog.cambridge.redhat.com> 
To: Sergei Organov <osv@javad.com>
Cc: David Howells <dhowells@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Document Linux's memory barriers [try #4] 
X-Mailer: MH-E 7.92+cvs; nmh 1.1; GNU Emacs 22.0.50.4
Date: Tue, 14 Mar 2006 20:35:07 +0000
Message-ID: <31079.1142368507@warthog.cambridge.redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sergei Organov <osv@javad.com> wrote:

> > +In addition, accesses to "volatile" memory locations and volatile asm
> > +statements act as implicit compiler barriers.
> 
> This last statement seems to contradict with what GCC manual says about
> volatile asm statements:

Perhaps I should say "compiler memory barrier", since it doesn't prevent
instructions from being moved, but rather merely affects the ordering of
memory accesses and volatile instructions.

Hmmm... Is atomic_read() a compiler memory barrier? It isn't a CPU memory
barrier, but it does touch explicitly volatile memory.

David
