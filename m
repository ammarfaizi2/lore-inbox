Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932183AbWCWD2a@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932183AbWCWD2a (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Mar 2006 22:28:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932529AbWCWD2a
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Mar 2006 22:28:30 -0500
Received: from mailout1.vmware.com ([65.113.40.130]:56844 "EHLO
	mailout1.vmware.com") by vger.kernel.org with ESMTP id S932183AbWCWD23
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Mar 2006 22:28:29 -0500
Message-ID: <442214A0.2000004@vmware.com>
Date: Wed, 22 Mar 2006 19:23:12 -0800
From: Eli Collins <ecollins@vmware.com>
User-Agent: Thunderbird 1.5 (X11/20051201)
MIME-Version: 1.0
To: Chris Wright <chrisw@sous-sol.org>
Cc: linux-kernel@vger.kernel.org, virtualization@lists.osdl.org,
       Christian Limpach <Christian.Limpach@cl.cam.ac.uk>,
       xen-devel@lists.xensource.com, Ian Pratt <ian.pratt@xensource.com>
Subject: Re: [Xen-devel] [RFC PATCH 25/35] Add Xen time abstractions
References: <20060322063040.960068000@sorel.sous-sol.org> <20060322063800.241815000@sorel.sous-sol.org>
In-Reply-To: <20060322063800.241815000@sorel.sous-sol.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 23 Mar 2006 03:23:12.0656 (UTC) FILETIME=[1DC2A900:01C64E29]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> --- xen-subarch-2.6.orig/arch/i386/kernel/Makefile
> +++ xen-subarch-2.6/arch/i386/kernel/Makefile
> @@ -9,8 +9,11 @@ obj-y	:= process.o semaphore.o signal.o 
>  		pci-dma.o i386_ksyms.o i387.o dmi_scan.o bootflag.o \
>  		quirks.o i8237.o topology.o
>  
> +timers-y			:= timers/
> +timers-$(CONFIG_XEN)		:=
> +

You need to disable CONFIG_HPET_TIMER for CONFIG_XEN, otherwise 
select_timer is undefined since you don't include timers here.

Eli
