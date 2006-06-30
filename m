Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964773AbWF3Mpj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964773AbWF3Mpj (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Jun 2006 08:45:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932598AbWF3Mpj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Jun 2006 08:45:39 -0400
Received: from mx03.cybersurf.com ([209.197.145.106]:20870 "EHLO
	mx03.cybersurf.com") by vger.kernel.org with ESMTP id S932578AbWF3Mph
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Jun 2006 08:45:37 -0400
Subject: Re: [Patch][RFC] Disabling per-tgid stats on task exit in taskstats
From: jamal <hadi@cyberus.ca>
Reply-To: hadi@cyberus.ca
To: Shailabh Nagar <nagar@watson.ibm.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, csturtiv@sgi.com,
       balbir@in.ibm.com, jlan@engr.sgi.com, Valdis.Kletnieks@vt.edu,
       pj@sgi.com, Andrew Morton <akpm@osdl.org>
In-Reply-To: <44A49418.5080103@watson.ibm.com>
References: <44892610.6040001@watson.ibm.com>
	 <20060623164743.c894c314.akpm@osdl.org>	 <449CAA78.4080902@watson.ibm.com>
	 <20060623213912.96056b02.akpm@osdl.org>	 <449CD4B3.8020300@watson.ibm.com>
	 <44A01A50.1050403@sgi.com>	 <20060626105548.edef4c64.akpm@osdl.org>
	 <44A020CD.30903@watson.ibm.com>	 <20060626111249.7aece36e.akpm@osdl.org>
	 <44A026ED.8080903@sgi.com>	 <20060626113959.839d72bc.akpm@osdl.org>
	 <44A2F50D.8030306@engr.sgi.com>	 <20060628145341.529a61ab.akpm@osdl.org>
	 <44A2FC72.9090407@engr.sgi.com>	 <20060629014050.d3bf0be4.pj@sgi.com>
	 <200606291230.k5TCUg45030710@turing-police.cc.vt.edu>
	 <20060629094408.360ac157.pj@sgi.com>
	 <20060629110107.2e56310b.akpm@osdl.org>	<44A425A7.2060900@watson.ibm.com>
	 <20060629123338.0d355297.akpm@osdl.org>	<44A43187.3090307@watson.ibm.com>
	 <1151621692.8922.4.camel@jzny2>	<44A47285.6060307@watson.ibm.com>
	 <20060629180502.3987a98e.akpm@osdl.or! g> <44A47A3E.5070809@watson.ibm.com>
	 <1151631048.8922.139.camel@jzny2>  <44A49418.5080103@watson.ibm.com>
Content-Type: text/plain
Organization: unknown
Date: Fri, 30 Jun 2006 08:45:28 -0400
Message-Id: <1151671528.8922.149.camel@jzny2>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.1.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-29-06 at 23:01 -0400, Shailabh Nagar wrote:
> jamal wrote:

> >  
> >
> >>As long as the user is willing to pay the price in terms of memory,
> >>    
> >>
> >
> >You may wanna draw a line to the upper limit - maybe even allocate slab
> >space.
> >  
> >
> Didn't quite understand...could you please elaborate ?
> Today we have a slab cache from which the taskstats structure gets 
> allocated at the beginning
> of the exit() path.
> The upper limit to which you refer is the amount of slab memory the user 
> is willing to be used
> to store the bursty traffic ?
> 

I think you have it fine already if you have a slab - as long as you
know you will run out of space and have some strategy to deal with
such boundary conditions. I was only reacting to your statement
"As long as the user is willing to pay the price in terms of memory"
I think you meant that a user could adjust the slab size on bootup etc,
but it is finite in size.

cheers,
jamal

