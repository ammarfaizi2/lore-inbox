Return-Path: <linux-kernel-owner+willy=40w.ods.org-S270022AbUJSRm5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270022AbUJSRm5 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Oct 2004 13:42:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269996AbUJSRmm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Oct 2004 13:42:42 -0400
Received: from mx1.redhat.com ([66.187.233.31]:41606 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S270001AbUJSRl3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Oct 2004 13:41:29 -0400
Date: Tue, 19 Oct 2004 18:41:15 +0100
From: Alasdair G Kergon <agk@redhat.com>
To: Andrew Morton <akpm@osdl.org>
Cc: blaisorblade_spam@yahoo.it, linux-kernel@vger.kernel.org,
       Neil Brown <neilb@cse.unsw.edu.au>
Subject: Re: [patch 1/1] dm: fix printk warnings about whether %lu/%Lu is right for sector_t
Message-ID: <20041019174115.GC6408@agk.surrey.redhat.com>
Mail-Followup-To: Alasdair G Kergon <agk@redhat.com>,
	Andrew Morton <akpm@osdl.org>, blaisorblade_spam@yahoo.it,
	linux-kernel@vger.kernel.org, Neil Brown <neilb@cse.unsw.edu.au>
References: <20041008144034.EB891B557@zion.localdomain> <20041008121239.464151bd.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041008121239.464151bd.akpm@osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 08, 2004 at 12:12:39PM -0700, Andrew Morton wrote:
> I would prefer that SECTOR_FORMAT be removed altogether.
 
> The industry-standard way of printing a sector_t is:
> 	printk("%llu", (unsigned long long)sector);
 
What about reading a sector_t with sscanf, which looks like the
reason for the existence of SECTOR_FORMAT?

Alasdair
-- 
agk@redhat.com
