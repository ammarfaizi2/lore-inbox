Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265913AbUFOUCN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265913AbUFOUCN (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Jun 2004 16:02:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265911AbUFOUA7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Jun 2004 16:00:59 -0400
Received: from fw.osdl.org ([65.172.181.6]:27543 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S265906AbUFOT7v (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Jun 2004 15:59:51 -0400
Date: Tue, 15 Jun 2004 12:59:47 -0700
From: Chris Wright <chrisw@osdl.org>
To: Dean Nelson <dcn@sgi.com>
Cc: Arjan van de Ven <arjanv@redhat.com>, linux-kernel@vger.kernel.org,
       rusty@rustcorp.com.au
Subject: Re: calling kthread_create() from interrupt thread
Message-ID: <20040615125947.A22989@build.pdx.osdl.net>
References: <40CF350B.mailxD2X1NPFBC@aqua.americas.sgi.com> <1087321777.2710.43.camel@laptop.fenrus.com> <20040615191440.GA17669@sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20040615191440.GA17669@sgi.com>; from dcn@sgi.com on Tue, Jun 15, 2004 at 02:14:40PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Dean Nelson (dcn@sgi.com) wrote:
> Can an interrupt handler setup a work_struct structure, call schedule_work()
> and then simply return, not waiting around for the work queue event to
> complete?

Yes, that's a fundamental feature.  However, it's not so nice to use the
generic events workqueue for really long sleeping work since it can stall
the entire queue.  You might consider your own queue.

thanks,
-chris
-- 
Linux Security Modules     http://lsm.immunix.org     http://lsm.bkbits.net
