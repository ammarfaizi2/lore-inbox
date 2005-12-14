Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932513AbVLNMUQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932513AbVLNMUQ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Dec 2005 07:20:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932510AbVLNMUP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Dec 2005 07:20:15 -0500
Received: from mx1.redhat.com ([66.187.233.31]:19104 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S932509AbVLNMUN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Dec 2005 07:20:13 -0500
Date: Wed, 14 Dec 2005 07:19:27 -0500
From: Jakub Jelinek <jakub@redhat.com>
To: David Howells <dhowells@redhat.com>
Cc: Arjan van de Ven <arjan@infradead.org>, Andrew Morton <akpm@osdl.org>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, cfriesen@nortel.com,
       torvalds@osdl.org, hch@infradead.org, matthew@wil.cx,
       linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Subject: Re: [PATCH 1/19] MUTEX: Introduce simple mutex implementation
Message-ID: <20051214121927.GY31785@devserv.devel.redhat.com>
Reply-To: Jakub Jelinek <jakub@redhat.com>
References: <dhowells1134431145@warthog.cambridge.redhat.com> <3874.1134480759@warthog.cambridge.redhat.com> <15167.1134488373@warthog.cambridge.redhat.com> <1134490205.11732.97.camel@localhost.localdomain> <1134556187.2894.7.camel@laptopd505.fenrus.org> <1134558188.25663.5.camel@localhost.localdomain> <1134558507.2894.22.camel@laptopd505.fenrus.org> <1134559470.25663.22.camel@localhost.localdomain> <20051214033536.05183668.akpm@osdl.org> <15412.1134561432@warthog.cambridge.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <15412.1134561432@warthog.cambridge.redhat.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 14, 2005 at 11:57:12AM +0000, David Howells wrote:
>  (1) Those that only have a limited exchange functionality. Several archs do
>      fall into this category: arm, frv, mn10300, 68000, i386.

sparc (32-bit CPUs) fall into this category too.  V7 CPUs have just
atomic load byte and store 0xff, later CPUs have swap insn, which is like
ia32 xchg.

>  (2) Those that have CMPXCHG or equivalent: 68020, i486+, x86_64, ia64, sparc.

sparc64 here.

>  (3) Those that have LL/SC or equivalent: mips (some), alpha, powerpc, arm6.

	Jakub
