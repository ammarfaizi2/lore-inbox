Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262656AbTFGH0G (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 Jun 2003 03:26:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262657AbTFGH0G
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 Jun 2003 03:26:06 -0400
Received: from carisma.slowglass.com ([195.224.96.167]:57102 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S262656AbTFGH0F (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 Jun 2003 03:26:05 -0400
Date: Sat, 7 Jun 2003 08:39:29 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Stewart Smith <stewart@linux.org.au>
Cc: Linus Torvalds <torvalds@transmeta.com>, Jeff Garzik <jgarzik@pobox.com>,
       David Woodhouse <dwmw2@infradead.org>, linux-kernel@vger.kernel.org
Subject: Re: [EVIL-PATCH] getting rid of lib/lib.a and breaking many archs in the processes (was Re: [PATCH] fixed: CRC32=y && 8193TOO=m unresolved symbols)
Message-ID: <20030607083929.A19009@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Stewart Smith <stewart@linux.org.au>,
	Linus Torvalds <torvalds@transmeta.com>,
	Jeff Garzik <jgarzik@pobox.com>,
	David Woodhouse <dwmw2@infradead.org>, linux-kernel@vger.kernel.org
References: <20030604153224.GF19929@gtf.org> <Pine.LNX.4.44.0306040838370.13753-100000@home.transmeta.com> <20030607073321.GC1540@cancer>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20030607073321.GC1540@cancer>; from stewart@linux.org.au on Sat, Jun 07, 2003 at 05:33:21PM +1000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 07, 2003 at 05:33:21PM +1000, Stewart Smith wrote:
> Is it a good idea to make the archs themselves include the generic implementation if they don't do it themselves? Or is there a way to detect this in the build system (this would be more elegant, but I have no idea how to do it).

You can always add a HAVE_ARCH_FOO #define.  Btw, we have so many
of those these days that an <asm/config.h> for them might be a better
choice than polluting random other header.  Opinions?

