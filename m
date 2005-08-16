Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750720AbVHPXng@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750720AbVHPXng (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Aug 2005 19:43:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750737AbVHPXng
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Aug 2005 19:43:36 -0400
Received: from ns2.suse.de ([195.135.220.15]:19590 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1750720AbVHPXnf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Aug 2005 19:43:35 -0400
Date: Wed, 17 Aug 2005 01:43:30 +0200
From: Andi Kleen <ak@suse.de>
To: zach@vmware.com
Cc: akpm@osdl.org, chrisl@vmware.com, chrisw@osdl.org, hpa@zytor.com,
       Keir.Fraser@cl.cam.ac.uk, linux-kernel@vger.kernel.org,
       m+Ian.Pratt@cl.cam.ac.uk, mbligh@mbligh.org, pratap@vmware.com,
       virtualization@lists.osdl.org, zwame@arm.linux.org.uk
Subject: Re: [PATCH 1/14] i386 / Make write ldt return error code
Message-ID: <20050816234330.GF27628@wotan.suse.de>
References: <200508110452.j7B4qpSE019505@zach-dev.vmware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200508110452.j7B4qpSE019505@zach-dev.vmware.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 10, 2005 at 09:52:51PM -0700, zach@vmware.com wrote:
> Xen requires error returns from the hypercall to update LDT entries,
> and this generates completely equivalent code on native.

I don't think that is something we want. Nothing in the callers will check
the errors anyways. If Xen has such a requirement it should kill
the guest when it is violated, otherwise they will be ignored.

I would drop that one.

-Andi
