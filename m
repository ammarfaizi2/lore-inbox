Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261294AbTEOGic (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 May 2003 02:38:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262016AbTEOGic
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 May 2003 02:38:32 -0400
Received: from ns.suse.de ([213.95.15.193]:13830 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S261294AbTEOGib (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 May 2003 02:38:31 -0400
Date: Thu, 15 May 2003 08:51:20 +0200
From: Andi Kleen <ak@suse.de>
To: john stultz <johnstul@us.ibm.com>
Cc: lkml <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@digeo.com>,
       "Martin J. Bligh" <mbligh@aracnet.com>, Andi Kleen <ak@suse.de>
Subject: Re: [PATCH] linux-2.5.69_subarch-fix_A0.patch
Message-ID: <20030515065120.GA3469@Wotan.suse.de>
References: <1052966228.9630.69.camel@w-jstultz2.beaverton.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1052966228.9630.69.camel@w-jstultz2.beaverton.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 14, 2003 at 07:37:09PM -0700, john stultz wrote:
> All,
> 	This patch fixes a circular dependency (a function in mach_apic.h
> requires hard_smp_processor_id() and hard_smp_processor_id() requires
> macros from mach_apic.h) that has been in the subarch code for a bit,
> but was hacked around with some #ifdefs. 
> 
> With the inclusion of the generic-subarch the hack was dropped and
> bigsmp and summit promptly broke. So this makes things compile again. 

What broke exactly? I thought worked around this problem for the generic
subarchitecture.

Accessing the APIC directly this way just to work around a bad include
looks quite ugly to me.

-Andi
