Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261513AbUKCKk2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261513AbUKCKk2 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Nov 2004 05:40:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261521AbUKCKk2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Nov 2004 05:40:28 -0500
Received: from phoenix.infradead.org ([81.187.226.98]:29703 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S261513AbUKCKkV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Nov 2004 05:40:21 -0500
Date: Wed, 3 Nov 2004 10:40:16 +0000
From: Christoph Hellwig <hch@infradead.org>
To: David Howells <dhowells@redhat.com>
Cc: Christoph Hellwig <hch@infradead.org>, torvalds@osdl.org, akpm@osdl.org,
       davidm@snapgear.com, linux-kernel@vger.kernel.org,
       uclinux-dev@uclinux.org
Subject: Re: [PATCH 10/14] FRV: Make calibrate_delay() optional
Message-ID: <20041103104016.GB18416@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	David Howells <dhowells@redhat.com>, torvalds@osdl.org,
	akpm@osdl.org, davidm@snapgear.com, linux-kernel@vger.kernel.org,
	uclinux-dev@uclinux.org
References: <20041102093610.GB5841@infradead.org> <76b4a884-2c3c-11d9-91a1-0002b3163499@redhat.com> <200411011930.iA1JULKN023227@warthog.cambridge.redhat.com> <25906.1099412979@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <25906.1099412979@redhat.com>
User-Agent: Mutt/1.4.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by phoenix.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 02, 2004 at 04:29:39PM +0000, David Howells wrote:
> 
> > this changelog certainly does not apply to the delay loop calibration.
> 
> I just duplicated the banners from init/main.c and tacked some extra bits on
> the front.
> 
> > any reason it's in lib?  Better move this to kernel and properly compile
> > it conditionally.
> 
> So that it get built and placed in an archive library, thus allowing the
> linker to decide whether to include it or not, without having to use
> conditional stuff and without having to change every other arch to enable it.
> 
> I suppose I could do something like this in init/Makefile:
> 
> 	if ($(CONFIG_DISABLE_GENERIC_CALIBRATE_DELAY),y)
> 	obj-y += calibrate.o
> 	endif
> 
> That would allow me to avoid having to change all the archs.

Use CONFIG_CALIBRATE_DELAY and add it to all other ports.  Remember Linux
is not about least intrusive changes but about what's easiest maintainable.

