Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267397AbUGNPRr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267397AbUGNPRr (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Jul 2004 11:17:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267398AbUGNPRr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Jul 2004 11:17:47 -0400
Received: from fw.osdl.org ([65.172.181.6]:18385 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S267397AbUGNPRq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Jul 2004 11:17:46 -0400
Date: Wed, 14 Jul 2004 08:17:37 -0700
From: Chris Wright <chrisw@osdl.org>
To: Ravikiran G Thirumalai <kiran@in.ibm.com>
Cc: linux-kernel@vger.kernel.org, dipankar@in.ibm.com
Subject: Re: [RFC] Lock free fd lookup
Message-ID: <20040714081737.N1973@build.pdx.osdl.net>
References: <20040714045345.GA1220@obelix.in.ibm.com> <20040714045640.GB1220@obelix.in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20040714045640.GB1220@obelix.in.ibm.com>; from kiran@in.ibm.com on Wed, Jul 14, 2004 at 10:26:42AM +0530
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Ravikiran G Thirumalai (kiran@in.ibm.com) wrote:
> This makes use of the lockfree refcounting infrastructure (see earlier
> posting today) to make files_struct.fd[] lookup lockfree. This is carrying 
> forward work done by Maneesh and Dipankar earlier. 
> 
> With the lockfree fd lookup patch, tiobench performance increases by 13% 
> for sequential reads, 21 % for random reads on a 4 processor pIII xeon.

I'm curious, how much of the performance improvement is from RCU usage
vs. making the basic syncronization primitive aware of a reader and
writer distinction?  Do you have benchmark for simply moving to rwlock_t?

thanks,
-chris
-- 
Linux Security Modules     http://lsm.immunix.org     http://lsm.bkbits.net
