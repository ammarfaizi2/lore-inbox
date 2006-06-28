Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751573AbWF1VuY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751573AbWF1VuY (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jun 2006 17:50:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751574AbWF1VuY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jun 2006 17:50:24 -0400
Received: from smtp.osdl.org ([65.172.181.4]:55723 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751572AbWF1VuX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jun 2006 17:50:23 -0400
Date: Wed, 28 Jun 2006 14:53:41 -0700
From: Andrew Morton <akpm@osdl.org>
To: Jay Lan <jlan@engr.sgi.com>
Cc: nagar@watson.ibm.com, balbir@in.ibm.com, csturtiv@sgi.com,
       linux-kernel@vger.kernel.org
Subject: Re: [Patch][RFC]  Disabling per-tgid stats on task exit in
 taskstats
Message-Id: <20060628145341.529a61ab.akpm@osdl.org>
In-Reply-To: <44A2F50D.8030306@engr.sgi.com>
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
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jay Lan <jlan@engr.sgi.com> wrote:
>
> Testing with all delay-accounting patches as been in your 2.6.27-mm3
> tree as of 6/26 afternoon (ie, including the send-tgid-once, and
> avoid-sending-without-listeners patches), i do not see measurable
> performance difference with and without tgid processing when the
> exit rate was controlled to around 1000 exit/sec.
> 
> As a result i am OK to not include a design of a system-wise
> init-time configuration option (for per-thread group data processing)
> in the taskstats interface.

Sounds good, thanks.

> The ENOBUFS i experienced in my testing would start to happen
> when exit rate at around 14000 exits/sec. While our fields confirmed
> that a 1000 threads exit/sec was a real, i have no reason to be
> concerned of 14000 exits/sec rate. ;)

1000 exits/sec/CPU can happen.  How many CPUs did that machine have?
