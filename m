Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266244AbUGKFxz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266244AbUGKFxz (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 Jul 2004 01:53:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266242AbUGKFxz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 Jul 2004 01:53:55 -0400
Received: from colin2.muc.de ([193.149.48.15]:3089 "HELO colin2.muc.de")
	by vger.kernel.org with SMTP id S266244AbUGKFxx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 Jul 2004 01:53:53 -0400
Date: 11 Jul 2004 07:53:52 +0200
Date: Sun, 11 Jul 2004 07:53:52 +0200
From: Andi Kleen <ak@muc.de>
To: Alexandre Oliva <aoliva@redhat.com>
Cc: ncunningham@linuxmail.org, linux-kernel@vger.kernel.org
Subject: Re: GCC 3.4 and broken inlining.
Message-ID: <20040711055352.GB87770@muc.de>
References: <2fFzK-3Zz-23@gated-at.bofh.it> <2fG2F-4qK-3@gated-at.bofh.it> <2fG2G-4qK-9@gated-at.bofh.it> <2fPfF-2Dv-21@gated-at.bofh.it> <2fPfF-2Dv-19@gated-at.bofh.it> <m34qohrdel.fsf@averell.firstfloor.org> <orvfgvo8pr.fsf@livre.redhat.lsd.ic.unicamp.br>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <orvfgvo8pr.fsf@livre.redhat.lsd.ic.unicamp.br>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 10, 2004 at 06:25:52PM -0300, Alexandre Oliva wrote:
> > And then just mark the function you know needs to be inlined
> > as __always_inline__.
> 
> It's probably a good idea to define such functions as `extern inline'
> (another GCC extension), such that a definition of the function is
> never emitted, and you get a linker error if the compiler somehow
> fails to emit an error on a failure to inline the function.

That used to be done in the past for all functions, but it was 
stopped because gcc suddenly stopped inlining functions it did previously 
and it caused a lot of spurious linker errors.

I guess it could be readded if the inlining heuristics were fixed,
but even in gcc 3.5 it still looks quite bleak.

-Andi
