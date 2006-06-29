Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750944AbWF2Qoj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750944AbWF2Qoj (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jun 2006 12:44:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750947AbWF2Qoj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jun 2006 12:44:39 -0400
Received: from omx1-ext.sgi.com ([192.48.179.11]:45247 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S1750943AbWF2Qoi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jun 2006 12:44:38 -0400
Date: Thu, 29 Jun 2006 09:44:08 -0700
From: Paul Jackson <pj@sgi.com>
To: Valdis.Kletnieks@vt.edu
Cc: jlan@engr.sgi.com, akpm@osdl.org, nagar@watson.ibm.com, balbir@in.ibm.com,
       csturtiv@sgi.com, linux-kernel@vger.kernel.org
Subject: Re: [Patch][RFC] Disabling per-tgid stats on task exit in taskstats
Message-Id: <20060629094408.360ac157.pj@sgi.com>
In-Reply-To: <200606291230.k5TCUg45030710@turing-police.cc.vt.edu>
References: <44892610.6040001@watson.ibm.com>
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
	<20060629014050.d3bf0be4.pj@sgi.com>
	<200606291230.k5TCUg45030710@turing-police.cc.vt.edu>
Organization: SGI
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.3; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> You're probably correct on that model. However, it all depends on the actual
> workload. Are people who actually have large-CPU (>256) systems actually
> running fork()-heavy things like webservers on them, or are they running things
> like database servers and computations, which tend to have persistent
> processes?

It may well be mostly as you say - the large-CPU systems not running
the fork() heavy jobs.

Sooner or later, someone will want to run a fork()-heavy job on a
large-CPU system.  On a 1024 CPU system, it would apparently take
just 14 exits/sec/CPU to hit this bottleneck, if Jay's number of
14000 applied.

Chris Sturdivant's reply is reasonable -- we'll hit it sooner or later,
and deal with it then.

-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@sgi.com> 1.925.600.0401
