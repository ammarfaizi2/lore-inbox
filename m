Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263309AbUGAALk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263309AbUGAALk (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Jun 2004 20:11:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263324AbUGAALe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Jun 2004 20:11:34 -0400
Received: from e5.ny.us.ibm.com ([32.97.182.105]:15499 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S263309AbUGAALd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Jun 2004 20:11:33 -0400
Subject: Re: [Lhms-devel] new memory hotremoval patch
From: Dave Hansen <haveblue@us.ibm.com>
To: IWAMOTO Toshihiro <iwamoto@valinux.co.jp>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       lhms <lhms-devel@lists.sourceforge.net>, linux-mm <linux-mm@kvack.org>
In-Reply-To: <20040630111719.EBACF70A92@sv1.valinux.co.jp>
References: <20040630111719.EBACF70A92@sv1.valinux.co.jp>
Content-Type: text/plain
Message-Id: <1088640671.5265.1017.camel@nighthawk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Wed, 30 Jun 2004 17:11:11 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2004-06-30 at 04:17, IWAMOTO Toshihiro wrote:
> Due to struct page changes, page->mapping == NULL predicate can no
> longer be used for detecting cancellation of an anonymous page
> remapping operation.  So the PG_again bit is being used again.
> It may be still possible to kill the PG_again bit, but the priority is
> rather low.

But, you reintroduced it everywhere, including file-backed pages, not
just for anonymous pages?  Why was this necessary?

-- Dave

