Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932609AbWBXWPG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932609AbWBXWPG (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Feb 2006 17:15:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932606AbWBXWPG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Feb 2006 17:15:06 -0500
Received: from relais.videotron.ca ([24.201.245.36]:20461 "EHLO
	relais.videotron.ca") by vger.kernel.org with ESMTP id S932594AbWBXWPF
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Feb 2006 17:15:05 -0500
Date: Fri, 24 Feb 2006 17:14:59 -0500 (EST)
From: Nicolas Pitre <nico@cam.org>
Subject: Re: [PATCH 0/7] inflate pt1: refactor boot-time inflate code
In-reply-to: <20060224213034.GC13116@waste.org>
X-X-Sender: nico@localhost.localdomain
To: Matt Mackall <mpm@selenic.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Message-id: <Pine.LNX.4.64.0602241713010.31162@localhost.localdomain>
MIME-version: 1.0
Content-type: TEXT/PLAIN; charset=US-ASCII
Content-transfer-encoding: 7BIT
References: <1.399206195@selenic.com>
 <20060224205626.GB28855@flint.arm.linux.org.uk>
 <20060224213034.GC13116@waste.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 24 Feb 2006, Matt Mackall wrote:

> On Fri, Feb 24, 2006 at 08:56:26PM +0000, Russell King wrote:
> > There's a comment at the top of arch/arm/boot/compressed/misc.c which
> > describes the use of the inflate code on ARM - for the kernel it's a
> > special case where the decompressor is run from ROM.
> > 
> > There's also another twist to it though - our relocatable zImage
> > requires us to build all files in the executable part of zImage
> > without _any_ static variables.  If there's one or more static
> > variables, this feature breaks horribly (and silently in the non-
> > relocated cases.)
> 
> I think I addressed all those issues last time around, and none of
> them should be present in this batch anyway. But it's possible I've
> missed something. If you'd like, I can send the whole set to you for
> testing.

Just make sure that, once compiled, none of the related object files 
have a non-zero data size when the "size" command is used on them.


Nicolas
