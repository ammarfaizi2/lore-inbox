Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262761AbVAQK7O@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262761AbVAQK7O (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Jan 2005 05:59:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262766AbVAQK7O
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Jan 2005 05:59:14 -0500
Received: from one.firstfloor.org ([213.235.205.2]:59847 "EHLO
	one.firstfloor.org") by vger.kernel.org with ESMTP id S262761AbVAQK7L
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Jan 2005 05:59:11 -0500
To: Tigran Aivazian <tigran@veritas.com>
Cc: linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@osdl.org>
Subject: Re: [discuss] booting a kernel compiled with -mregparm=0
References: <Pine.LNX.4.61.0501141623530.3526@ezer.homenet>
	<20050114205651.GE17263@kam.mff.cuni.cz>
	<Pine.LNX.4.61.0501141613500.6747@chaos.analogic.com>
	<cs9v6f$3tj$1@terminus.zytor.com>
	<Pine.LNX.4.61.0501170909040.4593@ezer.homenet>
From: Andi Kleen <ak@muc.de>
Date: Mon, 17 Jan 2005 11:59:09 +0100
In-Reply-To: <Pine.LNX.4.61.0501170909040.4593@ezer.homenet> (Tigran
 Aivazian's message of "Mon, 17 Jan 2005 09:30:17 +0000 (GMT)")
Message-ID: <m11xckwcci.fsf@muc.de>
User-Agent: Gnus/5.110002 (No Gnus v0.2) Emacs/21.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Tigran Aivazian <tigran@veritas.com> writes:
>
> When I said "2-3 weeks of work" I didn't fully realize the complexity
> of the problem. It is actually more like several months of research
> work and then (most likely) coming to the conclusion that the code to
> simulate the cpu (by disassembling the functions to track down where
> those registers went in each function) is just too complex to be
> written.

Did you actually ever read the ABI? 

The ABI supported way is to read the DWARF2 unwind tables. For that
you would a dwarf2 reader.  gdb does that in user space, and libgcc2
also does it for exception unwinding. IA64 has an in kernel dwarf2
reader library (and ia64 kdb uses it), although it would probably need
some work to make it work on x86-64.

So far nobody wanted it enough to do the porting work though.


-Andi
