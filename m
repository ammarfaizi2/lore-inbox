Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265163AbUGGOrH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265163AbUGGOrH (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Jul 2004 10:47:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265175AbUGGOrH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Jul 2004 10:47:07 -0400
Received: from sp-260-1.net4.netcentrix.net ([4.21.254.118]:10951 "EHLO
	asmodeus.mcnaught.org") by vger.kernel.org with ESMTP
	id S265163AbUGGOrE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Jul 2004 10:47:04 -0400
To: Christoph Pleger <Christoph.Pleger@uni-dortmund.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Address space for user process
References: <20040707163535.02323a8f.Christoph.Pleger@uni-dortmund.de>
From: Doug McNaught <doug@mcnaught.org>
Date: Wed, 07 Jul 2004 10:46:56 -0400
In-Reply-To: <20040707163535.02323a8f.Christoph.Pleger@uni-dortmund.de> (Christoph
 Pleger's message of "Wed, 7 Jul 2004 16:35:35 +0200")
Message-ID: <87hdsjswm7.fsf@asmodeus.mcnaught.org>
User-Agent: Gnus/5.1002 (Gnus v5.10.2) Emacs/20.7 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Pleger <Christoph.Pleger@uni-dortmund.de> writes:

> Hello,
>
> I read that - at least in Kernel 2.4 - the amount of memory that can be
> addressed by a user process is limited to 3 GB, no matter how much
> virtual memory is present. Is it possible to raise that limit?

That's limit of the ix86 architecture, not Linux.  64-bit systems
running Linux have no such limit.

That said, there are patches for 2.4 that create separate address
spaces for kernel and user (search for '4G/4G') at the cost of a
(sometimes significant) performance penalty.  4GB per-process is a
hard limit on 32-bit systems, so it's the most you'll get.

-Doug
