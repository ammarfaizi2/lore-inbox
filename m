Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751458AbWBVVBW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751458AbWBVVBW (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Feb 2006 16:01:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751462AbWBVVBW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Feb 2006 16:01:22 -0500
Received: from smtp.osdl.org ([65.172.181.4]:11464 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751458AbWBVVBV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Feb 2006 16:01:21 -0500
Date: Wed, 22 Feb 2006 12:50:49 -0800
From: Andrew Morton <akpm@osdl.org>
To: Ravikiran G Thirumalai <kiran@scalex86.org>
Cc: nickpiggin@yahoo.com.au, clameter@engr.sgi.com,
       linux-kernel@vger.kernel.org, shai@scalex86.org
Subject: Re: [patch] Cache align futex hash buckets
Message-Id: <20060222125049.6386c9e1.akpm@osdl.org>
In-Reply-To: <20060222201713.GA3663@localhost.localdomain>
References: <20060220233242.GC3594@localhost.localdomain>
	<43FA8938.70006@yahoo.com.au>
	<Pine.LNX.4.64.0602211030240.20166@schroedinger.engr.sgi.com>
	<43FBB2E8.2020300@yahoo.com.au>
	<20060221180845.79a44449.akpm@osdl.org>
	<43FBCE56.9020001@yahoo.com.au>
	<20060222201713.GA3663@localhost.localdomain>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ravikiran G Thirumalai <kiran@scalex86.org> wrote:
>
> We also collected hash collision statistics for 1024 slots.  We found that
>  50% of the slots did not take any hit!!  So maybe we should revisit the
>  hashing function before settling on the optimal number of hash slots. 

You could try switching from jhash2() to hash_long().

Was there any particular pattern to the unused slots?  Not something silly
like every second one?
