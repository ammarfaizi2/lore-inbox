Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261663AbTINW1B (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 14 Sep 2003 18:27:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262009AbTINW1B
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 14 Sep 2003 18:27:01 -0400
Received: from nikam.ms.mff.cuni.cz ([195.113.18.106]:22210 "EHLO
	nikam.ms.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S261663AbTINW1A (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 14 Sep 2003 18:27:00 -0400
Date: Mon, 15 Sep 2003 00:27:03 +0200
From: Jan Hubicka <jh@suse.cz>
To: Jamie Lokier <jamie@shareable.org>
Cc: Andi Kleen <ak@muc.de>, linux-kernel@vger.kernel.org, jh@suse.cz
Subject: Re: stack alignment in the kernel was Re: nasm over gas?
Message-ID: <20030914222703.GB8208@kam.mff.cuni.cz>
References: <rZQN.83u.21@gated-at.bofh.it> <uw6d.3hD.35@gated-at.bofh.it> <uxED.5Rz.9@gated-at.bofh.it> <uYbM.26o.3@gated-at.bofh.it> <uZUr.4QR.25@gated-at.bofh.it> <v4qU.3h1.27@gated-at.bofh.it> <vog2.7k4.23@gated-at.bofh.it> <m31xuk8cnu.fsf_-_@averell.firstfloor.org> <20030914135431.GB16525@mail.jlokier.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030914135431.GB16525@mail.jlokier.co.uk>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 
> > A compiler option to turn it off would make sense to save .text space
> > and eliminate these useless instructions. Especially since the kernel
> > entry points make no attempt to align the stack to 16 byte anyways,
> > so most likely the stack adjustments do not even work.
> 
> There is an option:
> 
> 	-mpreferred-stack-boundary=2

Note that this won't work for x86-64 where ABI compliant varargs require
it.

Honza
> 
> -- Jamie
