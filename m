Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261370AbVBWAs5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261370AbVBWAs5 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Feb 2005 19:48:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261371AbVBWAs5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Feb 2005 19:48:57 -0500
Received: from e3.ny.us.ibm.com ([32.97.182.143]:46734 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S261368AbVBWAsx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Feb 2005 19:48:53 -0500
Subject: Re: [patch -mm series] ia64 specific /dev/mem handlers
From: Dave Hansen <haveblue@us.ibm.com>
To: Jes Sorensen <jes@wildopensource.com>
Cc: Andrew Morton <akpm@osdl.org>, Matthew Wilcox <matthew@wil.cx>,
       linux-ia64@vger.kernel.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <yq0650kl1gd.fsf@jaguar.mkp.net>
References: <16923.193.128608.607599@jaguar.mkp.net>
	 <20050222020309.4289504c.akpm@osdl.org> <yq0ekf8lksf.fsf@jaguar.mkp.net>
	 <20050222175225.GK28741@parcelfarce.linux.theplanet.co.uk>
	 <20050222112513.4162860d.akpm@osdl.org>
	 <1109100938.25666.44.camel@localhost>  <yq0650kl1gd.fsf@jaguar.mkp.net>
Content-Type: text/plain
Date: Tue, 22 Feb 2005 16:48:44 -0800
Message-Id: <1109119724.7277.25.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-02-22 at 16:38 -0500, Jes Sorensen wrote:
> >>>>> "Dave" == Dave Hansen <haveblue@us.ibm.com> writes:
> 
> Dave> I was talking with Nigel Cunningham about doing something a
> Dave> little different from the classic page flag bits when the number
> Dave> of users is restricted and performance isn't ultra-critical.
> Dave> Would something like this work for you, instead of using a real
> Dave> page->flags bit for PG_cached?
> 
> Just took a quick look at this and it looks a bit heavy for our
> use. We are only looking at a small number of pages. However I could
> imagine future cases where performance may be more critical.

If it's a quite small number (or range) of pages, perhaps a short
list_head list would suffice.  It would sure beat consuming a page flag.

-- Dave

