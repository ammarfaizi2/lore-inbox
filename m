Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030489AbWAJWw5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030489AbWAJWw5 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Jan 2006 17:52:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030488AbWAJWw5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Jan 2006 17:52:57 -0500
Received: from mx.pathscale.com ([64.160.42.68]:61626 "EHLO mx.pathscale.com")
	by vger.kernel.org with ESMTP id S1030484AbWAJWw4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Jan 2006 17:52:56 -0500
Subject: Re: [PATCH 3 of 3] Add __raw_memcpy_toio32 to each arch
From: "Bryan O'Sullivan" <bos@pathscale.com>
To: Andi Kleen <ak@suse.de>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org, hch@infradead.org,
       rdreier@cisco.com
In-Reply-To: <200601102109.00067.ak@suse.de>
References: <5673a186625f62491f33.1136922839@serpentine.internal.keyresearch.com>
	 <200601102109.00067.ak@suse.de>
Content-Type: text/plain
Organization: PathScale, Inc.
Date: Tue, 10 Jan 2006 14:52:49 -0800
Message-Id: <1136933569.6294.40.camel@serpentine.pathscale.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-01-10 at 21:08 +0100, Andi Kleen wrote:
> On Tuesday 10 January 2006 20:53, Bryan O'Sullivan wrote:
> > Most arches use the generic routine.  x86_64 uses memcpy32 instead;
> > this is substantially faster, even over a bus that is much slower than
> > the CPU.
> 
> So did you run numbers against the C implementation with -funroll-loops ? 
> What were the results?

The C implementation is about 5% slower when copying over
HyperTransport.

	<b

