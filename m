Return-Path: <linux-kernel-owner+w=401wt.eu-S1758807AbWLIWTm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758807AbWLIWTm (ORCPT <rfc822;w@1wt.eu>);
	Sat, 9 Dec 2006 17:19:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758839AbWLIWTm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Dec 2006 17:19:42 -0500
Received: from gate.crashing.org ([63.228.1.57]:55723 "EHLO gate.crashing.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758807AbWLIWTm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Dec 2006 17:19:42 -0500
Subject: Re: [PATCH] WorkStruct: Use direct assignment rather than cmpxchg()
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: David Howells <dhowells@redhat.com>
Cc: Linux Kernel list <linux-kernel@vger.kernel.org>
In-Reply-To: <200612092059.kB9Kx1NC010199@hera.kernel.org>
References: <200612092059.kB9Kx1NC010199@hera.kernel.org>
Content-Type: text/plain
Date: Sun, 10 Dec 2006 09:19:36 +1100
Message-Id: <1165702776.1103.162.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>     The problem is where we end up tangling with test_and_set_bit() emulated
>     using spinlocks, and even then it's not a problem _provided_
>     test_and_set_bit() doesn't attempt to modify the word if the bit was
>     set.

I'm not 100% sure what is the problem there, but beware that bitops
don't provide the same semantics as spinlocks regarding memory ordering.

Ben.


