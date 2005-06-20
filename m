Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261479AbVFTGdj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261479AbVFTGdj (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Jun 2005 02:33:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261478AbVFTGdj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Jun 2005 02:33:39 -0400
Received: from smtp201.mail.sc5.yahoo.com ([216.136.129.91]:9907 "HELO
	smtp201.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S261404AbVFTGd1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Jun 2005 02:33:27 -0400
Subject: Re: How to identify cow (copy-on-write) pages during kernel
	execution?
From: Nick Piggin <nickpiggin@yahoo.com.au>
To: Mauricio Lin <mauriciolin@gmail.com>
Cc: lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <3f250c7105061922454dfe31ed@mail.gmail.com>
References: <3f250c7105061922454dfe31ed@mail.gmail.com>
Content-Type: text/plain
Date: Mon, 20 Jun 2005 16:33:20 +1000
Message-Id: <1119249201.6240.20.camel@npiggin-nld.site>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2005-06-20 at 01:45 -0400, Mauricio Lin wrote:


Hi,

> So when a page struct is considered a cow in the
> kernel and its count variable is updated? Certainly
> the counter page (page->_count) is updated when a page
> is shared because of copy-on-write feature. 
> How can I identify cow pages when it becomes cow? Is
> there any feasible way to perform that?
> 

Look in mm/memory.c at how the page fault handler decides
it is dealing with a COW page.

Nick

-- 
SUSE Labs, Novell Inc.

Send instant messages to your online friends http://au.messenger.yahoo.com 
