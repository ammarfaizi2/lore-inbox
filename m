Return-Path: <linux-kernel-owner+willy=40w.ods.org-S935841AbWK1Kl5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935841AbWK1Kl5 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Nov 2006 05:41:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S935839AbWK1Kl5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Nov 2006 05:41:57 -0500
Received: from mx1.suse.de ([195.135.220.2]:185 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S935841AbWK1Kl4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Nov 2006 05:41:56 -0500
From: Andi Kleen <ak@suse.de>
To: Arjan van de Ven <arjan@linux.intel.com>
Subject: Re: [patch] Mark rdtsc as sync only for netburst, not for core2
Date: Tue, 28 Nov 2006 11:36:28 +0100
User-Agent: KMail/1.9.5
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org
References: <1164709708.3276.72.camel@laptopd505.fenrus.org>
In-Reply-To: <1164709708.3276.72.camel@laptopd505.fenrus.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200611281136.29066.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 28 November 2006 11:28, Arjan van de Ven wrote:
> Hi,
> 
> On the Core2 cpus, the rdtsc instruction is not serializing (as defined
> in the architecture reference since rdtsc exists) and due to the deep
> speculation of these cores, it's possible that you can observe time go
> backwards between cores due to this speculation. Since the kernel
> already deals with this with the SYNC_RDTSC flag, the solution is
> simple, only assume that the instruction is serializing on family 15...
> 
> The price one pays for this is a slightly slower gettimeofday (by a
> dozen or two cycles), but that increase is quite small to pay for a
> really-going-forward tsc counter.

Added thanks

-Andi
