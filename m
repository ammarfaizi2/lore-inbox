Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262211AbVCODB7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262211AbVCODB7 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Mar 2005 22:01:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262212AbVCODB7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Mar 2005 22:01:59 -0500
Received: from fire.osdl.org ([65.172.181.4]:10654 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262211AbVCODB5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Mar 2005 22:01:57 -0500
Date: Mon, 14 Mar 2005 19:01:40 -0800
From: Andrew Morton <akpm@osdl.org>
To: Phillip Lougher <phillip@lougher.demon.co.uk>
Cc: greg@kroah.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH][2/2] SquashFS
Message-Id: <20050314190140.5496221b.akpm@osdl.org>
In-Reply-To: <A572579D-94EF-11D9-8833-000A956F5A02@lougher.demon.co.uk>
References: <20050314170653.1ed105eb.akpm@osdl.org>
	<A572579D-94EF-11D9-8833-000A956F5A02@lougher.demon.co.uk>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Phillip Lougher <phillip@lougher.demon.co.uk> wrote:
>
> [ on-disk bitfields ]
> 
> I've checked compatibilty against Intel 32 and 64 bit architectures, 
>  PPC 32/64 bit, ARM, MIPS
>  and SPARC.  I've used compilers from 2.91.x upto 3.4...

hm, OK.  I remain a bit skeptical but it sounds like you're the expert.  I
guess if things later explode it will be pretty obvious, and the filesystem
will need rework.

One thing which I assume we don't know at this stage is whether all 27
architectures work as expected - you can bet ia64 does it differently ;)

How does one test that?  Create a filesystem-in-a-file via mksquashfs, then
transfer that to a different box, then try and mount and use it, I assume?

When you upissue these patches, please include in the changelog pointers to
the relevant userspace support tools - mksquashfs, fsck.squashfs, etc.  I
guess http://squashfs.sourceforge.net/ will suit.

Also, this filesystem seems to do the same thing as cramfs.  We'd need to
understand in some detail what advantages squashfs has over cramfs to
justify merging it.  Again, that is something which is appropriate to the
changelog for patch 1/1.
