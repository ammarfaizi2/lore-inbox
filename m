Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261169AbTINOOB (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 14 Sep 2003 10:14:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261171AbTINOOB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 14 Sep 2003 10:14:01 -0400
Received: from zero.aec.at ([193.170.194.10]:6409 "EHLO zero.aec.at")
	by vger.kernel.org with ESMTP id S261169AbTINOOA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 14 Sep 2003 10:14:00 -0400
Date: Sun, 14 Sep 2003 16:13:46 +0200
From: Andi Kleen <ak@muc.de>
To: Jamie Lokier <jamie@shareable.org>
Cc: Andi Kleen <ak@muc.de>, linux-kernel@vger.kernel.org, jh@suse.cz
Subject: Re: stack alignment in the kernel was Re: nasm over gas?
Message-ID: <20030914141346.GA1194@averell>
References: <rZQN.83u.21@gated-at.bofh.it> <uw6d.3hD.35@gated-at.bofh.it> <uxED.5Rz.9@gated-at.bofh.it> <uYbM.26o.3@gated-at.bofh.it> <uZUr.4QR.25@gated-at.bofh.it> <v4qU.3h1.27@gated-at.bofh.it> <vog2.7k4.23@gated-at.bofh.it> <m31xuk8cnu.fsf_-_@averell.firstfloor.org> <20030914135431.GB16525@mail.jlokier.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030914135431.GB16525@mail.jlokier.co.uk>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 14, 2003 at 02:54:31PM +0100, Jamie Lokier wrote:
> > A compiler option to turn it off would make sense to save .text space
> > and eliminate these useless instructions. Especially since the kernel
> > entry points make no attempt to align the stack to 16 byte anyways,
> > so most likely the stack adjustments do not even work.
> 
> There is an option:
> 
> 	-mpreferred-stack-boundary=2

Hmm. The i386 Makefile sets that already. Where exactly did you see
bogus stack adjustments in kernel code?

-Andi
