Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268145AbUHWVll@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268145AbUHWVll (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Aug 2004 17:41:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268010AbUHWVj4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Aug 2004 17:39:56 -0400
Received: from omx3-ext.sgi.com ([192.48.171.20]:14301 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S264443AbUHWVb5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Aug 2004 17:31:57 -0400
From: Jesse Barnes <jbarnes@engr.sgi.com>
To: "Martin J. Bligh" <mbligh@aracnet.com>
Subject: Re: Performance of -mm2 and -mm4
Date: Mon, 23 Aug 2004 14:31:25 -0700
User-Agent: KMail/1.6.2
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel <linux-kernel@vger.kernel.org>,
       Nick Piggin <piggin@cyberone.com.au>
References: <336080000.1093280286@[10.10.2.4]>
In-Reply-To: <336080000.1093280286@[10.10.2.4]>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200408231431.25986.jbarnes@engr.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday, August 23, 2004 9:58 am, Martin J. Bligh wrote:
> The -mm4 looks more like sched stuff to me (copy_to/from_user, etc),
> but the -mm2 stuff looks like something else. Buggered if I know what.
> -mm3 didn't compile cleanly, so I didn't bother, but I prob can if you
> like.

If you suspect the scheduler, you could try bumping SD_NODES_PER_DOMAIN in 
kernel/sched.c to a larger value (e.g. the number of nodes in your system).  
That'll make the scheduler balance more aggressively across the whole system.

Jesse
