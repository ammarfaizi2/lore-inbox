Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262774AbULQI1c@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262774AbULQI1c (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Dec 2004 03:27:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262782AbULQI1b
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Dec 2004 03:27:31 -0500
Received: from mta1.cl.cam.ac.uk ([128.232.0.15]:5014 "EHLO mta1.cl.cam.ac.uk")
	by vger.kernel.org with ESMTP id S262774AbULQI0b (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Dec 2004 03:26:31 -0500
To: Andi Kleen <ak@suse.de>
cc: Ian Pratt <Ian.Pratt@cl.cam.ac.uk>, Andrew Morton <akpm@osdl.org>,
       alan@lxorguk.ukuu.org.uk, riel@redhat.com, linux-kernel@vger.kernel.org,
       Steven.Hand@cl.cam.ac.uk, Christian.Limpach@cl.cam.ac.uk,
       Keir.Fraser@cl.cam.ac.uk, Ian.Pratt@cl.cam.ac.uk
Subject: Re: arch/xen is a bad idea 
In-reply-to: Your message of "Fri, 17 Dec 2004 07:04:56 +0100."
             <20041217060456.GD12049@wotan.suse.de> 
Date: Fri, 17 Dec 2004 08:26:17 +0000
From: Ian Pratt <Ian.Pratt@cl.cam.ac.uk>
Message-Id: <E1CfDRM-0005Ub-00@mta1.cl.cam.ac.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> On Thu, Dec 16, 2004 at 09:36:36PM +0000, Ian Pratt wrote:
> > > Ian Pratt <Ian.Pratt@cl.cam.ac.uk> wrote:
> > > >
> > > > I'm not convinced that maintaining xen/i386 in its current form
> > > >  is going to be as hard as Andi thinks. We already share many
> > > >  files unmodified from i386.
> > > 
> > > How are they shared?  Inclusion, symlinks, makefile references or
> > 
> > The makefile creates symlinks. 
> 
> That's deprecated because it breaks with separate objdirs (make O=/other/dir) 
> See the x86-64 makefiles on how to do it properly. 

Ah, I wasn't previously aware of the O= capability to know that we
were breaking it. 

We can trivially change over to referencing files in arch/i386
directly from the Makefile. The only downside is that it will
make navigating the source slightly harder.


Ian

