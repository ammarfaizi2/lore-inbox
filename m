Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261762AbVECPbn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261762AbVECPbn (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 May 2005 11:31:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261783AbVECPbn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 May 2005 11:31:43 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:6802 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S261762AbVECPbm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 May 2005 11:31:42 -0400
Date: Tue, 3 May 2005 08:31:04 -0700
From: Paul Jackson <pj@sgi.com>
To: dino@in.ibm.com
Cc: nickpiggin@yahoo.com.au, Simon.Derr@bull.net, linux-kernel@vger.kernel.org,
       lse-tech@lists.sourceforge.net, colpatch@us.ibm.com,
       dipankar@in.ibm.com, akpm@osdl.org
Subject: Re: [RFC PATCH] Dynamic sched domains (v0.5)
Message-Id: <20050503083104.42a80df4.pj@sgi.com>
In-Reply-To: <20050503145835.GA9493@in.ibm.com>
References: <20050501190947.GA5204@in.ibm.com>
	<4275F665.1010101@yahoo.com.au>
	<20050502171619.GA4418@in.ibm.com>
	<4276B667.2050905@yahoo.com.au>
	<20050503145835.GA9493@in.ibm.com>
Organization: SGI
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dinakar wrote:
> As far as I can see only the ones marked "<----" should be under the
> dentry lock, considering the fact that it already holds the cpuset_sem
> all the while.

It looks that way to me, too.

I doubt we had any particular reason for locking entry as early
as we do in that code.

It's ok by me if you move the dentry lock lower, as you suggest.

-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@engr.sgi.com> 1.650.933.1373, 1.925.600.0401
