Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265883AbUFDRDy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265883AbUFDRDy (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Jun 2004 13:03:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265877AbUFDRDx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Jun 2004 13:03:53 -0400
Received: from mtvcafw.SGI.COM ([192.48.171.6]:18595 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S265845AbUFDRDo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Jun 2004 13:03:44 -0400
Date: Fri, 4 Jun 2004 10:08:34 -0700
From: Paul Jackson <pj@sgi.com>
To: William Lee Irwin III <wli@holomorphy.com>
Cc: kaos@sgi.com, linux-kernel@vger.kernel.org, akpm@osdl.org, ak@muc.de,
       ashok.raj@intel.com, hch@infradead.org, jbarnes@sgi.com,
       joe.korty@ccur.com, manfred@colorfullife.com, colpatch@us.ibm.com,
       mikpe@csd.uu.se, nickpiggin@yahoo.com.au, rusty@rustcorp.com.au,
       Simon.Derr@bull.net
Subject: Re: [PATCH] cpumask 5/10 rewrite cpumask.h - single bitmap based
 implementation
Message-Id: <20040604100834.7edbfa72.pj@sgi.com>
In-Reply-To: <20040604095403.GW21007@holomorphy.com>
References: <20040604081906.GR21007@holomorphy.com>
	<17995.1086338623@kao2.melbourne.sgi.com>
	<20040604095403.GW21007@holomorphy.com>
Organization: SGI
X-Mailer: Sylpheed version 0.8.10claws (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I'd rather just do it.

Nice.  Thanks, Bill.

The patch will collide with 'linus.patch', in Andrew's 2.6.7-rc2-mm2,
which changes the arch/sparc64/kernel/irq.c line:

- static unsigned int parse_hex_value (const char *buffer,
+ static unsigned int parse_hex_value (const char __user *buffer,

Otherwise, it passes my cursory inspection.

-- 
                          I won't rest till it's the best ...
                          Programmer, Linux Scalability
                          Paul Jackson <pj@sgi.com> 1.650.933.1373
