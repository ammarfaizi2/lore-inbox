Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268538AbTGITEM (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Jul 2003 15:04:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268548AbTGITEM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Jul 2003 15:04:12 -0400
Received: from host-64-213-145-173.atlantasolutions.com ([64.213.145.173]:55467
	"EHLO havoc.gtf.org") by vger.kernel.org with ESMTP id S268538AbTGITEJ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Jul 2003 15:04:09 -0400
Date: Wed, 9 Jul 2003 15:18:47 -0400
From: Jeff Garzik <jgarzik@pobox.com>
To: Trond Myklebust <trond.myklebust@fys.uio.no>,
       Marcelo Tosatti <marcelo@conectiva.com.br>,
       Christoph Hellwig <hch@infradead.org>, marcelo@connectiva.com.br,
       lkml <linux-kernel@vger.kernel.org>
Subject: Re: ->direct_IO API change in current 2.4 BK
Message-ID: <20030709191847.GI15293@gtf.org>
References: <20030709133109.A23587@infradead.org> <20030709100336.H4482@schatzie.adilger.int> <Pine.LNX.4.55L.0307091421070.26373@freak.distro.conectiva> <16140.24322.464839.812346@charged.uio.no> <20030709115148.L4482@schatzie.adilger.int>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030709115148.L4482@schatzie.adilger.int>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 09, 2003 at 11:51:48AM -0700, Andreas Dilger wrote:
> On Jul 09, 2003  20:29 +0200, Trond Myklebust wrote:
> > How about instead following Alan's suggestion to replace
> > KERNEL_HAS_O_DIRECT with a KERNEL_HAS_O_DIRECT2 that can be used to
> > switch between the old and new O_DIRECT format in the XFS patches?
> 
> Actually, I like that a lot more, as it allows out-of-tree code to
> know which interface to use, and we don't have to key on kernel version
> (which is bogus if compiling against a vendor kernel that back-ports
> this fix).

Feature test macros are definitely quite useful...

...but making the stable series VFS API definition _conditional_
is quite unprecedented, and IMO wrong.

	Jeff



