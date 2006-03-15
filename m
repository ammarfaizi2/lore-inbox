Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932160AbWCOBM1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932160AbWCOBM1 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Mar 2006 20:12:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932179AbWCOBM1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Mar 2006 20:12:27 -0500
Received: from saraswathi.solana.com ([198.99.130.12]:10400 "EHLO
	saraswathi.solana.com") by vger.kernel.org with ESMTP
	id S932160AbWCOBM0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Mar 2006 20:12:26 -0500
Date: Tue, 14 Mar 2006 20:13:12 -0500
From: Jeff Dike <jdike@addtoit.com>
To: Pavel Machek <pavel@ucw.cz>
Cc: Chuck Ebbert <76306.1226@compuserve.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Roland McGrath <roland@redhat.com>, Linus Torvalds <torvalds@osdl.org>
Subject: Re: What is ptrace flag PT_TRACESYSGOOD for?
Message-ID: <20060315011312.GA9410@ccure.user-mode-linux.org>
References: <200603140531_MC3-1-BAA0-B3C3@compuserve.com> <20060314230056.GA1579@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060314230056.GA1579@elf.ucw.cz>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 15, 2006 at 12:00:56AM +0100, Pavel Machek wrote:
> Yes.. and unless you deliver ptrace() syscall stops with different
> signal, you can't tell difference between syscall stop and real
> SIGTRAP.

You can, but you have to examine registers in order to do this.  This
is a concern when running gdb inside UML.  gdb breakpoints will cause
real SIGTRAPs, while system calls cause synthetic ones.  Before
switching to TRACESYS_GOOD, UML examined orig_eax to distinguish
between them.

				Jeff
