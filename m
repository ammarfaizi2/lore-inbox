Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964957AbVL2LVx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964957AbVL2LVx (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Dec 2005 06:21:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932593AbVL2LVx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Dec 2005 06:21:53 -0500
Received: from bay23-f27.bay23.hotmail.com ([64.4.22.77]:18208 "EHLO
	hotmail.com") by vger.kernel.org with ESMTP id S932580AbVL2LVw
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Dec 2005 06:21:52 -0500
Message-ID: <BAY23-F27F5FACE353137AF8C88F8F7290@phx.gbl>
X-Originating-IP: [203.122.18.178]
X-Originating-Email: [pretorious_i@hotmail.com]
In-Reply-To: <1135854129.2935.13.camel@laptopd505.fenrus.org>
From: "pretorious ." <pretorious_i@hotmail.com>
To: arjan@infradead.org
Cc: linux-kernel@vger.kernel.org
Subject: Re: Redefinition error while compiling LKM
Date: Thu, 29 Dec 2005 16:51:49 +0530
Mime-Version: 1.0
Content-Type: text/plain; format=flowed
X-OriginalArrivalTime: 29 Dec 2005 11:21:50.0071 (UTC) FILETIME=[0FF97070:01C60C6A]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>
>and.. why on earth would you need sys/syscall.h ?? (or sys/stat.h for
>that matter)
>
>

Trying to override certain syscalls (mknod ...)

>From: Arjan van de Ven <arjan@infradead.org>
>To: "pretorious ." <pretorious_i@hotmail.com>
>CC: linux-kernel@vger.kernel.org
>Subject: Re: Redefinition error while compiling LKM
>Date: Thu, 29 Dec 2005 12:02:09 +0100
>
>On Thu, 2005-12-29 at 16:21 +0530, pretorious . wrote:
> > hi!
> >    I am facing problem in compiling an LKM. It seems Inclusion of
> > <sys/stat.h> conflicts with definitions in time.h.
> >
> >
> > My linux kernal version is 2.4.21-4.EL
> >
> >
> > #include <linux/kernel.h>
> > #include <linux/module.h>
> >
> > #if CONFIG_MODVERSIONS==1
> > #define MODVERSIONS
> > #include <linux/modversions.h>
> > #endif
>
>this is broken btw
> >
> > #ifndef KERNEL_VERSION
> > #define KERNEL_VERSION(a,b,c) ((a)*65536+(b)*256+(c))
> > #endif
> >
> > #include <linux/slab.h>
> > #include <asm/uaccess.h>
> > #include <sys/syscall.h>
> >
> > #include <sys/stat.h>
>
>
>you cannot use glibc headers in kernel modules. anything in sys/ is a
>glibc header.
>
>and.. why on earth would you need sys/syscall.h ?? (or sys/stat.h for
>that matter)
>
>

_________________________________________________________________
Spice up your IM conversations. New, colorful and animated emoticons. Get 
chatting! http://server1.msn.co.in/SP05/emoticons/

