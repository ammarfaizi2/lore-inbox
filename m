Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262071AbUFCN3C@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262071AbUFCN3C (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Jun 2004 09:29:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262215AbUFCN3C
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Jun 2004 09:29:02 -0400
Received: from mx1.redhat.com ([66.187.233.31]:62896 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S262071AbUFCN3A (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Jun 2004 09:29:00 -0400
Date: Thu, 3 Jun 2004 14:28:52 +0100
From: Alasdair G Kergon <agk@redhat.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2/5: Device-mapper: kcopyd
Message-ID: <20040603132852.GD6627@agk.surrey.redhat.com>
Mail-Followup-To: Alasdair G Kergon <agk@redhat.com>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
References: <20040602154129.GO6302@agk.surrey.redhat.com> <20040602204126.2bd0565c.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040602204126.2bd0565c.akpm@osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 02, 2004 at 08:41:26PM -0700, Andrew Morton wrote:
> What is the page pool for?

On the I/O path it can't wait for pages to be allocated without 
risking deadlock.  (cf. pvmove in 2.4)


> Why are the pooled pages locked?

I can't see that having any effect (i.e. unnecessary).

 
> > +static int __init jobs_init(void)
> > +	INIT_LIST_HEAD(&_complete_jobs);
> > +	INIT_LIST_HEAD(&_io_jobs);
> > +	INIT_LIST_HEAD(&_pages_jobs);

> Do these lists need to be initialised a second time?

No:-)


Alasdair
-- 
agk@redhat.com
