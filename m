Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262468AbVAEPgF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262468AbVAEPgF (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Jan 2005 10:36:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262469AbVAEPdS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Jan 2005 10:33:18 -0500
Received: from one.firstfloor.org ([213.235.205.2]:43961 "EHLO
	one.firstfloor.org") by vger.kernel.org with ESMTP id S262468AbVAEPRr
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Jan 2005 10:17:47 -0500
To: linux-os@analogic.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: remap_pfm_range() Linux-2.6.10
References: <Pine.LNX.4.61.0501050951520.13645@chaos.analogic.com>
From: Andi Kleen <ak@muc.de>
Date: Wed, 05 Jan 2005 16:17:46 +0100
In-Reply-To: <Pine.LNX.4.61.0501050951520.13645@chaos.analogic.com> (linux-os@chaos.analogic.com's
 message of "Wed, 5 Jan 2005 10:00:24 -0500 (EST)")
Message-ID: <m1k6qrdhwl.fsf@muc.de>
User-Agent: Gnus/5.110002 (No Gnus v0.2) Emacs/21.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

linux-os <linux-os@chaos.analogic.com> writes:
>  	remap_pfn_range(vma, vma->vm_start, base_addr >> PAGE_SHIFT, len, prot)
>
> Now, here's the $US0.02 question. Why wasn't PAGE_SHIFT put inside
> the new function? The base address cannot ever be used without
> PAGE_SHIFT.  In previous versions, information hiding was properly

Because such a conversion would be very error prone.  People would
likely add subtle bugs. Changing units is always dangerous.

-Andi
