Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932326AbVLHVJF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932326AbVLHVJF (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Dec 2005 16:09:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932363AbVLHVJF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Dec 2005 16:09:05 -0500
Received: from omx3-ext.sgi.com ([192.48.171.20]:45221 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S932326AbVLHVJC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Dec 2005 16:09:02 -0500
Date: Thu, 8 Dec 2005 13:08:33 -0800 (PST)
From: Christoph Lameter <clameter@engr.sgi.com>
To: Andi Kleen <ak@suse.de>
cc: akpm@osdl.org, Christoph Hellwig <hch@infradead.org>,
       linux-ia64@vger.kernel.org, steiner@sgi.com,
       linux-kernel@vger.kernel.org, Wu Fengguang <wfg@mail.ustc.edu.cn>
Subject: Re: [PATCH 3/3] Zone reclaim V3: Frequency of failed reclaim attempts
In-Reply-To: <20051208205241.GR11190@wotan.suse.de>
Message-ID: <Pine.LNX.4.62.0512081307200.30567@schroedinger.engr.sgi.com>
References: <20051208203707.30456.57439.sendpatchset@schroedinger.engr.sgi.com>
 <20051208203717.30456.17434.sendpatchset@schroedinger.engr.sgi.com>
 <20051208205241.GR11190@wotan.suse.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 8 Dec 2005, Andi Kleen wrote:

> For long you don't need get_jiffies_64. On 32bit it would be 32bit
> anyways and on 64bit even normal jiffies is 64bit. So normal
> jiffies would be suffice.

Patch follows.

> But I suspect it would be better to just merge the proper patch
> with the full accounting instead of this kludge.

I would also like to see the full accounting patch to fix this in the 
right way but on the other hand I would like to disentangle different 
patchsets as much as possible. The accounting patch may touch many 
critical code paths.
