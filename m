Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261232AbUGLSXY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261232AbUGLSXY (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Jul 2004 14:23:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261239AbUGLSXY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Jul 2004 14:23:24 -0400
Received: from [213.146.154.40] ([213.146.154.40]:19154 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S261232AbUGLSXT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Jul 2004 14:23:19 -0400
Date: Mon, 12 Jul 2004 19:23:15 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Andrew Morton <akpm@osdl.org>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, torvalds@osdl.org,
       dhowells@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: struct_cpy() and kAFS (was: Re: Linux 2.6.8-rc1)
Message-ID: <20040712182315.GA28281@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Andrew Morton <akpm@osdl.org>,
	Geert Uytterhoeven <geert@linux-m68k.org>, torvalds@osdl.org,
	dhowells@redhat.com, linux-kernel@vger.kernel.org
References: <Pine.LNX.4.58.0407111120010.1764@ppc970.osdl.org> <Pine.GSO.4.58.0407121519380.17199@waterleaf.sonytel.be> <20040712111120.2094f089.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040712111120.2094f089.akpm@osdl.org>
User-Agent: Mutt/1.4.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 12, 2004 at 11:11:20AM -0700, Andrew Morton wrote:
> Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> >
> > On Sun, 11 Jul 2004, Linus Torvalds wrote:
> >  > David Howells:
> >  >   o kAFS automount support
> > 
> >  After this change, all archs need to provide struct_cpy() to make AFS compile,
> >  while currently only ia32 and amd64 provide it.
> 
> Seems a strange thing to do.  Why not rely on the type system?

struct_cpy is used nowehre except in arch/i386/kernel/process.c and AFS,
so we should probably better kill it before people start using it in other
places.

