Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318872AbSH1PlE>; Wed, 28 Aug 2002 11:41:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318875AbSH1PlD>; Wed, 28 Aug 2002 11:41:03 -0400
Received: from c-24-245-33-253.mn.client2.attbi.com ([24.245.33.253]:56073
	"EHLO rmholt.homeip.net") by vger.kernel.org with ESMTP
	id <S318872AbSH1PlD>; Wed, 28 Aug 2002 11:41:03 -0400
Date: Wed, 28 Aug 2002 10:45:19 -0500 (CDT)
From: Robin Holt <holt@rmholt.homeip.net>
Reply-To: rmholt@bigfoot.com
To: linux-kernel@vger.kernel.org
Subject: Re: atomic64_t proposal
Message-ID: <Pine.LNX.4.44.0208281040010.14946-100000@rmholt.homeip.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I do like the atomic_inc, atomic_dec, etc being able to handle either 
type.  While producing code, I can do a simple check at the beginning of 
the block and define the appropriate type for a particular architecture.

For instance:

#if ARCH_WORD_SIZE == 8
atomic64_t my_atomic;
#else
atomic_t my_atomic;
#endif

Without it, I end up doing alot of other magic.  I don't see a problem 
with having the #defines versus the inlines.  Why have two chunks of code 
which do exactly the same operations with only type differences?

Robin Holt

