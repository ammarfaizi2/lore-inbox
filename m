Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268232AbUIKRlR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268232AbUIKRlR (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Sep 2004 13:41:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268210AbUIKRlR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Sep 2004 13:41:17 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.101]:12534 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S268232AbUIKRk1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 11 Sep 2004 13:40:27 -0400
Subject: Re: [Patch 4/4] cpusets top mask just online, not all possible
From: Dave Hansen <haveblue@us.ibm.com>
To: Paul Jackson <pj@sgi.com>
Cc: Anton Blanchard <anton@samba.org>, Andrew Morton <akpm@osdl.org>,
       Simon.Derr@bull.net,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andi Kleen <ak@suse.de>, IWAMOTO Toshihiro <iwamoto@valinux.co.jp>,
       "Martin J. Bligh" <mbligh@aracnet.com>
In-Reply-To: <20040911100731.2f400271.pj@sgi.com>
References: <20040911082810.10372.86008.84920@sam.engr.sgi.com>
	 <20040911082834.10372.51697.75658@sam.engr.sgi.com>
	 <20040911141001.GD32755@krispykreme>  <20040911100731.2f400271.pj@sgi.com>
Content-Type: text/plain
Message-Id: <1094924372.3997.16.camel@localhost>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Sat, 11 Sep 2004 10:39:32 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Now that I've actuallly _looked_ at your code, I noticed that the
mems_allowed really is just a nodemask_t.  

So, you shouldn't have much to worry about from the current memory
hotplug stuff because we don't mess with hotplugging actual NUMA nodes
yet.  As I eluded to before, you might need notification of we ever get
down to a zero-sized node, but that should be id.  You'll certainly need
notification when entire nodes go offline, so I'm adding Martin Bligh to
the cc list (we just talked about NUMA hotplug yesterday).

Martin, you might want to look back in your LKML archives for where this
discussion came from.

-- Dave

