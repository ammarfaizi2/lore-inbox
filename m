Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751798AbWF2IlQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751798AbWF2IlQ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jun 2006 04:41:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751802AbWF2IlQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jun 2006 04:41:16 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:15073 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S1751798AbWF2IlP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jun 2006 04:41:15 -0400
Date: Thu, 29 Jun 2006 01:40:50 -0700
From: Paul Jackson <pj@sgi.com>
To: Jay Lan <jlan@engr.sgi.com>
Cc: akpm@osdl.org, nagar@watson.ibm.com, balbir@in.ibm.com, csturtiv@sgi.com,
       linux-kernel@vger.kernel.org
Subject: Re: [Patch][RFC]  Disabling per-tgid stats on task exit in
 taskstats
Message-Id: <20060629014050.d3bf0be4.pj@sgi.com>
In-Reply-To: <44A2FC72.9090407@engr.sgi.com>
References: <44892610.6040001@watson.ibm.com>
	<20060609010057.e454a14f.akpm@osdl.org>
	<448952C2.1060708@in.ibm.com>
	<20060609042129.ae97018c.akpm@osdl.org>
	<4489EE7C.3080007@watson.ibm.com>
	<449999D1.7000403@engr.sgi.com>
	<44999A98.8030406@engr.sgi.com>
	<44999F5A.2080809@watson.ibm.com>
	<4499D7CD.1020303@engr.sgi.com>
	<449C2181.6000007@watson.ibm.com>
	<20060623141926.b28a5fc0.akpm@osdl.org>
	<449C6620.1020203@engr.sgi.com>
	<20060623164743.c894c314.akpm@osdl.org>
	<449CAA78.4080902@watson.ibm.com>
	<20060623213912.96056b02.akpm@osdl.org>
	<449CD4B3.8020300@watson.ibm.com>
	<44A01A50.1050403@sgi.com>
	<20060626105548.edef4c64.akpm@osdl.org>
	<44A020CD.30903@watson.ibm.com>
	<20060626111249.7aece36e.akpm@osdl.org>
	<44A026ED.8080903@sgi.com>
	<20060626113959.839d72bc.akpm@osdl.org>
	<44A2F50D.8030306@engr.sgi.com>
	<20060628145341.529a61ab.akpm@osdl.org>
	<44A2FC72.9090407@engr.sgi.com>
Organization: SGI
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.3; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jay wrote:
> The ENOBUFS i experienced in my testing would start to happen
> when exit rate at around 14000 exits/sec. While our fields confirmed
> that a 1000 threads exit/sec was a real, i have no reason to be
> concerned of 14000 exits/sec rate. ;)

Andrew wrote:
>1000 exits/sec/CPU can happen.  How many CPUs did that machine have?

Jay - what happens if we have 1024 CPUs (the current default config
for ia64/sn2)?

My naive expectation would be that the rate of exits/sec would go up as
the number of CPUs. In other words, I'd expect the exits/sec/CPU to be
a rough constant, slowly increasing over the years as the CPU clock
rate goes up.

So if current CPU technology can generate 1000 exits/sec, and if we
have 1024 CPUs then doesn't that mean we'd like to handle a million
exits/sec?

-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@sgi.com> 1.925.600.0401
