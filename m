Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262796AbUKRRo2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262796AbUKRRo2 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Nov 2004 12:44:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262804AbUKRRnk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Nov 2004 12:43:40 -0500
Received: from mta1.cl.cam.ac.uk ([128.232.0.15]:60308 "EHLO mta1.cl.cam.ac.uk")
	by vger.kernel.org with ESMTP id S262808AbUKRRig (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Nov 2004 12:38:36 -0500
To: Roland Dreier <roland@topspin.com>
cc: Andi Kleen <ak@suse.de>, Ian Pratt <Ian.Pratt@cl.cam.ac.uk>,
       linux-kernel@vger.kernel.org, Ian.Pratt@cl.cam.ac.uk
Subject: Re: Xen 2.0 VMM patches 
In-reply-to: Your message of "Thu, 18 Nov 2004 09:26:00 PST."
             <52vfc3kr13.fsf@topspin.com> 
Date: Thu, 18 Nov 2004 17:38:21 +0000
From: Ian Pratt <Ian.Pratt@cl.cam.ac.uk>
Message-Id: <E1CUqEg-0004K3-00@mta1.cl.cam.ac.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>     Andi> Overall I think it's a bad idea to have four different x86
>     Andi> like architectures in the tree. Especially since there will
>     Andi> be likely more hypervisors over time.  i386 and x86-64 make
>     Andi> some sense because 64bit is a natural boundary, but
>     Andi> extending it elsewhere doesn't scale very well.
> 
> Is there any possibility of Xen someday being ported to some non-x86
> architecture (eg ppc64 or ia64)?

Non x86 architectures are generally much easier to virtualise, so
its possible to do it within the existing architecture port.

As a case in point, the soon-to-be-released IA64 port of Linux
just requires just a few patches to the standard architecture. I
expect PPC will be fairly similar.

x86 and x86_64 are a real pain, hence the separate architecture
approach. 

Over time, I hope we can merge the i386 xen port in with the
native architecture, but its going to require significant
restructuring of the native architecture to do it cleanly.  In
the meantime, I think we just have to bite the bullet and
maintain a separate architecture. I believe we have resources to
do this.

Ian

