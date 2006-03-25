Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751032AbWCYBR5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751032AbWCYBR5 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Mar 2006 20:17:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751070AbWCYBR5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Mar 2006 20:17:57 -0500
Received: from saraswathi.solana.com ([198.99.130.12]:43162 "EHLO
	saraswathi.solana.com") by vger.kernel.org with ESMTP
	id S1751012AbWCYBR5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Mar 2006 20:17:57 -0500
Date: Fri, 24 Mar 2006 20:19:03 -0500
From: Jeff Dike <jdike@addtoit.com>
To: Blaisorblade <blaisorblade@yahoo.it>
Cc: user-mode-linux-devel@lists.sourceforge.net, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: [uml-devel] Re: [PATCH 12/16] UML - Memory hotplug
Message-ID: <20060325011903.GC8117@ccure.user-mode-linux.org>
References: <200603241814.k2OIExNn005555@ccure.user-mode-linux.org> <20060324144535.37b3daf7.akpm@osdl.org> <200603250058.57700.blaisorblade@yahoo.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200603250058.57700.blaisorblade@yahoo.it>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 25, 2006 at 12:58:57AM +0100, Blaisorblade wrote:
> > +int os_drop_memory(void *addr, int length)
> > +{
> > +     int err;
> > +
> > +     err = madvise(addr, length, MADV_REMOVE);
> > +     if(err < 0)
> > +             err = -errno;
> 
> Jeff, did you mean the "return _0_" rather than "return err" below? It's 
> incoherent with the existance of the "err" local.
> 
> > +     return 0;
> > +}

That's just a brain fart - will fix.

				Jeff
