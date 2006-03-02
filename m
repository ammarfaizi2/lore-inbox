Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751673AbWCBTJa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751673AbWCBTJa (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Mar 2006 14:09:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752035AbWCBTJa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Mar 2006 14:09:30 -0500
Received: from omx1-ext.sgi.com ([192.48.179.11]:5826 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S1751673AbWCBTJ3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Mar 2006 14:09:29 -0500
Date: Thu, 2 Mar 2006 11:09:16 -0800 (PST)
From: Christoph Lameter <clameter@engr.sgi.com>
To: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
cc: linux-kernel@vger.kernel.org, akpm@osdl.org, ralf@linux-mips.org
Subject: Re: [PATCH] simplify update_times (avoid jiffies/jiffies_64 aliasing
 problem)
In-Reply-To: <20060302.230227.25910097.anemo@mba.ocn.ne.jp>
Message-ID: <Pine.LNX.4.64.0603021108220.5829@schroedinger.engr.sgi.com>
References: <20060302.230227.25910097.anemo@mba.ocn.ne.jp>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2 Mar 2006, Atsushi Nemoto wrote:

> In kernel 2.6, update_times() is called directly in timer interrupt,
> so there is no point calculating ticks here.  This also get rid of
> difference of jiffies and jiffies_64 due to compiler's optimization
> (which was reported previously with subject "jiffies_64 vs. jiffies").

If update_wall_time() and calc_load() are always called with the constant 
one  then you may be able to optimize these two functions as well.
