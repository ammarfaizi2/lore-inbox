Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750742AbVL2O7e@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750742AbVL2O7e (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Dec 2005 09:59:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750752AbVL2O7e
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Dec 2005 09:59:34 -0500
Received: from filer.fsl.cs.sunysb.edu ([130.245.126.2]:29897 "EHLO
	filer.fsl.cs.sunysb.edu") by vger.kernel.org with ESMTP
	id S1750742AbVL2O7d (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Dec 2005 09:59:33 -0500
Subject: page refcounts?
From: Avishay Traeger <atraeger@cs.sunysb.edu>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Date: Thu, 29 Dec 2005 09:59:32 -0500
Message-Id: <1135868372.28155.4.camel@rockstar.fsl.cs.sunysb.edu>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello all,

How does the kernel determine when a page is unused?  I see that
__get_free_pages() returns pages that have no refcount and no flags
indicating that they should not be reclaimed.

The first page that is returned looks like:
flags:0x80000000 mapping:00000000 mapcount:0 count:1

And the subsequent pages look like:
flags:0x80000000 mapping:00000000 mapcount:0 count:0

I am printing this out exactly the way bad_page() does.  How does the
kernel know not to mess around with pages that have no refcount or any
flags to indicate that they are in use?  I've already searched google
and checked a couple books, and couldn't find an answer.

Thanks in advance,
Avishay Traeger

