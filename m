Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261152AbTINNzI (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 14 Sep 2003 09:55:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261153AbTINNzI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 14 Sep 2003 09:55:08 -0400
Received: from mail.jlokier.co.uk ([81.29.64.88]:13459 "EHLO
	mail.jlokier.co.uk") by vger.kernel.org with ESMTP id S261152AbTINNzD
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 14 Sep 2003 09:55:03 -0400
Date: Sun, 14 Sep 2003 14:54:31 +0100
From: Jamie Lokier <jamie@shareable.org>
To: Andi Kleen <ak@muc.de>
Cc: linux-kernel@vger.kernel.org, jh@suse.cz
Subject: Re: stack alignment in the kernel was Re: nasm over gas?
Message-ID: <20030914135431.GB16525@mail.jlokier.co.uk>
References: <rZQN.83u.21@gated-at.bofh.it> <uw6d.3hD.35@gated-at.bofh.it> <uxED.5Rz.9@gated-at.bofh.it> <uYbM.26o.3@gated-at.bofh.it> <uZUr.4QR.25@gated-at.bofh.it> <v4qU.3h1.27@gated-at.bofh.it> <vog2.7k4.23@gated-at.bofh.it> <m31xuk8cnu.fsf_-_@averell.firstfloor.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <m31xuk8cnu.fsf_-_@averell.firstfloor.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen wrote:
> The stack adjustments are for getting good performance with floating
> point code. Most x86 CPUs require 16 byte alignment for floating point
> stores/loads on the stack. It can make a dramatic difference in some 
> FP intensive programs.

You're right.

> A compiler option to turn it off would make sense to save .text space
> and eliminate these useless instructions. Especially since the kernel
> entry points make no attempt to align the stack to 16 byte anyways,
> so most likely the stack adjustments do not even work.

There is an option:

	-mpreferred-stack-boundary=2

-- Jamie
