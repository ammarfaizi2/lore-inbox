Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261378AbUDHCAQ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Apr 2004 22:00:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261422AbUDHCAP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Apr 2004 22:00:15 -0400
Received: from ozlabs.org ([203.10.76.45]:14566 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S261378AbUDHCAK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Apr 2004 22:00:10 -0400
Date: Thu, 8 Apr 2004 11:57:10 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Andrew Morton <akpm@osdl.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>,
       Anton Blanchard <anton@samba.org>, Paul Mackerras <paulus@samba.org>,
       linuxppc64-dev <linuxppc64-dev@lists.linuxppc.org>
Subject: Re: RFC: COW for hugepages
Message-ID: <20040408015710.GC20320@zax>
Mail-Followup-To: David Gibson <david@gibson.dropbear.id.au>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Andrew Morton <akpm@osdl.org>,
	Linux Kernel list <linux-kernel@vger.kernel.org>,
	Anton Blanchard <anton@samba.org>, Paul Mackerras <paulus@samba.org>,
	linuxppc64-dev <linuxppc64-dev@lists.linuxppc.org>
References: <20040407074239.GG18264@zax> <20040407005353.45323dcd.akpm@osdl.org> <1081326594.1382.54.camel@gaston>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1081326594.1382.54.camel@gaston>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 07, 2004 at 06:29:54PM +1000, Benjamin Herrenschmidt wrote:
> On Wed, 2004-04-07 at 17:53, Andrew Morton wrote:
> > David Gibson <david@gibson.dropbear.id.au> wrote:
> > >
> > > Doing the COW for hugepages turns out not to be terribly difficult.
> > >  Is there any reason not to apply this patch?
> > 
> > Not much, except that it adds stuff to the kernel.
> > 
> > Does anyone actually have a real-world need for the feature?
> 
> Yup, porting some apps to use hugepages, when those apps
> rely on fork & cow semantics typically. Also, implicit use of
> hugepages (usually via a malloc override library).

I also have some experimental patches for putting ELF segments into
large pages (for HPC FORTRAN monsters with massive arrays in the BSS).
MAP_PRIVATE semantics (and hence COW) are a clear prerequisite for
that.

-- 
David Gibson			| For every complex problem there is a
david AT gibson.dropbear.id.au	| solution which is simple, neat and
				| wrong.
http://www.ozlabs.org/people/dgibson
