Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262423AbTE0AaU (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 May 2003 20:30:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262424AbTE0AaT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 May 2003 20:30:19 -0400
Received: from DELFT.AURA.CS.CMU.EDU ([128.2.206.88]:23771 "EHLO
	delft.aura.cs.cmu.edu") by vger.kernel.org with ESMTP
	id S262423AbTE0AaS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 May 2003 20:30:18 -0400
Date: Mon, 26 May 2003 20:43:23 -0400
To: Grzegorz Jaskiewicz <gj@pointblue.com.pl>
Cc: lkml <linux-kernel@vger.kernel.org>, codalist@coda.cs.cmu.edu
Subject: Re: OUPS 2.5.69-bk19 coda-inode.c/slab.c
Message-ID: <20030527004322.GA1690@delft.aura.cs.cmu.edu>
Mail-Followup-To: Grzegorz Jaskiewicz <gj@pointblue.com.pl>,
	lkml <linux-kernel@vger.kernel.org>, codalist@coda.cs.cmu.edu
References: <1053971135.1968.6.camel@nalesnik.localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1053971135.1968.6.camel@nalesnik.localhost>
User-Agent: Mutt/1.5.4i
From: Jan Harkes <jaharkes@cs.cmu.edu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 26, 2003 at 06:45:40PM +0100, Grzegorz Jaskiewicz wrote:
> following BUG() is started when coda is included into kernel. I have not
> tried module, but i bet it will couse the same error.

Although I don't run the -bkXX releases, as far as I can see this is not
related to anything in Coda bug, but probably a missing change to slab.c.

A flag was added to the slabcache to identify reclaimable slabs. I can
see how this BUG would get triggered if your kernel was linked with an
old version of slab.o or is missing the SLAB_RECLAIM_ACCOUNT related
changes in slab.c.

Maybe "make clean ; make bzImage modules" will fix it?

Jan

