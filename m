Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932253AbWAJRHa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932253AbWAJRHa (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Jan 2006 12:07:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932254AbWAJRHa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Jan 2006 12:07:30 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:30699 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S932253AbWAJRH3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Jan 2006 12:07:29 -0500
Date: Tue, 10 Jan 2006 17:07:22 +0000
From: Christoph Hellwig <hch@infradead.org>
To: "Bryan O'Sullivan" <bos@pathscale.com>
Cc: Roland Dreier <rdreier@cisco.com>, sam@ravnborg.org,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1 of 3] Introduce __raw_memcpy_toio32
Message-ID: <20060110170722.GA3187@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Bryan O'Sullivan <bos@pathscale.com>,
	Roland Dreier <rdreier@cisco.com>, sam@ravnborg.org,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
References: <patchbomb.1136579193@eng-12.pathscale.com> <d286502c3b3cd6bcec7b.1136579194@eng-12.pathscale.com> <20060110011844.7a4a1f90.akpm@osdl.org> <adaslrw3zfu.fsf@cisco.com> <1136909276.32183.28.camel@serpentine.pathscale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1136909276.32183.28.camel@serpentine.pathscale.com>
User-Agent: Mutt/1.4.2.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 10, 2006 at 08:07:56AM -0800, Bryan O'Sullivan wrote:
> I'm fine with doing that, but I wonder what an appropriate way to do it
> would be.
> 
> Really, we'd like the generic implementation to be declared in
> asm-generic and defined in lib.  Each arch that needed the generic
> version could then have its arch/XXX/lib/Makefile modified to pull in
> the generic version from lib, while arches that had special versions
> could remain unencumbered.

Or add a CONFIG_GENERIC_MEMCPY_IO that's non-uservisible and just set
by all the architectures that don't provide their own version.  And once
we're at that level of complexity we should really add the _fromio version
aswell ;-)

