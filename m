Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261536AbUJaLo2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261536AbUJaLo2 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 31 Oct 2004 06:44:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261539AbUJaLlS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 31 Oct 2004 06:41:18 -0500
Received: from havoc.gtf.org ([69.28.190.101]:6617 "EHLO havoc.gtf.org")
	by vger.kernel.org with ESMTP id S261585AbUJaK5a (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 31 Oct 2004 05:57:30 -0500
Date: Sun, 31 Oct 2004 05:57:24 -0500
From: Jeff Garzik <jgarzik@pobox.com>
To: Andrew Morton <akpm@osdl.org>
Cc: geert@linux-m68k.org, torvalds@osdl.org, linux-kernel@vger.kernel.org,
       linux-net@vger.kernel.org
Subject: Re: [PATCH 475] HP300 LANCE
Message-ID: <20041031105724.GA28012@havoc.gtf.org>
References: <200410311003.i9VA3UMN009557@anakin.of.borg> <4184BB09.8000107@pobox.com> <20041031021933.1eba86a6.akpm@osdl.org> <4184C16E.80705@pobox.com> <20041031024840.6eeee92d.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041031024840.6eeee92d.akpm@osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 31, 2004 at 02:48:40AM -0800, Andrew Morton wrote:
> > -        void *va = dio_scodetoviraddr(scode);
> > +	unsigned long pa = dio_scodetophysaddr(scode);
> > +        unsigned long va = (pa + DIO_VIRADDRBASE);


> That's because the stoopid driver is using spaces instead of tabs all over
> the place.  It comes out visually OK once the patch is applied.  But it's a
> useful reminder of how much dreck we have in the tree.

Did you see the above quoted patch chunk?  The patch is inconsistent
with _itself_, adding 'pa' and 'va' with different idents (but when they
should be at the same identation level).

	Jeff



