Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261812AbUCCNvT (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Mar 2004 08:51:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262335AbUCCNvS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Mar 2004 08:51:18 -0500
Received: from mx1.redhat.com ([66.187.233.31]:7118 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261812AbUCCNvR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Mar 2004 08:51:17 -0500
Date: Wed, 3 Mar 2004 08:51:49 -0500 (EST)
From: James Morris <jmorris@redhat.com>
X-X-Sender: jmorris@thoron.boston.redhat.com
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
cc: Glen Nakamura <glen@imodulo.com>, <linux-kernel@vger.kernel.org>,
       "David S. Miller" <davem@redhat.com>
Subject: Re: Mysterious string truncation in 2.4.25 kernel
In-Reply-To: <Pine.LNX.4.44.0403030712570.2537-100000@dmt.cyclades>
Message-ID: <Xine.LNX.4.44.0403030850250.1101-100000@thoron.boston.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 3 Mar 2004, Marcelo Tosatti wrote:

> 
> 
> On Wed, 3 Mar 2004, James Morris wrote:
> 
> > On Tue, 2 Mar 2004, Glen Nakamura wrote:
> > 
> > > Of course, perhaps 0 should passed instead of "" for data_page?
> > > 
> > > -    err = do_mount ("none", "/dev", "devfs", 0, "");
> > > +    err = do_mount ("none", "/dev", "devfs", 0, 0);
> > >
> > > Comments?
> > 
> > Yes, the devfs fix above is needed if the data_page patch has been 
> > applied.  
> > 
> > This is the case in 2.6, but not 2.4.25.
> 
> My bad :(
> 
> Changed last argument of fs/devfs/base.c do_mount() call to NULL, as per 
> 2.6.
> 
> James, wonder if your change can't cause other similar problems in 2.4? 

Looks like sunos_nfs_mount() needs to be fixed to pass a page as the last 
argument of do_mount().


- James
-- 
James Morris
<jmorris@redhat.com>


