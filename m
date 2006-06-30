Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750785AbWF3C0A@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750785AbWF3C0A (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jun 2006 22:26:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751416AbWF3C0A
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jun 2006 22:26:00 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:56508 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S1750785AbWF3CZ6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jun 2006 22:25:58 -0400
Date: Thu, 29 Jun 2006 19:25:26 -0700
From: Paul Jackson <pj@sgi.com>
To: Andrew Morton <akpm@osdl.org>
Cc: nagar@watson.ibm.com, hadi@cyberus.ca, Valdis.Kletnieks@vt.edu,
       jlan@engr.sgi.com, balbir@in.ibm.com, csturtiv@sgi.com,
       linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [Patch][RFC] Disabling per-tgid stats on task exit in taskstats
Message-Id: <20060629192526.360aa579.pj@sgi.com>
In-Reply-To: <20060629180502.3987a98e.akpm@osdl.org>
References: <44892610.6040001@watson.ibm.com>
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
	<20060629094408.360ac157.pj@sgi.com>
	<20060629110107.2e56310b.akpm@osdl.org>
	<44A425A7.2060900@watson.ibm.com>
	<20060629123338.0d355297.akpm@osdl.org>
	<44A43187.3090307@watson.ibm.com>
	<1151621692.8922.4.camel@jzny2>
	<44A47285.6060307@watson.ibm.com>
	<20060629180502.3987a98e.akpm@osdl.org>
Organization: SGI
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.3; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew wrote:
> Like, a single message which says "20,000 sub-millisecond-runtime tasks
> exited in the past second" or something.

System wide accumulation of such data in the exit() code path still
risks being a bottleneck, just a bit later on.

I'm more inclined now to look for ways to disable collection on some
CPUs, and/or to allow for multiple streams in the future, as need be,
along the lines of Shailabh's multiple TASKSTATS_LISTEN_GROUPs.

-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@sgi.com> 1.925.600.0401
