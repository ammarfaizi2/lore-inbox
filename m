Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261891AbUC0V4V (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 27 Mar 2004 16:56:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261897AbUC0V4U
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 27 Mar 2004 16:56:20 -0500
Received: from fw.osdl.org ([65.172.181.6]:45789 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261891AbUC0V4T (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 27 Mar 2004 16:56:19 -0500
Date: Sat, 27 Mar 2004 13:55:57 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Matthew Wilcox <willy@debian.org>
cc: Andrew Morton <akpm@zip.com.au>, "David S. Miller" <davem@redhat.com>,
       Anton Blanchard <anton@samba.org>,
       Martin Schwidefsky <schwidefsky@de.ibm.com>, Andi Kleen <ak@suse.de>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] compat_sys_mount
In-Reply-To: <20040327152623.GM25059@parcelfarce.linux.theplanet.co.uk>
Message-ID: <Pine.LNX.4.58.0403271341260.20100@ppc970.osdl.org>
References: <20040327152623.GM25059@parcelfarce.linux.theplanet.co.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sat, 27 Mar 2004, Matthew Wilcox wrote:
> 
> This patch replaces 6 implementations of various quality of sys32_mount
> with a shiny new compat_sys_mount().  It's been tested on parisc64 and
> sparc64 and fixes a bug exposed by the latest revision of Debian's
> initscripts.  Thanks to Arnd Bergmann and Dave Miller for their
> suggestions, fixes and testing.

Ok. This clashed with a number of architectures having fixed the bugs on
their own lately, but I tried to merge it all and it looked obvious, so it
_should_ be ok. Can you guys verify that the merge was ok, and that all
the fixes that the architectures had are also in the new compat layer
version?

		Linus
