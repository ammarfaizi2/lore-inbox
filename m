Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261153AbUBTK2T (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Feb 2004 05:28:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261154AbUBTK2T
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Feb 2004 05:28:19 -0500
Received: from delerium.kernelslacker.org ([81.187.208.145]:21226 "EHLO
	delerium.codemonkey.org.uk") by vger.kernel.org with ESMTP
	id S261153AbUBTK2S (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Feb 2004 05:28:18 -0500
Date: Fri, 20 Feb 2004 10:25:40 +0000
From: Dave Jones <davej@redhat.com>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: ak@suse.de
Subject: Re: [PATCH] x86_64 uniproc build fix
Message-ID: <20040220102540.GH28997@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	ak@suse.de
References: <200402200611.i1K6Bn6s029706@hera.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200402200611.i1K6Bn6s029706@hera.kernel.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 20, 2004 at 05:42:12AM +0000, Linux Kernel wrote:

 > --- a/arch/x86_64/kernel/Makefile	Thu Feb 19 22:11:54 2004
 > +++ b/arch/x86_64/kernel/Makefile	Thu Feb 19 22:11:54 2004
 > @@ -33,4 +33,4 @@
 >  cpuid-$(subst m,y,$(CONFIG_X86_CPUID))  += ../../i386/kernel/cpuid.o
 >  topology-y                     += ../../i386/mach-default/topology.o
 >  swiotlb-$(CONFIG_SWIOTLB)      += ../../ia64/lib/swiotlb.o
 > -microcode-$(CONFIG_MICROCODE)  += ../../i386/kernel/microcode.o
 > +microcode-$(subst m,y,$(CONFIG_X86_CPUID))  += ../../i386/kernel/microcode.o
                                       ^^^^^
Eh ?

		Dave
