Return-Path: <linux-kernel-owner+w=401wt.eu-S1750901AbXACRq1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750901AbXACRq1 (ORCPT <rfc822;w@1wt.eu>);
	Wed, 3 Jan 2007 12:46:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750982AbXACRq1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Jan 2007 12:46:27 -0500
Received: from omx1-ext.sgi.com ([192.48.179.11]:53511 "EHLO omx1.sgi.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1750901AbXACRq0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Jan 2007 12:46:26 -0500
Date: Wed, 3 Jan 2007 09:46:19 -0800 (PST)
From: Christoph Lameter <clameter@sgi.com>
To: Helge Deller <deller@gmx.de>
cc: linux-kernel@vger.kernel.org, parisc-linux@lists.parisc-linux.org
Subject: Re: [RFC][PATCH] use cycle_t instead of u64 in struct time_interpolator
In-Reply-To: <200701022233.25697.deller@gmx.de>
Message-ID: <Pine.LNX.4.64.0701030942160.7909@schroedinger.engr.sgi.com>
References: <200701022233.25697.deller@gmx.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2 Jan 2007, Helge Deller wrote:

> As far as I could see, this patch does not change anything for the 
> existing architectures which use this framework (IA64 and SPARC64), 
> since "cycles_t" is defined there as unsigned 64bit-integer anyway 
> (which then makes this patch a no-change for them).

The 64bit nature of some entities was so far necessary to get the 
proper accuracy of interpolation. Maybe it can be made to work with 32 bit 
entities. The macro GET_TI_SECS must work correctly and the less bits are 
specified in shift the less self-tuning accuracy you will get.
