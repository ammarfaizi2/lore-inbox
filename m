Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932423AbWHQEm3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932423AbWHQEm3 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Aug 2006 00:42:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932424AbWHQEm3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Aug 2006 00:42:29 -0400
Received: from pasmtpa.tele.dk ([80.160.77.114]:20122 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id S932423AbWHQEm3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Aug 2006 00:42:29 -0400
Date: Thu, 17 Aug 2006 06:42:28 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: 7eggert@gmx.de
Cc: clowncoder <clowncoder@clowncode.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: New version of ClownToolKit
Message-ID: <20060817044228.GA16320@mars.ravnborg.org>
References: <6Kxx5-7PT-7@gated-at.bofh.it> <6KyCM-1w7-1@gated-at.bofh.it> <E1GDUcG-00016M-Nu@be1.lrz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1GDUcG-00016M-Nu@be1.lrz>
User-Agent: Mutt/1.5.12-2006-07-14
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 17, 2006 at 01:15:43AM +0200, Bodo Eggert wrote:
> Sam Ravnborg <sam@ravnborg.org> wrote:
> 
> > A small nitpick about the way ou build the ekrnel module:
> > 
> > In mk_and_insmod you can replace:
> > make -C /usr/src/linux SUBDIRS=$PWD modules
> > with
> > LIBDIR=/lib/modules/`uname -r`
> > make -C $LIBDIR/source O=$LIBDIR/build SUBDIRS=`pwd` modules
> > 
> > For a normal kernel installation this will do the right thing.
> > source points to the kernel source and build point to the output
> > directory (they are often equal but not always).
> 
> Please don't tell module authors to unconditionally use `uname -r`.
> I frequently build kernels for differentd hosts, and if I don't, I'll
> certainly compile the needed modules before installing the kernel.
> Therefore /lib/modules/`uname -r` is most certainly the completely
> wrong place to look for the kernel source.
/lib/modules/`uname -r` is the general solution that works for most
people and should be at least default. It is certainly better than
/usr/src/linux.
But yes they better make it override able.

	Sam
