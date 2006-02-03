Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964922AbWBCGaz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964922AbWBCGaz (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Feb 2006 01:30:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964920AbWBCGaz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Feb 2006 01:30:55 -0500
Received: from zeniv.linux.org.uk ([195.92.253.2]:53421 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S964919AbWBCGay
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Feb 2006 01:30:54 -0500
Date: Fri, 3 Feb 2006 06:30:47 +0000
From: Al Viro <viro@ftp.linux.org.uk>
To: Heiko Carstens <heiko.carstens@de.ibm.com>
Cc: Olaf Hering <olh@suse.de>, Martin Schwidefsky <schwidefsky@de.ibm.com>,
       "Bryan O'Sullivan" <bos@pathscale.com>, linux-kernel@vger.kernel.org,
       linux-m68k@vger.kernel.org
Subject: Re: [PATCH] Introduce __iowrite32_copy
Message-ID: <20060203063047.GX27946@ftp.linux.org.uk>
References: <200602011820.k11IKUBo024575@hera.kernel.org> <20060202142917.GA10870@suse.de> <20060202145720.GE22815@osiris.boeblingen.de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060202145720.GE22815@osiris.boeblingen.de.ibm.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 02, 2006 at 03:57:20PM +0100, Heiko Carstens wrote:
> > lib/iomap_copy.c: In function '__iowrite32_copy':
> > lib/iomap_copy.c:40: error: implicit declaration of function '__raw_writel'
> > 
> > We compile with -Werror-implicit-function-declaration, and s390 does not
> > have a __raw_writel.
> > Should it just define __raw_writel to writel, like uml does a few
> > commits later?
> 
> I sent a patch which fixes this for s390 earlier today.
> http://lkml.org/lkml/2006/2/2/78

Which leaves mips, m68k and sh64...  For m68k cross-builds I've added
#define __raw_writel raw_outl in raw_io.h, but I'm not sure if m68k
folks are OK with that.  Comments?
