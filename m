Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261417AbTIKRN2 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Sep 2003 13:13:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261424AbTIKRN2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Sep 2003 13:13:28 -0400
Received: from mail.jlokier.co.uk ([81.29.64.88]:51089 "EHLO
	mail.jlokier.co.uk") by vger.kernel.org with ESMTP id S261417AbTIKRNT
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Sep 2003 13:13:19 -0400
Date: Thu, 11 Sep 2003 18:13:16 +0100
From: Jamie Lokier <jamie@shareable.org>
To: Andi Kleen <ak@suse.de>
Cc: Matthew Wilcox <willy@debian.org>, linux-kernel@vger.kernel.org
Subject: Re: Memory mapped IO vs Port IO
Message-ID: <20030911171316.GI29532@mail.jlokier.co.uk>
References: <20030911160116.GI21596@parcelfarce.linux.theplanet.co.uk.suse.lists.linux.kernel> <p73oexri9kx.fsf@oldwotan.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <p73oexri9kx.fsf@oldwotan.suse.de>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen wrote:
> My gut feeling is to just fix the drivers to make this runtime switchable
> and get rid of the compile time options.
> 
> This would help distributions (who normally want to build conservative
> by default, but still allow the users easy tuning without recompilation) 
> For that it would be nice if a standard module parameter or maybe 
> sysfs option existed.

Another way to help distributions is to compile those drivers twice,
once for each access type.  There aren't all that many drivers that
need it.

> The overhead of checking for PIO vs mmio at runtime in the drivers
> should be completely in the noise on any non ancient CPU (both MMIO
> and PIO typically take hundreds or thousands of CPU cycles for the bus
> access, having an dynamic function call or an if before that is makes
> no difference at all)

Ah, but what about the ancient CPUs?

-- Jamie
