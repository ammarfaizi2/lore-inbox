Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265238AbUFAV3R@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265238AbUFAV3R (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Jun 2004 17:29:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265243AbUFAV3R
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Jun 2004 17:29:17 -0400
Received: from mx1.redhat.com ([66.187.233.31]:39864 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S265238AbUFAV3O (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Jun 2004 17:29:14 -0400
Date: Tue, 1 Jun 2004 14:28:04 -0700
From: "David S. Miller" <davem@redhat.com>
To: Anton Blanchard <anton@samba.org>
Cc: ak@muc.de, linux-kernel@vger.kernel.org, arnd@arndb.de
Subject: Re: compat syscall args
Message-Id: <20040601142804.729cbd7b.davem@redhat.com>
In-Reply-To: <20040601170418.GA4239@krispykreme>
References: <21hGW-h5-5@gated-at.bofh.it>
	<229Hi-B1-11@gated-at.bofh.it>
	<22drH-3Bc-47@gated-at.bofh.it>
	<22dL7-3O8-39@gated-at.bofh.it>
	<m38yf7juj6.fsf@averell.firstfloor.org>
	<20040601170418.GA4239@krispykreme>
X-Mailer: Sylpheed version 0.9.10 (GTK+ 1.2.10; sparc-unknown-linux-gnu)
X-Face: "_;p5u5aPsO,_Vsx"^v-pEq09'CU4&Dc1$fQExov$62l60cgCc%FnIwD=.UF^a>?5'9Kn[;433QFVV9M..2eN.@4ZWPGbdi<=?[:T>y?SD(R*-3It"Vj:)"dP
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2 Jun 2004 03:04:18 +1000
Anton Blanchard <anton@samba.org> wrote:

> > It would be better to do this consistently over all architectures
> > and do the sign extension (which is much less common than zero
> > extension) always in C code. Then when someone adds a new compat
> > handler the chances are high that it will just work over multiple
> > architectures (ok minus s390) without much more changes. 
> 
> On ppc64 we now zero extend all arguments. I too would like to see the
> sign extension done in the common compat code, at the moment we have to
> be careful to do it before calling compat code.

Ok, I'm doing some auditing of the sparc64 compat syscall table
and all the args to the syscalls.  I'll take this thread further
after I'm done with that.

Sit tight.
