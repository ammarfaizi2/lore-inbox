Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265108AbUHHDUd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265108AbUHHDUd (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 Aug 2004 23:20:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265119AbUHHDUc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 Aug 2004 23:20:32 -0400
Received: from omx3-ext.sgi.com ([192.48.171.20]:59522 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S265108AbUHHDUU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 Aug 2004 23:20:20 -0400
Date: Sat, 7 Aug 2004 20:17:55 -0700
From: Paul Jackson <pj@sgi.com>
To: Erich Focht <efocht@hpce.nec.com>
Cc: mbligh@aracnet.com, lse-tech@lists.sourceforge.net, akpm@osdl.org,
       hch@infradead.org, steiner@sgi.com, jbarnes@sgi.com,
       sylvain.jeaugey@bull.net, djh@sgi.com, linux-kernel@vger.kernel.org,
       colpatch@us.ibm.com, Simon.Derr@bull.net, ak@suse.de, sivanich@sgi.com
Subject: Re: [Lse-tech] [PATCH] cpusets - big numa cpu and memory placement
Message-Id: <20040807201755.16eeeab9.pj@sgi.com>
In-Reply-To: <200408071722.36705.efocht@hpce.nec.com>
References: <20040805100901.3740.99823.84118@sam.engr.sgi.com>
	<200408061730.06175.efocht@hpce.nec.com>
	<20040806231013.2b6c44df.pj@sgi.com>
	<200408071722.36705.efocht@hpce.nec.com>
Organization: SGI
X-Mailer: Sylpheed version 0.8.10claws (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Erich wrote:
> The complaints about the huge size of the patch should therefore have
> in mind that we might well get rid of the user interface part of it.

To put some numbers on things, building 2.6.8-rc2-mm2 for arch=ia64,
with gcc 3.3.2, using sn2_defconfig, I see the following kernel text
byte costs:

	Enabling CONFIG_CPUSETS:   22384   (22028 cpuset.o, 356 hooks)
	The  bitmap list UI:        1552
	                           -----
	Total:                     23936

The bitmap list user interface is a fairly small part of the total.

Of the 22384 for CONFIG_CPUSETS, 22028 bytes is in kernel/cpuset.o and
the remaining 356 for the cpuset kernel hooks (which are essentially
zero if CONFIG_CPUSETS is disabled).


> The core infrastructure of cpusets will be needed anyway and the
> amount of code is the absolutely required minimum, IMHO.

I agree.  If anyone can see further opportunities to trim, let me know.


> What I proposed was to include cpusets ASAP

I agree.


>  A better world ;-)

Yeah !!

-- 
                          I won't rest till it's the best ...
                          Programmer, Linux Scalability
                          Paul Jackson <pj@sgi.com> 1.650.933.1373
