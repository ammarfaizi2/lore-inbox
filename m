Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263468AbTIHSmd (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Sep 2003 14:42:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263477AbTIHSmd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Sep 2003 14:42:33 -0400
Received: from pix-525-pool.redhat.com ([66.187.233.200]:17531 "EHLO
	lacrosse.corp.redhat.com") by vger.kernel.org with ESMTP
	id S263468AbTIHSm1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Sep 2003 14:42:27 -0400
Date: Mon, 8 Sep 2003 19:41:17 +0100
From: Dave Jones <davej@redhat.com>
To: Stian Jordet <liste@jordet.nu>
Cc: Mika Liljeberg <mika.liljeberg@welho.com>, linux-kernel@vger.kernel.org,
       dri-users@lists.sourceforge.net
Subject: Re: New ATI FireGL driver supports 2.6 kernel
Message-ID: <20030908184117.GA681@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Stian Jordet <liste@jordet.nu>,
	Mika Liljeberg <mika.liljeberg@welho.com>,
	linux-kernel@vger.kernel.org, dri-users@lists.sourceforge.net
References: <1063044345.1895.10.camel@hades> <1063045080.21991.13.camel@chevrolet.hybel>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1063045080.21991.13.camel@chevrolet.hybel>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 08, 2003 at 06:18:01PM +0000, Stian Jordet wrote:
 > man, 08.09.2003 kl. 18.05 skrev Mika Liljeberg:
 > > Hi All,
 > > 
 > > Just in case anyone is interested, ATI has released version 3.2.5 of
 > > their FireGL driver for XFree86. The driver supports all their high end
 > > graphics cards. This is the first version that has DRM support for the
 > > 2.6 series of kernels.
 > 
 > Well.. Not really :)
 > 
 > chevrolet:/lib/modules/fglrx/build_mod/2.6.x# make
 > make -C /lib/modules/2.6.0-test4/build
 > SUBDIRS=/lib/modules/fglrx/build_mod/2.6.x modules
 > make[1]: Entering directory `/usr/src/linux-2.6.0-test4'
 > make[2]: `arch/i386/kernel/asm-offsets.s' is up to date.
 > *** Warning: Overriding SUBDIRS on the command line can cause
 > ***          inconsistencies
 >   CC [M]  /lib/modules/fglrx/build_mod/2.6.x/agp3.o
 >   CC [M]  /lib/modules/fglrx/build_mod/2.6.x/nvidia-agp.o
 >   CC [M]  /lib/modules/fglrx/build_mod/2.6.x/agpgart_be.o
 >   CC [M]  /lib/modules/fglrx/build_mod/2.6.x/i7505-agp.o
 >   CC [M]  /lib/modules/fglrx/build_mod/2.6.x/firegl_public.o

Comedy. So the story so far..

- ATI grab 2.4.16's AGP driver.
- Working AGP3 support happens in 2.5
- ATI gets backported to 2.4 and 'munged'.
- Additional fixes go into 2.5
- ATI forwardport their trainwreck to 2.6.

It shouldn't have *any* need whatsoever to touch agpgart in 2.6.

The mind truly boggles.

		Dave

-- 
 Dave Jones     http://www.codemonkey.org.uk
