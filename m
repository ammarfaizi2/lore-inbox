Return-Path: <linux-kernel-owner+willy=40w.ods.org-S933085AbWF2XAn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933085AbWF2XAn (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jun 2006 19:00:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933083AbWF2XAn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jun 2006 19:00:43 -0400
Received: from mx03.cybersurf.com ([209.197.145.106]:45532 "EHLO
	mx03.cybersurf.com") by vger.kernel.org with ESMTP id S933064AbWF2XAm
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jun 2006 19:00:42 -0400
Subject: Re: [Patch][RFC] Disabling per-tgid stats on task exit in taskstats
From: jamal <hadi@cyberus.ca>
Reply-To: hadi@cyberus.ca
To: Shailabh Nagar <nagar@watson.ibm.com>
Cc: Andrew Morton <akpm@osdl.org>, pj@sgi.com, Valdis.Kletnieks@vt.edu,
       jlan@engr.sgi.com, balbir@in.ibm.com, csturtiv@sgi.com,
       linux-kernel@vger.kernel.org, netdev@vger.kernel.org
In-Reply-To: <44A450A1.4090202@watson.ibm.com>
References: <44892610.6040001@watson.ibm.com>
	 <44999F5A.2080809@watson.ibm.com>	<4499D7CD.1020303@engr.sgi.com>
	 <449C2181.6000007@watson.ibm.com>	<20060623141926.b28a5fc0.akpm@osdl.org>
	 <449C6620.1020203@engr.sgi.com>	<20060623164743.c894c314.akpm@osdl.org>
	 <449CAA78.4080902@watson.ibm.com>	<20060623213912.96056b02.akpm@osdl.org>
	 <449CD4B3.8020300@watson.ibm.com>	<44A01A50.1050403@sgi.com>
	 <20060626105548.edef4c64.akpm@osdl.org>	<44A020CD.30903@watson.ibm.com>
	 <20060626111249.7aece36e.akpm@osdl.org>	<44A026ED.8080903@sgi.com>
	 <20060626113959.839d72bc.akpm@osdl.org>	<44A2F50D.8030306@engr.sgi.com>
	 <20060628145341.529a61ab.akpm@osdl.org>	<44A2FC72.9090407@engr.sgi.com>
	 <20060629014050.d3bf0be4.pj@sgi.com>
	 <200606291230.k5TCUg45030710@turing-police.cc.vt.edu>
	 <20060629094408.360ac157.pj@sgi.com>
	 <20060629110107.2e56310b.akpm@osdl.org>	<44A425A7.2060900@watson.ibm.com>
	 <20060629123338.0d355297.akpm@osdl.org>	<44A42D6D.6060108@watson.ibm.com>
	 <20060629130046.c695c6c5.akpm@osdl.or! g> <44A450A1.4090202@watson.ibm.com>
Content-Type: text/plain
Organization: unknown
Date: Thu, 29 Jun 2006 19:00:38 -0400
Message-Id: <1151622038.8922.9.camel@jzny2>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.1.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-29-06 at 18:13 -0400, Shailabh Nagar wrote:

> 
> And now I remember why I didn't go down that path earlier. Relayfs is one-way
> kernel->user and lacks the ability to send query commands from user space
> that we need. Either we would need to send commands up through a separate interface
> (even a syscall) or try and ensure that the exiting genetlink interface can
> scale better with message volume (including throttling).

Refer to my other email - whatever it takes to store "bulk" data in the
kernel is subject to the constraint of the fact memory is finite.
You can send messages from the kernel in sizes constrained by the memory
socket size. You can tune the socket size.

cheers,
jamal

