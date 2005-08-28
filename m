Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750776AbVH1UGD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750776AbVH1UGD (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 28 Aug 2005 16:06:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750781AbVH1UGD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 28 Aug 2005 16:06:03 -0400
Received: from courier.cs.helsinki.fi ([128.214.9.1]:20679 "EHLO
	mail.cs.helsinki.fi") by vger.kernel.org with ESMTP
	id S1750776AbVH1UGD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 28 Aug 2005 16:06:03 -0400
Subject: Re: [PATCH 1/7] spufs: The SPU file system
From: Pekka Enberg <penberg@cs.helsinki.fi>
To: Arnd Bergmann <arnd@arndb.de>
Cc: linuxppc64-dev@ozlabs.org, linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <200508281844.18187.arnd@arndb.de>
References: <200508260003.40865.arnd@arndb.de>
	 <84144f02050826011778e1142@mail.gmail.com>
	 <200508281844.18187.arnd@arndb.de>
Date: Sun, 28 Aug 2005 23:05:27 +0300
Message-Id: <1125259528.3007.4.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution 2.2.3 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2005-08-28 at 18:44 +0200, Arnd Bergmann wrote:
> I never really thought of it as a device driver but rather an architecture
> extension, so it started out in arch/ppc64/kernel. Since most of the code
> is interacting with VFS, it is now in fs/spufs. I don't really care about
> the location, but I among the possible places to put the code (with the
> unified arch/powerpc tree), I'd suggest (best first)
> 
> 1) arch/powerpc/platforms/cell
> 2) arch/powerpc/spe
> 3) fs/spufs
> 4) drivers/spe
> 
> 1) would be the place where I want to have the low-level code
> (currently arch/ppc64/kernel/spu_base.c) anyway, so it makes
> sense to have everything in there that I maintain.

I am happy with 1, 2, and 4. You could, of course, abstract away the
general purpose parts of spufs (for example, if we had other similar
architecture extensions that could share the code) and put them in 3 but
that would probably just introduce unnecessary complexity.

			Pekka

