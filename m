Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264973AbUHYJ26@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264973AbUHYJ26 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Aug 2004 05:28:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264389AbUHYJ25
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Aug 2004 05:28:57 -0400
Received: from witte.sonytel.be ([80.88.33.193]:10715 "EHLO witte.sonytel.be")
	by vger.kernel.org with ESMTP id S264973AbUHYJOH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Aug 2004 05:14:07 -0400
Date: Wed, 25 Aug 2004 11:13:31 +0200 (MEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Linus Torvalds <torvalds@osdl.org>
cc: Matt Mackall <mpm@selenic.com>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.6.9-rc1
In-Reply-To: <Pine.LNX.4.58.0408241221390.17766@ppc970.osdl.org>
Message-ID: <Pine.GSO.4.58.0408251103340.18759@waterleaf.sonytel.be>
References: <Pine.LNX.4.58.0408240031560.17766@ppc970.osdl.org>
 <20040824184245.GE5414@waste.org> <Pine.LNX.4.58.0408241221390.17766@ppc970.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 24 Aug 2004, Linus Torvalds wrote:
> On Tue, 24 Aug 2004, Matt Mackall wrote:
> > Phew, I was worried about that. Can I get a ruling on how you intend
> > to handle a x.y.z.1 to x.y.z.2 transition? I've got a tool that I'm
> > looking to unbreak. My preference would be for all x.y.z.n patches to
> > be relative to x.y.z.
>
> Hmm.. I have no strong preferences. There _is_ obviously a well-defined
> ordering from x.y.z.1 -> x.y.z.2 (unlike the -rcX releases that don't have
> any ordering wrt the bugfixes), so either interdiffs or whole new full
> diffs are totally "logical". We just have to chose one way or the other,
> and I don't actually much care.
>
> Any reason for your preference?

I prefer diffs between x.y.z.w-1 and x.y.z.w. x.y.z.{...,w-1,w,w+1,...} is one
stream of development, x.y.{...,z-1,z,z+1,...} is another one.

BTW, I always found it pretty rare that the rc patches weren't like that.
`unpatching' w-1 and `patching' w afterwards isn't fun if you have local
changes.

Gr{oetje,eeting}s,

						Geert

P.S. Personally I wouldn't suffer from unpatching and patching, since I use
     merging (using a script that does recursive merges with RCS merge). But if
     I would not be an architecture maintainer but just a plain user who
     sometimes does a few hacks (or applies some patches from others) on his
     kernel, I would just want to apply the x.y.z.w-1-to-x.y.z.w patch, fixup
     the (hopefully few) rejects, and be happy...
--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
