Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266291AbUFPNIx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266291AbUFPNIx (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Jun 2004 09:08:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266287AbUFPNI2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Jun 2004 09:08:28 -0400
Received: from louise.pinerecords.com ([213.168.176.16]:38021 "EHLO
	louise.pinerecords.com") by vger.kernel.org with ESMTP
	id S266291AbUFPNFk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Jun 2004 09:05:40 -0400
Date: Wed, 16 Jun 2004 15:05:23 +0200
From: Tomas Szepe <szepe@pinerecords.com>
To: Dave Kleikamp <shaggy@austin.ibm.com>
Cc: Linus Torvalds <torvalds@osdl.org>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: JFS compilation fix [was Re: Linux 2.6.7]
Message-ID: <20040616130523.GE1571@louise.pinerecords.com>
References: <Pine.LNX.4.58.0406152253390.6392@ppc970.osdl.org> <20040616080740.GC23998@louise.pinerecords.com> <1087390524.29047.10.camel@shaggy.austin.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1087390524.29047.10.camel@shaggy.austin.ibm.com>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Jun-16 2004, Wed, 07:55 -0500
Dave Kleikamp <shaggy@austin.ibm.com> wrote:

> On Wed, 2004-06-16 at 03:07, Tomas Szepe wrote:
> > Here's a trivial patch to fix JFS compilation in 2.6.7.  The error
> > only happens in specific configs -- one such config can be found here:
> > http://www.pinerecords.com/kala/_nonpub/.config.louise26
> 
> I don't know why gcc-3.2.2 doesn't complain about this one, as I have
> compiled this numerous times.
> 
> Your patch has an unnecessary include of jfs_dtree.h.  jfs_dtree.h is
> included by jfs_inline.h, and is not needed in jfs_dtree.c.

Oh, right.

> > I don't have the time to narrow the problem down to the config
> > entry that gets jfs_dtree.c to include jfs_dtree.h (jfs_dtree.c
> > itself doesn't have any relevat ifdefs).
> 
> My guess is the config entry is CONFIG_JFS_FS. :^)

Well, it just so happens that I have two .config files, both listing
CONFIG_JFS_FS=m, and without the patch, exactly one of them fails
compilation (on the same cluster, distcc gcc 3.4.0).  That is why
I assumed the include was missing -- the moving of the declaration
in my patch was only meant as an extra clean up for bonus points.
;)

-- 
Tomas Szepe <szepe@pinerecords.com>
