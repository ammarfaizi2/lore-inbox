Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030253AbWGaQyv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030253AbWGaQyv (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Jul 2006 12:54:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030255AbWGaQyv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Jul 2006 12:54:51 -0400
Received: from omx1-ext.sgi.com ([192.48.179.11]:31694 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S1030253AbWGaQyu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Jul 2006 12:54:50 -0400
Date: Mon, 31 Jul 2006 09:54:29 -0700
From: Paul Jackson <pj@sgi.com>
To: "Siddha, Suresh B" <suresh.b.siddha@intel.com>
Cc: mingo@elte.hu, nickpiggin@yahoo.com.au, vatsa@in.ibm.com,
       suresh.b.siddha@intel.com, Simon.Derr@bull.net, steiner@sgi.com,
       linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: Re: [BUG] sched: big numa dynamic sched domain memory corruption
Message-Id: <20060731095429.d2b8801d.pj@sgi.com>
In-Reply-To: <20060731090440.A2311@unix-os.sc.intel.com>
References: <20060731070734.19126.40501.sendpatchset@v0>
	<20060731071242.GA31377@elte.hu>
	<20060731090440.A2311@unix-os.sc.intel.com>
Organization: SGI
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.3; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Paul can you please test the mainline code and confirm?

Sure - which version of Linus and/or Andrew's tree is the minimum
worth testing?

Could you explain why you don't think the mainline has this
problem?  I still see the critical code piece there:

  #ifdef CONFIG_NUMA
                if (cpus_weight(*cpu_map)
                                > SD_NODES_PER_DOMAIN*cpus_weight(nodemask)) {

What other critical bugs are fixed between the SLES10 variant
and the mainline?

-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@sgi.com> 1.925.600.0401
