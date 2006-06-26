Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751232AbWFZRz4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751232AbWFZRz4 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jun 2006 13:55:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751236AbWFZRz4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jun 2006 13:55:56 -0400
Received: from smtp.osdl.org ([65.172.181.4]:37067 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751232AbWFZRzz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jun 2006 13:55:55 -0400
Date: Mon, 26 Jun 2006 10:55:48 -0700
From: Andrew Morton <akpm@osdl.org>
To: Jay Lan <jlan@sgi.com>
Cc: nagar@watson.ibm.com, jlan@engr.sgi.com, balbir@in.ibm.com,
       csturtiv@sgi.com, linux-kernel@vger.kernel.org
Subject: Re: [Patch][RFC]  Disabling per-tgid stats on task exit in
 taskstats
Message-Id: <20060626105548.edef4c64.akpm@osdl.org>
In-Reply-To: <44A01A50.1050403@sgi.com>
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
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.17; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 26 Jun 2006 10:33:04 -0700
Jay Lan <jlan@sgi.com> wrote:

> > Will that work for everyone ?
> 
> As long as the per-pid delayacct struct has a pointer to the per-tgid
> data struct and deoes not need to go through the loop on every exit.

My brain is wilting, and time is moving along.

Balbir, are you able to summarise where we stand wrt
per-task-delay-accounting-* now?

What problem have we identified?  How close are we to finding agreeable
solutions to them?

My general sense is that there's some rework needed, and that rework will
affect the userspace interfaces, which is a problem for a 2.6.18 merge.
