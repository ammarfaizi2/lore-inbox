Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264895AbUGGGIm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264895AbUGGGIm (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Jul 2004 02:08:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264917AbUGGGIm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Jul 2004 02:08:42 -0400
Received: from sb0-cf9a48a7.dsl.impulse.net ([207.154.72.167]:3792 "EHLO
	madrabbit.org") by vger.kernel.org with ESMTP id S264895AbUGGGIl
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Jul 2004 02:08:41 -0400
Subject: Re: 0xdeadbeef vs 0xdeadbeefL
From: Ray Lee <ray-lk@madrabbit.org>
To: Alexandre Oliva <aoliva@redhat.com>
Cc: tomstdenis@yahoo.com, eger@havoc.gtf.org,
       Linux Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <orn02cqs3u.fsf@livre.redhat.lsd.ic.unicamp.br>
References: <1089165901.4373.175.camel@orca.madrabbit.org>
	 <orn02cqs3u.fsf@livre.redhat.lsd.ic.unicamp.br>
Content-Type: text/plain
Organization: http://madrabbit.org/
Message-Id: <1089180520.4373.181.camel@orca.madrabbit.org>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Tue, 06 Jul 2004 23:08:40 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2004-07-06 at 22:55, Alexandre Oliva wrote:
> On Jul  6, 2004, Ray Lee <ray-lk@madrabbit.org> wrote:
> 
> > Which means 0xdeadbeef is a perfectly valid literal for an unsigned int.
> 
> Assuming ints are 32-bits wide.  They don't have to be.

In which case the rest of that line that read:
	
	it has the first possible of these types ["in which its value
	can be represented" -- from omitted]: int, unsigned int, long
	int, unsigned long int.

...kicks in.

> or they could be wider than 32 bits, in which case the constant will
> be signed int instead of unsigned int.

Read that line again. This would only happen if the platform has no
unsigned 32 bit integer whatsoever. If you can point out one of those to
me that Linux runs on, then I'll concede the point. On any other
platform, the constant oct/hex int promotion rules will walk it up to a
32-bit unsigned before it hits the larger types.

Ray

