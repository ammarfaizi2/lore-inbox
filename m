Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932163AbWCWGrg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932163AbWCWGrg (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Mar 2006 01:47:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932434AbWCWGrg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Mar 2006 01:47:36 -0500
Received: from 216-99-217-87.dsl.aracnet.com ([216.99.217.87]:26752 "EHLO
	sorel.sous-sol.org") by vger.kernel.org with ESMTP id S932163AbWCWGrf
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Mar 2006 01:47:35 -0500
Date: Wed, 22 Mar 2006 22:47:50 -0800
From: Chris Wright <chrisw@sous-sol.org>
To: Eli Collins <ecollins@vmware.com>
Cc: Chris Wright <chrisw@sous-sol.org>, linux-kernel@vger.kernel.org,
       virtualization@lists.osdl.org,
       Christian Limpach <Christian.Limpach@cl.cam.ac.uk>,
       xen-devel@lists.xensource.com, Ian Pratt <ian.pratt@xensource.com>
Subject: Re: [Xen-devel] [RFC PATCH 25/35] Add Xen time abstractions
Message-ID: <20060323064750.GV15997@sorel.sous-sol.org>
References: <20060322063040.960068000@sorel.sous-sol.org> <20060322063800.241815000@sorel.sous-sol.org> <442214A0.2000004@vmware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <442214A0.2000004@vmware.com>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Eli Collins (ecollins@vmware.com) wrote:
> >--- xen-subarch-2.6.orig/arch/i386/kernel/Makefile
> >+++ xen-subarch-2.6/arch/i386/kernel/Makefile
> >@@ -9,8 +9,11 @@ obj-y	:= process.o semaphore.o signal.o 
> > 		pci-dma.o i386_ksyms.o i387.o dmi_scan.o bootflag.o \
> > 		quirks.o i8237.o topology.o
> > 
> >+timers-y			:= timers/
> >+timers-$(CONFIG_XEN)		:=
> >+
> 
> You need to disable CONFIG_HPET_TIMER for CONFIG_XEN, otherwise 
> select_timer is undefined since you don't include timers here.

Thanks, you're right.  It's done the main Xen tree, didn't make it into
this patchset, fixed.

thanks,
-chris
