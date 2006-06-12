Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752111AbWFLSa1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752111AbWFLSa1 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Jun 2006 14:30:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752131AbWFLSa1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Jun 2006 14:30:27 -0400
Received: from cantor2.suse.de ([195.135.220.15]:12998 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1752111AbWFLSa1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Jun 2006 14:30:27 -0400
From: Andi Kleen <ak@suse.de>
To: Christoph Lameter <clameter@sgi.com>
Subject: Re: broken local_t on i386
Date: Mon, 12 Jun 2006 19:29:46 +0200
User-Agent: KMail/1.8
Cc: Ingo Molnar <mingo@elte.hu>,
       Michal Piotrowski <michal.k.k.piotrowski@gmail.com>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
References: <20060609214024.2f7dd72c.akpm@osdl.org> <200606121906.28692.ak@suse.de> <Pine.LNX.4.64.0606121008340.19562@schroedinger.engr.sgi.com>
In-Reply-To: <Pine.LNX.4.64.0606121008340.19562@schroedinger.engr.sgi.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200606121929.47443.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 12 June 2006 19:11, Christoph Lameter wrote:
> On Mon, 12 Jun 2006, Andi Kleen wrote:
> > Also on non preemptive kernels - which are the majority - it's a single
> > instruction on x86. I guess preempt users can live with a bit more
> > overhead ...
>
> I hope you will be fixing the cpu_local_* macros for i386 and x86_64 

Yes I will disable preemption.

> and add some appropriate docs? 

What docs? I don't have plan to write any for this.

> Are there any existing uses in the kernel? 

There aren't.

Another way would be to just remove them for now and readd in a fixed
version if needed.

-Andi

