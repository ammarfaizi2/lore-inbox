Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264986AbUELGAM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264986AbUELGAM (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 May 2004 02:00:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264989AbUELGAM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 May 2004 02:00:12 -0400
Received: from colin2.muc.de ([193.149.48.15]:1036 "HELO colin2.muc.de")
	by vger.kernel.org with SMTP id S264986AbUELGAJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 May 2004 02:00:09 -0400
Date: 12 May 2004 08:00:07 +0200
Date: Wed, 12 May 2004 08:00:07 +0200
From: Andi Kleen <ak@muc.de>
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: Andi Kleen <ak@muc.de>, Andrew Morton <akpm@osdl.org>,
       randy.dunlap@osdl.org, Sam Ravnborg <sam@ravnborg.org>,
       lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Keith Owens <kaos@sgi.com>
Subject: Re: [PATCH] Sort kallsyms in name order: kernel shrinks by 30k
Message-ID: <20040512060007.GB96009@colin2.muc.de>
References: <1084252135.31802.312.camel@bach> <20040511080843.GB8751@colin2.muc.de> <1084317416.17692.29.camel@bach>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1084317416.17692.29.camel@bach>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 12, 2004 at 09:16:56AM +1000, Rusty Russell wrote:
> A binary search as stands doesn't help much because we still need to
> iterate through the names.  We could do "address, nameindex" pairs, but
> with stem compression we need to at least wade back some way to decode
> the name.

Yes, but that iteration is bounded.

> 
> I have a 30-line static huffman decoder (from the IDE mini-oopser) which
> we could use instead of stem compression, which we could combine with
> "address, bitoffset" pairs which would be about 20k smaller and faster
> than the current approach, but is it worth the trouble?

Probably not.

-Andi
