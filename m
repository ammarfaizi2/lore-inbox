Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965060AbVLHAna@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965060AbVLHAna (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Dec 2005 19:43:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965075AbVLHAna
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Dec 2005 19:43:30 -0500
Received: from omx1-ext.sgi.com ([192.48.179.11]:7103 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S965060AbVLHAn3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Dec 2005 19:43:29 -0500
Date: Wed, 7 Dec 2005 16:43:15 -0800 (PST)
From: Christoph Lameter <clameter@engr.sgi.com>
To: Nick Piggin <piggin@cyberone.com.au>
cc: akpm@osdl.org, linux-kernel@vger.kernel.org,
       lhms-devel@lists.sourceforge.net
Subject: Re: [PATCH] swap migration: Fix lru drain
In-Reply-To: <43976FD4.8060404@cyberone.com.au>
Message-ID: <Pine.LNX.4.62.0512071641080.26288@schroedinger.engr.sgi.com>
References: <Pine.LNX.4.62.0512071351010.25527@schroedinger.engr.sgi.com>
 <43976FD4.8060404@cyberone.com.au>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 8 Dec 2005, Nick Piggin wrote:

> Do we need a lock_cpu_hotplug() around here?

Well, then we may need that lock for each "for_each_online_cpu" use?
 
> Can't this deadlock if 2 CPUs each send work to the other

Then we would need to fix the workqueue flushing function.

