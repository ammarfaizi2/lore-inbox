Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262961AbSJFW4g>; Sun, 6 Oct 2002 18:56:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262962AbSJFW4f>; Sun, 6 Oct 2002 18:56:35 -0400
Received: from ip68-13-110-204.om.om.cox.net ([68.13.110.204]:45445 "EHLO
	dad.molina") by vger.kernel.org with ESMTP id <S262961AbSJFW4f>;
	Sun, 6 Oct 2002 18:56:35 -0400
Date: Sun, 6 Oct 2002 18:02:09 -0500 (CDT)
From: Thomas Molina <tmolina@cox.net>
X-X-Sender: tmolina@dad.molina
To: Andrew Morton <akpm@digeo.com>
cc: linux-kernel@vger.kernel.org, <mec@shout.net>
Subject: Re: 2.5.40:  problem with configuration system
In-Reply-To: <3DA0B2E1.74E4FBB4@digeo.com>
Message-ID: <Pine.LNX.4.44.0210061757510.8057-100000@dad.molina>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 6 Oct 2002, Andrew Morton wrote:

> that's a bug in arch/i386/kernel/mpparse.c.  It doesn't have a
> definition of Dprintk in scope on uniprocessor, non-IO-apic
> builds.
> 
> Selecting io-apic-on-uniprocessor makes it go away.

But I was trying to minimize the size of the kernel which got built.  
defining io-apic-on-uniprocessor adds stuff which I don't want.  Having 
CONFIG_X86_EXTRA_IRQS=y
CONFIG_X86_FIND_SMP_CONFIG=y
CONFIG_X86_MPPARSE=y

adds stuff I don't need or want.  It shouldn't be there.


