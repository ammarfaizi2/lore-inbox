Return-Path: <linux-kernel-owner+willy=40w.ods.org-S270774AbUJUS5c@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270774AbUJUS5c (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Oct 2004 14:57:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270818AbUJUS5J
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Oct 2004 14:57:09 -0400
Received: from brown.brainfood.com ([146.82.138.61]:21120 "EHLO
	gradall.private.brainfood.com") by vger.kernel.org with ESMTP
	id S270774AbUJUSyn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Oct 2004 14:54:43 -0400
Date: Thu, 21 Oct 2004 13:54:41 -0500 (CDT)
From: Adam Heath <doogie@debian.org>
X-X-Sender: adam@gradall.private.brainfood.com
To: Andrea Arcangeli <andrea@novell.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: ZONE_PADDING wastes 4 bytes of the new cacheline
In-Reply-To: <20041021124505.GD8756@dualathlon.random>
Message-ID: <Pine.LNX.4.58.0410211354160.1252@gradall.private.brainfood.com>
References: <20041021011714.GQ24619@dualathlon.random> <417728B0.3070006@yahoo.com.au>
 <20041020213622.77afdd4a.akpm@osdl.org> <16759.38054.944944.610417@alkaid.it.uu.se>
 <20041021124505.GD8756@dualathlon.random>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 21 Oct 2004, Andrea Arcangeli wrote:

> On Thu, Oct 21, 2004 at 12:51:18PM +0200, Mikael Pettersson wrote:
> > Have you verified that? GCCs up to and including 2.95.3 and
> > early versions of 2.96 miscompiled the kernel when spinlocks
> > where empty structs on UP. I.e., you might not get a compile-time
> > error but runtime corruption instead.
>
> peraphs we should add a check on the compiler and force people to use
> gcc >= 3?
>
> Otherwise adding an #ifdef will fix 2.95, just like the spinlock does in
> UP.
>
> btw, the only machine where I still have gcc 2.95.3 is not uptodate
> enough to run 2.6 regardless of the fact 2.6 could compile on such
> machine or not.

So compile a 2.6 kernel on the machine with 2.95.3 for another machine.
