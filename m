Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261997AbTIPR32 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Sep 2003 13:29:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262008AbTIPR32
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Sep 2003 13:29:28 -0400
Received: from mail.jlokier.co.uk ([81.29.64.88]:33428 "EHLO
	mail.jlokier.co.uk") by vger.kernel.org with ESMTP id S261997AbTIPR30
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Sep 2003 13:29:26 -0400
Date: Tue, 16 Sep 2003 18:23:54 +0100
From: Jamie Lokier <jamie@shareable.org>
To: Bill Davidsen <davidsen@tmr.com>
Cc: Dave Jones <davej@redhat.com>, richard.brunner@amd.com,
       alan@lxorguk.ukuu.org.uk, zwane@linuxpower.ca,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.6 workaround for Athlon/Opteron prefetch errata
Message-ID: <20030916172354.GD28457@mail.jlokier.co.uk>
References: <20030916133019.GA1039@redhat.com> <Pine.LNX.3.96.1030916094748.26515B-100000@gatekeeper.tmr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.3.96.1030916094748.26515B-100000@gatekeeper.tmr.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bill Davidsen wrote:
> > prefetch isn't a cpuid feature flag. The only way you could do
> > what you suggest is by removing '3dnow' or 'sse', which cripples
> > things more than necessary.
> 
> Good point, and even if it were a separate feature, any code which was
> clever enough to use prefetch is likely to check the CPU bits rather
> than the /proc anyway. That's a guess, I suspect most programs do
> whatever gcc/glibc choose.

As I pointed out, other programs _especially_ glibc will need to check
for the AMD errata anyway, because of older kernels.

> If the fixup were not in place, would it be useful to emit a warning
> like "you have booted a non-Athlon kernel on an Athlon process, user
> programs may get unexpected page faults."

I agree, that's a good idea.  It will fit nicely alongside the
messages for broken WP bit etc.

-- Jamie
