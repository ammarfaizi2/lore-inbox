Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1163386AbWLGVQS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1163386AbWLGVQS (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Dec 2006 16:16:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1163384AbWLGVQR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Dec 2006 16:16:17 -0500
Received: from mx1.redhat.com ([66.187.233.31]:39821 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1163377AbWLGVQQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Dec 2006 16:16:16 -0500
From: David Howells <dhowells@redhat.com>
In-Reply-To: <1165525597.4698.46.camel@mulgrave.il.steeleye.com> 
References: <1165525597.4698.46.camel@mulgrave.il.steeleye.com>  <20061207085409.228016a2.akpm@osdl.org> <20061207153138.28408.94099.stgit@warthog.cambridge.redhat.com> <20061207153143.28408.7274.stgit@warthog.cambridge.redhat.com> <639.1165521999@redhat.com> 
To: James Bottomley <James.Bottomley@SteelEye.com>
Cc: David Howells <dhowells@redhat.com>, Andrew Morton <akpm@osdl.org>,
       torvalds@osdl.org, davem@davemloft.com, wli@holomorphy.com,
       matthew@wil.cx, linux-kernel@vger.kernel.org,
       linux-arch@vger.kernel.org
Subject: Re: [PATCH 3/3] WorkStruct: Use direct assignment rather than cmpxchg() 
X-Mailer: MH-E 8.0; nmh 1.1; GNU Emacs 22.0.50
Date: Thu, 07 Dec 2006 21:16:03 +0000
Message-ID: <10660.1165526163@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

James Bottomley <James.Bottomley@SteelEye.com> wrote:

> That we'd have to put a conditional jump in there is an incorrect
> assumption on risc machines.

I didn't say we would *have* to put a conditional jump in there.  But I don't
know that I it can be avoided on all archs.

I don't know that sparc32 can do conditional instructions for example.  If we
force this assumption it becomes a potential limitation on the archs we can
support.  OTOH, it may be that every arch that supports SMP and has to emulate
bitops with spinlocks also supports conditional stores; but I don't know that.

David
