Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266435AbUGBDbr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266435AbUGBDbr (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Jul 2004 23:31:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266431AbUGBDbr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Jul 2004 23:31:47 -0400
Received: from fw.osdl.org ([65.172.181.6]:63198 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S266435AbUGBDbo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Jul 2004 23:31:44 -0400
Date: Thu, 1 Jul 2004 20:30:43 -0700
From: Andrew Morton <akpm@osdl.org>
To: Kevin Corry <kevcorry@us.ibm.com>
Cc: torvalds@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 1/1: Device-Mapper: Remove 1024 devices limitation
Message-Id: <20040701203043.08226a0c.akpm@osdl.org>
In-Reply-To: <200407012154.16312.kevcorry@us.ibm.com>
References: <200407011035.13283.kevcorry@us.ibm.com>
	<20040701143857.256959e5.akpm@osdl.org>
	<200407012154.16312.kevcorry@us.ibm.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kevin Corry <kevcorry@us.ibm.com> wrote:
>
> > Did you consider going to a different data structure altogether? 
>  > lib/radix-tree.c and lib/idr.c provide appropriate ones.
> 
>  The idr stuff looks promising at first glance. I'll take a better look at it 
>  tomorrow and see if we can switch from a bit-set to one of these data 
>  structures.

Yes, idr is the one to use.  That linear search you have in there becomes
logarithmic.  Will speed up the registration of 100,000 minors no end ;)

