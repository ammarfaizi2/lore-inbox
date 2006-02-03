Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750973AbWBCIfa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750973AbWBCIfa (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Feb 2006 03:35:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751120AbWBCIfa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Feb 2006 03:35:30 -0500
Received: from smtp17.wxs.nl ([195.121.247.8]:24316 "EHLO smtp17.wxs.nl")
	by vger.kernel.org with ESMTP id S1750994AbWBCIf3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Feb 2006 03:35:29 -0500
Date: Fri, 03 Feb 2006 09:34:48 +0100
From: Kars de Jong <jongk@linux-m68k.org>
Subject: Re: [PATCH] Introduce __iowrite32_copy
In-reply-to: <20060203063047.GX27946@ftp.linux.org.uk>
To: Al Viro <viro@ftp.linux.org.uk>
Cc: linux-m68k@vger.kernel.org, linux-kernel@vger.kernel.org,
       "Bryan O'Sullivan" <bos@pathscale.com>,
       Martin Schwidefsky <schwidefsky@de.ibm.com>, Olaf Hering <olh@suse.de>,
       Heiko Carstens <heiko.carstens@de.ibm.com>
Message-id: <1138955689.5570.6.camel@laptop-lcs.localdomain>
MIME-version: 1.0
X-Mailer: Evolution 2.2.3
Content-type: text/plain
Content-transfer-encoding: 7BIT
References: <200602011820.k11IKUBo024575@hera.kernel.org>
 <20060202142917.GA10870@suse.de>
 <20060202145720.GE22815@osiris.boeblingen.de.ibm.com>
 <20060203063047.GX27946@ftp.linux.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On vr, 2006-02-03 at 06:30 +0000, Al Viro wrote:
> On Thu, Feb 02, 2006 at 03:57:20PM +0100, Heiko Carstens wrote:
> > > lib/iomap_copy.c: In function '__iowrite32_copy':
> > > lib/iomap_copy.c:40: error: implicit declaration of function '__raw_writel'
> > > 
> > > We compile with -Werror-implicit-function-declaration, and s390 does not
> > > have a __raw_writel.
> > > Should it just define __raw_writel to writel, like uml does a few
> > > commits later?
> > 
> > I sent a patch which fixes this for s390 earlier today.
> > http://lkml.org/lkml/2006/2/2/78
> 
> Which leaves mips, m68k and sh64...  For m68k cross-builds I've added
> #define __raw_writel raw_outl in raw_io.h, but I'm not sure if m68k
> folks are OK with that.  Comments?

That's exactly what I have done in my local tree for the 53c700 driver
which uses the interfaces of lib/iomap.c, so it's fine with me.


Kind regards,

Kars.


