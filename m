Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261993AbUCGO0H (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 7 Mar 2004 09:26:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262042AbUCGO0H
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Mar 2004 09:26:07 -0500
Received: from ns.suse.de ([195.135.220.2]:50113 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S261993AbUCGO0E (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Mar 2004 09:26:04 -0500
Subject: Re: External kernel modules, second try
From: Andreas Gruenbacher <agruen@suse.de>
To: arjanv@redhat.com
Cc: Sam Ravnborg <sam@ravnborg.org>, lkml <linux-kernel@vger.kernel.org>,
       kbuild-devel@lists.sourceforge.net
In-Reply-To: <1078668091.9106.1.camel@laptop.fenrus.com>
References: <1078620297.3156.139.camel@nb.suse.de>
	 <20040307125348.GA2020@mars.ravnborg.org>
	 <1078664629.9812.1.camel@laptop.fenrus.com>
	 <1078667199.3594.50.camel@nb.suse.de>
	 <1078668091.9106.1.camel@laptop.fenrus.com>
Content-Type: text/plain
Organization: SUSE Labs, SUSE LINUX AG
Message-Id: <1078669600.4168.10.camel@nb.suse.de>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4 
Date: Sun, 07 Mar 2004 15:26:40 +0100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2004-03-07 at 15:01, Arjan van de Ven wrote:
> On Sun, 2004-03-07 at 14:46, Andreas Gruenbacher wrote:
> >  and it's missing the symbols from
> > module files.
> 
> sure but the module files are generally installed...

Not when building for five different configurations on one machine. (And
this is not a theoretical case.)

> > Now it would be possible to extract the modver symbols from the
> > installed vmlinux and .ko files when needed, but note that we may be
> > building modules for kernels that are not currently running, and for
> > which those binaries are not even installed. So this sounds like a bad
> > idea.
> 
> I don't personally care about those; you need SOME stuff to build
> against obviously, and vmlinux is well over the top I agree that. But
> assuming the .ko's for the modules are there...you need those to use the
> kernel anyway.

The .ko's are really not there. And even if they were, I don't think we
want to teach modpost to poke around in /lib/modules when it can be
avoided easily.


Cheers,
-- 
Andreas Gruenbacher <agruen@suse.de>
SUSE Labs, SUSE LINUX AG

