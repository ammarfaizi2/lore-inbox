Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261679AbSJCRkJ>; Thu, 3 Oct 2002 13:40:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261669AbSJCRkJ>; Thu, 3 Oct 2002 13:40:09 -0400
Received: from RAVEL.CODA.CS.CMU.EDU ([128.2.222.215]:53388 "EHLO
	ravel.coda.cs.cmu.edu") by vger.kernel.org with ESMTP
	id <S261679AbSJCRkI>; Thu, 3 Oct 2002 13:40:08 -0400
Date: Thu, 3 Oct 2002 13:45:40 -0400
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] AFS filesystem for Linux (2/2)
Message-ID: <20021003174540.GB25718@ravel.coda.cs.cmu.edu>
Mail-Followup-To: linux-kernel@vger.kernel.org
References: <torvalds@transmeta.com> <Pine.LNX.4.33.0210021730170.22980-100000@penguin.transmeta.com> <13691.1033635939@warthog.cambridge.redhat.com> <20021003165304.GA25718@ravel.coda.cs.cmu.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021003165304.GA25718@ravel.coda.cs.cmu.edu>
User-Agent: Mutt/1.4i
From: Jan Harkes <jaharkes@cs.cmu.edu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 03, 2002 at 12:53:04PM -0400, Jan Harkes wrote:
> On Thu, Oct 03, 2002 at 10:05:39AM +0100, David Howells wrote:
> > To have a heterogenous cache, the VLDB record and vnode index records could be
> > extended to 2K or 4K in size, or maybe separate catalogues and indices could
> > be maintained for different filesystem types, and a 0th tier could be a
> > catalogue of different types held within this cache, complete with information
> > as to the entry sizes of the tier 1, 2 and 3 catalogues.
> 
> Or you could use a hash or a userspace daemon that can map a fs-specific
> handle to a local cache file.

I just thought of the fh_to_dentry stuff that is used by knfsd. Those
fh keys should be just the right (and fs independent) thing to index
such a generic fs-cache with.

Jan

