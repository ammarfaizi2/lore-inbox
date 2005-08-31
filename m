Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964891AbVHaRsO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964891AbVHaRsO (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 31 Aug 2005 13:48:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964906AbVHaRsO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 31 Aug 2005 13:48:14 -0400
Received: from sccrmhc14.comcast.net ([204.127.202.59]:39884 "EHLO
	sccrmhc14.comcast.net") by vger.kernel.org with ESMTP
	id S964891AbVHaRsN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 31 Aug 2005 13:48:13 -0400
Subject: Re: State of Linux graphics
From: Jim Gettys <jg@freedesktop.org>
Reply-To: jg@freedesktop.org
To: Discuss issues related to the xorg tree 
	<xorg@lists.freedesktop.org>
Cc: lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <20050831063355.GE27940@tuolumne.arden.org>
References: <9e47339105083009037c24f6de@mail.gmail.com>
	 <1125422813.20488.43.camel@localhost>
	 <20050831063355.GE27940@tuolumne.arden.org>
Content-Type: text/plain
Date: Wed, 31 Aug 2005 13:48:11 -0400
Message-Id: <1125510491.12626.8.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.1.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Certainly replicating OpenGL 2.0's programmability through Render makes
no sense at all to me (or most others, I believe/hope).  If you want to
use full use of the GPU, I'm happy to say you should be using OpenGL.
				- Jim


On Tue, 2005-08-30 at 23:33 -0700, Allen Akin wrote:
> On Tue, Aug 30, 2005 at 01:26:53PM -0400, David Reveman wrote:
> | On Tue, 2005-08-30 at 12:03 -0400, Jon Smirl wrote:
> | > In general, the whole concept of programmable graphics hardware is
> | > not addressed in APIs like xlib and Cairo. This is a very important
> | > point. A major new GPU feature, programmability is simply not
> | > accessible from the current X APIs. OpenGL exposes this
> | > programmability via its shader language.
> | 
> |                                                           ... I don't
> | see why this can't be exposed through the Render extension. ...
> 
> What has always concerned me about this approach is that when you add
> enough functionality to Render or some new X extensions to fully exploit
> previous (much less current and in-development!) generations of GPUs,
> you've essentially duplicated OpenGL 2.0.  You need to identify the
> resources to be managed (framebuffer objects, vertex objects, textures,
> programs of several kinds, etc.); explain how they're specified and how
> they interact and how they're owned/shared; define a vocabulary of
> commands that operate upon them; think about how those commands are
> translated and executed on various pieces of hardware; examine the
> impact of things like graphics context switching on the system
> architecture; and deal with a dozen other matters that have already been
> addressed fully or partly in the OpenGL world.
> 
> I think it makes a lot of sense to leverage the work that's already been
> done:  Take OpenGL as a given, and add extensions for what's missing.
> Don't create a parallel API that in the long run must develop into
> something at least as rich as OpenGL was to start with.  That costs time
> and effort, and likely won't be supported by the hardware vendors to the
> same extent that OpenGL is (thanks to the commercial forces already at
> work).  Let OpenGL do 80% of the job, then work to provide the last 20%,
> rather than trying to do 100% from scratch.
> 
> Allen
> _______________________________________________
> xorg mailing list
> xorg@lists.freedesktop.org
> http://lists.freedesktop.org/mailman/listinfo/xorg

