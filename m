Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268471AbTGISu4 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Jul 2003 14:50:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268490AbTGISu4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Jul 2003 14:50:56 -0400
Received: from host-64-213-145-173.atlantasolutions.com ([64.213.145.173]:33707
	"EHLO havoc.gtf.org") by vger.kernel.org with ESMTP id S268471AbTGISux
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Jul 2003 14:50:53 -0400
Date: Wed, 9 Jul 2003 15:05:31 -0400
From: Jeff Garzik <jgarzik@pobox.com>
To: Trond Myklebust <trond.myklebust@fys.uio.no>
Cc: Marc-Christian Petersen <m.c.p@wolk-project.de>,
       Marcelo Tosatti <marcelo@conectiva.com.br>,
       lkml <linux-kernel@vger.kernel.org>
Subject: Re: ->direct_IO API change in current 2.4 BK
Message-ID: <20030709190531.GF15293@gtf.org>
References: <20030709133109.A23587@infradead.org> <Pine.LNX.4.55L.0307091506180.27004@freak.distro.conectiva> <16140.24595.438954.609504@charged.uio.no> <200307092041.42608.m.c.p@wolk-project.de> <16140.25619.963866.474510@charged.uio.no>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <16140.25619.963866.474510@charged.uio.no>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 09, 2003 at 08:50:59PM +0200, Trond Myklebust wrote:
> >>>>> " " == Marc-Christian Petersen <m.c.p@wolk-project.de> writes:
> 
>      > err, -aa has XFS per default, -wolk has XFS per default. So
>      > ... ;)
> 
> So they have both XFS + NFS O_DIRECT?
> 
> The answer to your question is then that somebody made the trivial
> conversion on XFS... It's just a question of replacing the second
> argument of the direct_IO() method with a filp, then extracting the
> inode from that. A 2-liner patch at most...
> 
> The point here is that Marcelo's tree does not include XFS, so my
> patch can't fix it up...
> As I said, I suggest replacing KERNEL_HAS_O_DIRECT with
> KERNEL_HAS_O_DIRECT2 so that the XFS patches can switch on that, and
> hence provide the 2-liner on newer kernels...

s/replacing/adding/

A new ->direct_IO2 hook would be an addition, so you really want to
simply add another feature flag.

Since the 2.5 direct_IO API is already different from current 2.4, I
would also suggestion considering KERNEL24_HAS_O_DIRECT2 as the name, to
specify the feature is specific to 2.4.

	Jeff



