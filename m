Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263702AbUDUVFg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263702AbUDUVFg (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Apr 2004 17:05:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263705AbUDUVFf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Apr 2004 17:05:35 -0400
Received: from phoenix.infradead.org ([213.86.99.234]:57355 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S263702AbUDUVF3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Apr 2004 17:05:29 -0400
Date: Wed, 21 Apr 2004 22:05:24 +0100 (BST)
From: James Simmons <jsimmons@infradead.org>
To: "Jorge Bernal (Koke)" <koke_lkml@amedias.org>
cc: linux-kernel@vger.kernel.org, Joshua Kwan <joshk@triplehelix.org>
Subject: Re: [2.6.5] Oversized FB logos
In-Reply-To: <200404171126.09188.koke_lkml@amedias.org>
Message-ID: <Pine.LNX.4.44.0404212203430.10680-100000@phoenix.infradead.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> On Sábado, 17 de Abril de 2004 05:07, Joshua Kwan wrote:
> > Hi everyone,
> >
> > Note that I'd be using bootsplash for this but vesafb only works up to
> > 8bit color and bootsplash requires 16bit color.
> 
> Maybe I haven't understood your question but I'm using vesafb at 1280x1024 and 
> 16 bits w/o any problem.

I understand what he is talking about. There is a bug in cfb_imageblit 
in such that it doesn't allow images of color depths greaters than 8 bpp.
That is image depth. Not framebuffer depth. I just fixed that bug and I 
will be pushing that fix to Andrew Morton for people to test. I haven't 
tested it on big endian yet tho.


