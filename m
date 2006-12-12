Return-Path: <linux-kernel-owner+w=401wt.eu-S964780AbWLLXE3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964780AbWLLXE3 (ORCPT <rfc822;w@1wt.eu>);
	Tue, 12 Dec 2006 18:04:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964781AbWLLXE3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Dec 2006 18:04:29 -0500
Received: from ozlabs.org ([203.10.76.45]:49098 "EHLO ozlabs.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S964780AbWLLXE2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Dec 2006 18:04:28 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17791.13647.329912.557434@cargo.ozlabs.ibm.com>
Date: Wed, 13 Dec 2006 10:03:43 +1100
From: Paul Mackerras <paulus@samba.org>
To: Russell King <rmk+lkml@arm.linux.org.uk>
Cc: David Howells <dhowells@redhat.com>, torvalds@osdl.org, akpm@osdl.org,
       davem@davemloft.com, matthew@wil.cx, linux-kernel@vger.kernel.org,
       linux-arch@vger.kernel.org
Subject: Re: [PATCH 1/2] WorkStruct: Add assign_bits() to give an atomic-bitops safe assignment
In-Reply-To: <20061212225443.GA25902@flint.arm.linux.org.uk>
References: <20061212201112.29817.22041.stgit@warthog.cambridge.redhat.com>
	<20061212225443.GA25902@flint.arm.linux.org.uk>
X-Mailer: VM 7.19 under Emacs 21.4.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Russell King writes:

> Why can't we just use atomic_t for this?

On 64-bit platforms, atomic_t tends to be 4 bytes, whereas bitops work
on arrays of unsigned long, i.e. multiples of 8 bytes.  We could
use atomic_long_t for this, however.

Paul.
