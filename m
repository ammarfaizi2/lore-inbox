Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262358AbTHUCYj (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Aug 2003 22:24:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262361AbTHUCYj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Aug 2003 22:24:39 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:50958 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id S262358AbTHUCYi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Aug 2003 22:24:38 -0400
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: Interesting VM feature?
Date: 20 Aug 2003 19:24:25 -0700
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <bi1agp$40b$1@cesium.transmeta.com>
References: <147bb3140e7a.140e7a147bb3@rdc-kc.rr.com> <20030815200020.GM1027@matchmail.com> <20030815211937.GA20208@mail.jlokier.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Disclaimer: Not speaking for Transmeta in any way, shape, or form.
Copyright: Copyright 2003 H. Peter Anvin - All Rights Reserved
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <20030815211937.GA20208@mail.jlokier.co.uk>
By author:    Jamie Lokier <jamie@shareable.org>
In newsgroup: linux.dev.kernel
>
> Mike Fedyk wrote:
> > On Fri, Aug 15, 2003 at 02:56:02PM -0500, mouschi@wi.rr.com wrote:
> > > Is madvise required to result in zero filled pages
> > > by a standard, or is this just the commonly accepted
> > > behavior?
> > 
> > I believe it is the standard for clean pages, though someone else will have
> > to point out where...
> 
> That's the answer to a different question.
> 
> The unanswered question is: what should madvise(MADV_DONTNEED) do,
> given dirty pages?
> 
> man madvise(*) says that it zero-fills anonymous private mappings, and
> restores private file-backed mappings to the original file pages.
> 
> That is not surprising, as the CPU-friendly semantic is more
> complicated to implement, needing an extra flag in the page table
> (or rmap structure).
> 

Sounds entirely reasonable.

It *would* be nice with a way to be able to say to the kernel "you may
discard this but if so I want SIGSEGV", for things like LPSM and the
like.

	-hpa
-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
If you send me mail in HTML format I will assume it's spam.
"Unix gives you enough rope to shoot yourself in the foot."
Architectures needed: ia64 m68k mips64 ppc ppc64 s390 s390x sh v850 x86-64
