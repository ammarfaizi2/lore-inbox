Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265144AbUG2Tvw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265144AbUG2Tvw (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jul 2004 15:51:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265195AbUG2Tvv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jul 2004 15:51:51 -0400
Received: from omx1-ext.SGI.COM ([192.48.179.11]:43924 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S265144AbUG2Tu0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jul 2004 15:50:26 -0400
Date: Thu, 29 Jul 2004 14:50:23 -0500
From: Greg Howard <ghoward@sgi.com>
X-X-Sender: ghoward@gallifrey.americas.sgi.com
To: Andrew Morton <akpm@osdl.org>
cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Altix system controller communication driver
In-Reply-To: <20040728160033.63205d60.akpm@osdl.org>
Message-ID: <Pine.SGI.4.58.0407291446550.1917@gallifrey.americas.sgi.com>
References: <Pine.SGI.4.58.0407271457240.1364@gallifrey.americas.sgi.com>
 <20040728085737.26e0bfd2.akpm@osdl.org> <Pine.SGI.4.58.0407281641210.1656@gallifrey.americas.sgi.com>
 <20040728160033.63205d60.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 28 Jul 2004, Andrew Morton wrote:

> Greg Howard <ghoward@sgi.com> wrote:
> >
> > My understanding is that poll_wait just sets up a poll_table
> > structure; it doesn't sleep itself.
>
> It calls into __pollwait(), which can perform sleeping memory allocations.
>

Ah, okay.  Well, I moved the poll_wait() calls out from under the
lock; from what I can tell that ought to be safe enough anyhow.

Thanks - Greg
