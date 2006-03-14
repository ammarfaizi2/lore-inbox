Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751613AbWCNUcG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751613AbWCNUcG (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Mar 2006 15:32:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751814AbWCNUcG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Mar 2006 15:32:06 -0500
Received: from mx1.redhat.com ([66.187.233.31]:19143 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1751613AbWCNUcF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Mar 2006 15:32:05 -0500
From: David Howells <dhowells@redhat.com>
In-Reply-To: <878xrecypp.fsf@javad.com> 
References: <878xrecypp.fsf@javad.com>  <16835.1141936162@warthog.cambridge.redhat.com> 
To: Sergei Organov <osv@javad.com>
Cc: David Howells <dhowells@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Document Linux's memory barriers [try #4] 
X-Mailer: MH-E 7.92+cvs; nmh 1.1; GNU Emacs 22.0.50.4
Date: Tue, 14 Mar 2006 20:31:57 +0000
Message-ID: <31016.1142368317@warthog.cambridge.redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sergei Organov <osv@javad.com> wrote:

> "You can prevent an `asm' instruction from being deleted by writing the
> keyword `volatile' after the `asm'. [...]
> The `volatile' keyword indicates that the instruction has important
> side-effects.  GCC will not delete a volatile `asm' if it is reachable.
> (The instruction can still be deleted if GCC can prove that
> control-flow will never reach the location of the instruction.)  *Note
> that even a volatile `asm' instruction can be moved relative to other
> code, including across jump instructions.*"

Ummm... If "asm volatile" statements don't form compiler barriers, then how do
you specify a compiler barrier? Or is that what the "memory" bit in:

	#define barrier() __asm__ __volatile__("": : :"memory")

does?

David
