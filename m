Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752170AbWFLS42@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752170AbWFLS42 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Jun 2006 14:56:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752155AbWFLS41
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Jun 2006 14:56:27 -0400
Received: from ns1.suse.de ([195.135.220.2]:4516 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1752170AbWFLS41 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Jun 2006 14:56:27 -0400
From: Andi Kleen <ak@suse.de>
To: Christoph Lameter <clameter@sgi.com>
Subject: Re: broken local_t on i386
Date: Mon, 12 Jun 2006 19:55:47 +0200
User-Agent: KMail/1.8
Cc: Ingo Molnar <mingo@elte.hu>,
       Michal Piotrowski <michal.k.k.piotrowski@gmail.com>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
References: <20060609214024.2f7dd72c.akpm@osdl.org> <200606121935.02693.ak@suse.de> <Pine.LNX.4.64.0606121139380.20123@schroedinger.engr.sgi.com>
In-Reply-To: <Pine.LNX.4.64.0606121139380.20123@schroedinger.engr.sgi.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200606121955.47803.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 12 June 2006 20:42, Christoph Lameter wrote:
> On Mon, 12 Jun 2006, Andi Kleen wrote:
> > Saving two instructions? And PDA is usually in L1. I doubt you could
> > benchmark a difference.
>
> The two instructions occur over and over again for each PDA reference. And
> then there are now two more instruction for disabling preempt and
> reenabling preempt.

Only for those who set CONFIG_OVERHEAD

> A simple dec/inc <absolute location> would be nicely suitable for
> inlining per processor counters.

Possible, but is it worth reinventing the linker?

-Andi
