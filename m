Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1753501AbWKHIao@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753501AbWKHIao (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Nov 2006 03:30:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754449AbWKHIao
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Nov 2006 03:30:44 -0500
Received: from smtp.osdl.org ([65.172.181.4]:9193 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1753501AbWKHIan (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Nov 2006 03:30:43 -0500
Date: Wed, 8 Nov 2006 00:30:28 -0800
From: Andrew Morton <akpm@osdl.org>
To: Avi Kivity <avi@qumranet.com>
Cc: Roland Dreier <rdreier@cisco.com>, kvm-devel@lists.sourceforge.net,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/14] KVM: Kernel-based Virtual Machine (v4)
Message-Id: <20061108003028.6212045b.akpm@osdl.org>
In-Reply-To: <45519033.3060409@qumranet.com>
References: <454E4941.7000108@qumranet.com>
	<20061107204440.090450ea.akpm@osdl.org>
	<adafycuh77b.fsf@cisco.com>
	<455183EA.2020405@qumranet.com>
	<20061107233323.c984fa9b.akpm@osdl.org>
	<45519033.3060409@qumranet.com>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.17; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 08 Nov 2006 10:07:15 +0200
Avi Kivity <avi@qumranet.com> wrote:

> Andrew Morton wrote:
> > On Wed, 08 Nov 2006 09:14:50 +0200
> > Avi Kivity <avi@qumranet.com> wrote:
> >
> >   
> >> Roland Dreier wrote:
> >>     
> >>>  > That's gas 2.16.1.  I assume it needs some super-new binutils.
> >>>  > 
> >>>  > I'm not sure what to do about this.  What's the minimum version?
> >>>
> >>> According to http://kvm.sourceforge.net/howto.html :
> >>>     A recent enough binutils (>= 2.16.91.0.2) for vmx instruction support
> >>>   
> >>>       
> >> Either that or a bunch of ugly .byte macros.
> >>
> >>     
> >
> > I think we could live with the binutils requirement as long as we can find
> > some automagic way of not breaking people's `make allmodconfig'.  Because
> > quite a lot of those people who do cross-compilation tend to use older
> > binutilses.
> >   
> 
> These crosses are usually for $wierd target on x86 host, right?

Not necessarily.  If you're going to build kernels with distcc then you
need the same toolchain on all machines, so you probably build it with
crosstool.

Or if you want a consistent, tested, internally-maintained build
environment then you use a specific toolchain so your developers aren't
dependent on whatever their distro happened to put in /usr/bin

> 
> config AS_VERSION
>         eval as --version | awk '{ ... }'
> 
> ?

It'd be more complex than that :(
