Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264026AbUEHSTu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264026AbUEHSTu (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 8 May 2004 14:19:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264042AbUEHSTu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 8 May 2004 14:19:50 -0400
Received: from mx1.redhat.com ([66.187.233.31]:60324 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S264026AbUEHSTs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 8 May 2004 14:19:48 -0400
Date: Sat, 8 May 2004 11:19:22 -0700
From: "David S. Miller" <davem@redhat.com>
To: Linus Torvalds <torvalds@osdl.org>
Cc: akpm@osdl.org, manfred@colorfullife.com, davej@redhat.com,
       wli@holomorphy.com, linux-kernel@vger.kernel.org
Subject: Re: dentry bloat.
Message-Id: <20040508111922.02e2c2ec.davem@redhat.com>
In-Reply-To: <Pine.LNX.4.58.0405081019000.3271@ppc970.osdl.org>
References: <20040506200027.GC26679@redhat.com>
	<20040506150944.126bb409.akpm@osdl.org>
	<409B1511.6010500@colorfullife.com>
	<20040508012357.3559fb6e.akpm@osdl.org>
	<20040508022304.17779635.akpm@osdl.org>
	<20040508031159.782d6a46.akpm@osdl.org>
	<Pine.LNX.4.58.0405081019000.3271@ppc970.osdl.org>
X-Mailer: Sylpheed version 0.9.10 (GTK+ 1.2.10; sparc-unknown-linux-gnu)
X-Face: "_;p5u5aPsO,_Vsx"^v-pEq09'CU4&Dc1$fQExov$62l60cgCc%FnIwD=.UF^a>?5'9Kn[;433QFVV9M..2eN.@4ZWPGbdi<=?[:T>y?SD(R*-3It"Vj:)"dP
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 8 May 2004 10:28:29 -0700 (PDT)
Linus Torvalds <torvalds@osdl.org> wrote:

> > +	unsigned short len;
> > +} __attribute__((packed));
 ...
> I think you just made
> "name" be unaligned, which can cause serious problems. Because I think
> "packed" _also_ means that it doesn't honor the alignment of the thing
> when laying it out in structures.

That's correct, alignment concerns are thrown out the door once
you specify packed to the compiler.
