Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932434AbWHHESA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932434AbWHHESA (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Aug 2006 00:18:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932479AbWHHESA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Aug 2006 00:18:00 -0400
Received: from koto.vergenet.net ([210.128.90.7]:9357 "EHLO koto.vergenet.net")
	by vger.kernel.org with ESMTP id S932434AbWHHER7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Aug 2006 00:17:59 -0400
Date: Tue, 8 Aug 2006 12:34:07 +0900
From: Horms <horms@verge.net.au>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: vgoyal@in.ibm.com, fastboot@osdl.org, linux-kernel@vger.kernel.org,
       Jan Kratochvil <lace@jankratochvil.net>,
       "H. Peter Anvin" <hpa@zytor.com>, Magnus Damm <magnus.damm@gmail.com>,
       Linda Wang <lwang@redhat.com>
Subject: Re: [RFC] ELF Relocatable x86 and x86_64 bzImages
Message-ID: <20060808033405.GA6767@verge.net.au>
References: <m1d5bk2046.fsf@ebiederm.dsl.xmission.com> <20060804225611.GG19244@in.ibm.com> <m1k65onleq.fsf@ebiederm.dsl.xmission.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <m1k65onleq.fsf@ebiederm.dsl.xmission.com>
User-Agent: Mutt/1.5.12-2006-07-14
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 04, 2006 at 05:14:37PM -0600, Eric W. Biederman wrote:
> Vivek Goyal <vgoyal@in.ibm.com> writes:
> 
> > On Tue, Aug 01, 2006 at 04:58:49AM -0600, Eric W. Biederman wrote:
> >> 
> >> The problem:
> >> 
> >> We can't always run the kernel at 1MB or 2MB, and so people who need
> >> different addresses must build multiple kernels.  The bzImage format
> >> can't even represent loading a kernel at other than it's default address.
> >> With kexec on panic now starting to be used by distros having a kernel
> >> not running at the default load address is starting to become common.
> >> 
> > Hi Eric,
> >
> > There seems to be a small anomaly in the current set of patches for i386.
> >
> > For example if one compiles the kernel with CONFIG_RELOCATABLE=y
> > and CONFIG_PHYSICAL_START=0x400000 (4MB) and he uses grub to load
> > the kernel then kernel would run from 1MB location. I think user would
> > expect it to run from 4MB location.
> 
> Agreed.  That is a non-intuitive, and should probably be fixed.

I also agree that it is non-intitive. But I wonder if a cleaner
fix would be to remove CONFIG_PHYSICAL_START all together. Isn't
it just a work around for the kernel not being relocatable, or
are there uses for it that relocation can't replace?

-- 
Horms
  H: http://www.vergenet.net/~horms/
  W: http://www.valinux.co.jp/en/

