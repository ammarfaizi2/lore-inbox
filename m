Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265144AbUJVTfA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265144AbUJVTfA (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Oct 2004 15:35:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266481AbUJVTdn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Oct 2004 15:33:43 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:16074 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S265144AbUJVTWB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Oct 2004 15:22:01 -0400
Date: Fri, 22 Oct 2004 12:21:35 -0700 (PDT)
From: Christoph Lameter <clameter@sgi.com>
X-X-Sender: clameter@schroedinger.engr.sgi.com
To: Adrian Bunk <bunk@stusta.de>
cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       jgarzik@pobox.com, linux-net@vger.kernel.org
Subject: Re: 2.6.9-mm1: timer_event multiple definition
In-Reply-To: <20041022191608.GB22558@stusta.de>
Message-ID: <Pine.LNX.4.58.0410221219580.9440@schroedinger.engr.sgi.com>
References: <20041022032039.730eb226.akpm@osdl.org> <20041022135026.GC2831@stusta.de>
 <Pine.LNX.4.58.0410220812170.7868@schroedinger.engr.sgi.com>
 <20041022191608.GB22558@stusta.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 22 Oct 2004, Adrian Bunk wrote:

> You don't have "SysKonnect FDDI PCI support" enabled in your .config?

Nope.

> That's what I wanted to say in my comment:

Right.

> There's a name clash between two global `timer_event':
> The one you introduced, and the one in drivers/net/skfp/queue.c .
>
> I don't know whether `timer_event' is too generic for the use you
> introduced, but for the use in drivers/net/skfp/queue.c (which was
> already present) it seems too generic.

posix_timer_event is more specific and the patch attached to my last
message contained a patch where the name is changed to posix_timer_event.
