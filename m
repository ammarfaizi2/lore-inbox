Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261183AbTINP5Z (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 14 Sep 2003 11:57:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261186AbTINP5Z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 14 Sep 2003 11:57:25 -0400
Received: from mail.jlokier.co.uk ([81.29.64.88]:18323 "EHLO
	mail.jlokier.co.uk") by vger.kernel.org with ESMTP id S261183AbTINP5Y
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 14 Sep 2003 11:57:24 -0400
Date: Sun, 14 Sep 2003 16:56:54 +0100
From: Jamie Lokier <jamie@shareable.org>
To: Andi Kleen <ak@muc.de>
Cc: linux-kernel@vger.kernel.org, jh@suse.cz
Subject: Re: stack alignment in the kernel was Re: nasm over gas?
Message-ID: <20030914155654.GD16525@mail.jlokier.co.uk>
References: <rZQN.83u.21@gated-at.bofh.it> <uw6d.3hD.35@gated-at.bofh.it> <uxED.5Rz.9@gated-at.bofh.it> <uYbM.26o.3@gated-at.bofh.it> <uZUr.4QR.25@gated-at.bofh.it> <v4qU.3h1.27@gated-at.bofh.it> <vog2.7k4.23@gated-at.bofh.it> <m31xuk8cnu.fsf_-_@averell.firstfloor.org> <20030914135431.GB16525@mail.jlokier.co.uk> <20030914141346.GA1194@averell>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030914141346.GA1194@averell>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen wrote:
> Hmm. The i386 Makefile sets that already. Where exactly did you see
> bogus stack adjustments in kernel code?

I didn't.  I saw them in a test program for __builtin_expect() in the
"oops_in_progress is unlikely()" thread.

I'm used to seeing redundant "mov" instructions and such from GCC, so
when I saw the stack adjustments with -O2 go away with -Os I thought
they were more of the same - not realising that -Os turns off the stack
alignment.  My error.

-- Jamie
