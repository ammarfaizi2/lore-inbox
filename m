Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264251AbUGIE6x@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264251AbUGIE6x (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Jul 2004 00:58:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264260AbUGIE6w
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Jul 2004 00:58:52 -0400
Received: from mail.tpgi.com.au ([203.12.160.113]:49594 "EHLO mail.tpgi.com.au")
	by vger.kernel.org with ESMTP id S264251AbUGIE6i (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Jul 2004 00:58:38 -0400
Subject: Re: GCC 3.4 and broken inlining.
From: Nigel Cunningham <ncunningham@linuxmail.org>
Reply-To: ncunningham@linuxmail.org
To: Andi Kleen <ak@muc.de>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <m34qohrdel.fsf@averell.firstfloor.org>
References: <2fFzK-3Zz-23@gated-at.bofh.it> <2fG2F-4qK-3@gated-at.bofh.it>
	 <2fG2G-4qK-9@gated-at.bofh.it> <2fPfF-2Dv-21@gated-at.bofh.it>
	 <2fPfF-2Dv-19@gated-at.bofh.it>  <m34qohrdel.fsf@averell.firstfloor.org>
Content-Type: text/plain
Message-Id: <1089349003.4861.17.camel@nigel-laptop.wpcb.org.au>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6-1mdk 
Date: Fri, 09 Jul 2004 14:56:43 +1000
Content-Transfer-Encoding: 7bit
X-TPG-Antivirus: Passed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

On Fri, 2004-07-09 at 14:51, Andi Kleen wrote:
> Nigel Cunningham <ncunningham@linuxmail.org> writes:

I'm not sure what I wrote that you're replying to.

> I think a better solution would be to apply the appended patch 

I'm going to be a pragmatist :> As long as it works. I do think that
functions being declared inline when they can't be inlined is wrong, but
there are more important things on which to spend my time.

> And then just mark the function you know needs to be inlined
> as __always_inline__. I did this on x86-64 for some functions
> too that need to be always inlined (although using the attribute
> directly because all x86-64 compilers support it)

Should that be __always_inline (no final __ in the patch below, so far
as I can see)?

[...]

> P.S.: compiler.h seems to be not "gcc 4.0 safe". Probably that needs
> to be fixed too.

Yes.

Regards,

Nigel

