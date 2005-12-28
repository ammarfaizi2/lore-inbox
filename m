Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964822AbVL1OwT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964822AbVL1OwT (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Dec 2005 09:52:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964831AbVL1OwS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Dec 2005 09:52:18 -0500
Received: from mx.pathscale.com ([64.160.42.68]:49581 "EHLO mx.pathscale.com")
	by vger.kernel.org with ESMTP id S964822AbVL1OwS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Dec 2005 09:52:18 -0500
Subject: Re: [PATCH 2 of 3] memcpy32 for x86_64
From: "Bryan O'Sullivan" <bos@pathscale.com>
To: Matt Mackall <mpm@selenic.com>
Cc: Andi Kleen <ak@suse.de>, linux-kernel@vger.kernel.org, akpm@osdl.org,
       hch@infradead.org
In-Reply-To: <20051228042232.GC3356@waste.org>
References: <patchbomb.1135726914@eng-12.pathscale.com>
	 <042b7d9004acd65f6655.1135726916@eng-12.pathscale.com>
	 <20051228042232.GC3356@waste.org>
Content-Type: text/plain
Organization: PathScale, Inc.
Date: Wed, 28 Dec 2005 06:52:17 -0800
Message-Id: <1135781537.1527.95.camel@serpentine.pathscale.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-12-27 at 22:22 -0600, Matt Mackall wrote:

> It's better to do an include here. Duplicating prototypes in .c files
> is frowned upon (despite the fact that it's already done here).

Yeah.  I'm not thrilled about the existing style of that file, but I
don't want to weed-whack it as I go.  That turns a small patch into a
case of mission creep.

> We've been steadily moving towards grouping EXPORTs with function
> definitions. Do *_ksyms.c exist solely to provide exports for
> functions defined in assembly at this point? If so, perhaps we ought
> to come up with a suitable export macro for asm files.

That might make sense, but it's also beyond the scope of what I'm trying
to do.

> Any reason this needs its own .S file?

Not really.

>  One wonders if the
> 
>         .p2align 4
> 
> in memcpy.S is appropriate here too.

It's not clear to me that it makes any difference either way.  Both
routines obviously work :-)  Perhaps Andi can indicate his opinion.

	<b

