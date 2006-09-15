Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751381AbWIOA00@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751381AbWIOA00 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Sep 2006 20:26:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751382AbWIOA00
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Sep 2006 20:26:26 -0400
Received: from smtp.osdl.org ([65.172.181.4]:59039 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751381AbWIOA0Z (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Sep 2006 20:26:25 -0400
Date: Thu, 14 Sep 2006 17:26:17 -0700
From: Andrew Morton <akpm@osdl.org>
To: Christoph Lameter <christoph@sgi.com>
Cc: Nick Piggin <npiggin@suse.de>,
       "Siddha, Suresh B" <suresh.b.siddha@intel.com>,
       linux-kernel@vger.kernel.org, mingo@elte.hu
Subject: Re: [PATCH] Fix longstanding load balancing bug in the scheduler V2
Message-Id: <20060914172617.fc8aef2b.akpm@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0609121135590.12100@schroedinger.engr.sgi.com>
References: <Pine.LNX.4.64.0609061634240.13322@schroedinger.engr.sgi.com>
	<20060908103529.A9121@unix-os.sc.intel.com>
	<Pine.LNX.4.64.0609081135590.23089@schroedinger.engr.sgi.com>
	<20060908130028.A9446@unix-os.sc.intel.com>
	<Pine.LNX.4.64.0609081316580.24016@schroedinger.engr.sgi.com>
	<20060908170352.C9446@unix-os.sc.intel.com>
	<Pine.LNX.4.64.0609082222330.25269@schroedinger.engr.sgi.com>
	<Pine.LNX.4.64.0609091252070.26746@schroedinger.engr.sgi.com>
	<20060911083734.GA25953@wotan.suse.de>
	<Pine.LNX.4.64.0609121135590.12100@schroedinger.engr.sgi.com>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 12 Sep 2006 11:37:55 -0700 (PDT)
Christoph Lameter <christoph@sgi.com> wrote:

> Fix longstanding load balancing bug in the scheduler V2.
> 
> AFAIK this is an important scheduler bug that needs to go 
> into 2.6.18 and all stable release since the issue can stall the 
> scheduler for good.

The timing is of course problematic.  One approach could be to merge it
into 2.6.19-early, backport into 2.6.18.x after a few weeks.  I don't know
if that's a lot better, really - it's unlikely that anyone will be running
serious performance testing against 2.6.19-rc1 or -rc2.

I'm struggling to understand how serious this really is - if the bug is
"longstanding" then very few machines must be encountering it?
