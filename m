Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261326AbVBVTZg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261326AbVBVTZg (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Feb 2005 14:25:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261426AbVBVTZg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Feb 2005 14:25:36 -0500
Received: from fire.osdl.org ([65.172.181.4]:22925 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261326AbVBVTZa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Feb 2005 14:25:30 -0500
Date: Tue, 22 Feb 2005 11:25:13 -0800
From: Andrew Morton <akpm@osdl.org>
To: Matthew Wilcox <matthew@wil.cx>
Cc: jes@wildopensource.com, linux-ia64@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: [patch -mm series] ia64 specific /dev/mem handlers
Message-Id: <20050222112513.4162860d.akpm@osdl.org>
In-Reply-To: <20050222175225.GK28741@parcelfarce.linux.theplanet.co.uk>
References: <16923.193.128608.607599@jaguar.mkp.net>
	<20050222020309.4289504c.akpm@osdl.org>
	<yq0ekf8lksf.fsf@jaguar.mkp.net>
	<20050222175225.GK28741@parcelfarce.linux.theplanet.co.uk>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Matthew Wilcox <matthew@wil.cx> wrote:
>
> On Tue, Feb 22, 2005 at 09:41:04AM -0500, Jes Sorensen wrote:
>  > >> + if (page->flags & PG_uncached)
>  > 
>  > Andrew> dude.  That ain't gonna work ;)
>  > 
>  > Pardon my lack of clue, but why not?

	if (page->flags & (1<<PG_uncached))

would have been correcter.

>  I think you're supposed to always use test_bit() to check page flags

Yup.  Add PageUncached macros to page-flags.h.
