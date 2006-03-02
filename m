Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751352AbWCBCXF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751352AbWCBCXF (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Mar 2006 21:23:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751393AbWCBCXE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Mar 2006 21:23:04 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:56264 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S1751352AbWCBCXD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Mar 2006 21:23:03 -0500
Date: Thu, 2 Mar 2006 13:22:32 +1100
From: Nathan Scott <nathans@sgi.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Badari Pulavarty <pbadari@us.ibm.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/4] change buffer_head.b_size to size_t
Message-ID: <20060302132232.C88229@wobbly.melbourne.sgi.com>
References: <1141075239.10542.19.camel@dyn9047017100.beaverton.ibm.com> <1141075361.10542.21.camel@dyn9047017100.beaverton.ibm.com> <20060301175148.2250b36e.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20060301175148.2250b36e.akpm@osdl.org>; from akpm@osdl.org on Wed, Mar 01, 2006 at 05:51:48PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 01, 2006 at 05:51:48PM -0800, Andrew Morton wrote:
> Badari Pulavarty <pbadari@us.ibm.com> wrote:
> >
> > + * Historically, a buffer_head was used to map a single block
> > + * within a page, and of course as the unit of I/O through the
> > + * filesystem and block layers.  Nowadays the basic I/O unit
> > + * is the bio, and buffer_heads are used for extracting block
> > + * mappings (via a get_block_t call), for tracking state within
> > + * a page (via a page_mapping) and for wrapping bio submission
> > + * for backward compatibility reasons (e.g. submit_bh).
> 
> Well kinda.  A buffer_head remains the kernel's basic abstraction for a
> "disk block".

Thats what I said (meant to say) with
"buffer_heads are used for extracting block mappings".

I think by "disk block" you mean what I'm thinking of as a
"block mapping" (series of contiguous blocks).  I'd think
of a sector_t as a "disk block", but maybe I'm just wierd
that way... a better wordsmith should jump in and update
the comment I guess.

>  We cannot replace that with `struct page' (size isn't
> flexible) nor of course with `struct bio'.

Indeed.

-- 
Nathan
