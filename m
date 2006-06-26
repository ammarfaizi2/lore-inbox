Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932601AbWFZSNH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932601AbWFZSNH (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jun 2006 14:13:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932577AbWFZSNG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jun 2006 14:13:06 -0400
Received: from smtp.osdl.org ([65.172.181.4]:28372 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932601AbWFZSNF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jun 2006 14:13:05 -0400
Date: Mon, 26 Jun 2006 11:12:49 -0700
From: Andrew Morton <akpm@osdl.org>
To: Shailabh Nagar <nagar@watson.ibm.com>
Cc: jlan@sgi.com, jlan@engr.sgi.com, balbir@in.ibm.com, csturtiv@sgi.com,
       linux-kernel@vger.kernel.org
Subject: Re: [Patch][RFC]  Disabling per-tgid stats on task exit in
 taskstats
Message-Id: <20060626111249.7aece36e.akpm@osdl.org>
In-Reply-To: <44A020CD.30903@watson.ibm.com>
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
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.17; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 26 Jun 2006 14:00:45 -0400
Shailabh Nagar <nagar@watson.ibm.com> wrote:

> >
> >Balbir, are you able to summarise where we stand wrt
> >per-task-delay-accounting-* now?
> >  
> >
> Andrew,
> 
> I'm maintaining per-task delay accouting and taskstats interface patches 
> so I'll take the liberty to reply :-)

Sorry, too many IBMers ;)

> >What problem have we identified?  How close are we to finding agreeable
> >solutions to them?
> >  
> >
> The main problems identified are:
> 
> 1. extra sending of per-tgid stats on every thread exit
> 2. unnecessary send of per-tgid stats when there are no listeners
> 3. unnecessary linkage of delayacct accumalation into per-tgid stats 
> with sending out of taskstats
> 
> All three have an acceptable solution.
> 1. & 3. are going to be addressed in a patch I'm sending out shortly.
> 2. in a separate patch also being sent out shortly.

Great.

> >My general sense is that there's some rework needed, and that rework will
> >affect the userspace interfaces, which is a problem for a 2.6.18 merge.
> >  
> >
> The rework will affect the number of per-tgid records that userspace 
> sees (fewer), not the format or any of the
> other details regarding the genetlink interface.
> Will that be a problem for userspace ?

Nope.

OK, please send the patch and I'll plan on sending this lot to Linus
Thursdayish.

