Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264145AbUCPRlw (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Mar 2004 12:41:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264260AbUCPRiy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Mar 2004 12:38:54 -0500
Received: from fw.osdl.org ([65.172.181.6]:51870 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S264244AbUCPRhP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Mar 2004 12:37:15 -0500
Date: Tue, 16 Mar 2004 09:34:46 -0800
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: Robert Picco <Robert.Picco@hp.com>
Cc: linux-kernel@vger.kernel.org, Robert.Picco@hp.com, colpatch@us.ibm.com,
       mbligh@aracnet.com
Subject: Re: boot time node and memory limit options
Message-Id: <20040316093446.7bbcdc9b.rddunlap@osdl.org>
In-Reply-To: <40573460.9090605@hp.com>
References: <40573460.9090605@hp.com>
Organization: OSDL
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
X-Face: +5V?h'hZQPB9<D&+Y;ig/:L-F$8p'$7h4BBmK}zo}[{h,eqHI1X}]1UhhR{49GL33z6Oo!`
 !Ys@HV,^(Xp,BToM.;N_W%gT|&/I#H@Z:ISaK9NqH%&|AO|9i/nB@vD:Km&=R2_?O<_V^7?St>kW
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 16 Mar 2004 12:07:44 -0500 Robert Picco wrote:

| This patch supports three boot line options.  mem_limit limits the amount of physical memory.
| node_mem_limit limits the amount of physical memory per node on a NUMA machine.  nodes_limit
| reduces the number of NUMA nodes to the value specified.  On a NUMA machine an eliminated node's 
| CPU(s) are removed from the cpu_possible_map.  
| 
| The patch has been tested on an IA64 NUMA machine and uniprocessor X86 machine.

These kernel boot ("command line") parameters need to be documented
in Documentation/kernel-parameters.txt, please:

| +__setup("mem_limit", mem_setup);
| +__setup("node_mem_limit", node_mem_setup);
| +__setup("nodes_limit", nodes_setup);

--
~Randy
