Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268094AbUI1XVl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268094AbUI1XVl (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Sep 2004 19:21:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268095AbUI1XVl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Sep 2004 19:21:41 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.101]:6061 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S268094AbUI1XVk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Sep 2004 19:21:40 -0400
Subject: Re: get_user_pages() still broken in 2.6
From: Dave Hansen <haveblue@us.ibm.com>
To: Christoph Hellwig <hch@infradead.org>
Cc: Timur Tabi <timur.tabi@ammasso.com>, linux-mm <linux-mm@kvack.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       kernelnewbies@nl.linux.org
In-Reply-To: <20040929000325.A6758@infradead.org>
References: <4159E85A.6080806@ammasso.com>
	 <20040929000325.A6758@infradead.org>
Content-Type: text/plain
Message-Id: <1096413678.16198.16.camel@localhost>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Tue, 28 Sep 2004 16:21:18 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2004-09-28 at 16:03, Christoph Hellwig wrote:
> get_user_pages locks the page in memory.  It doesn't do anything about ptes.

You probably want mlock(2) to keep the kernel from messing with the ptes
at all.  But, you should probably really be thinking about why you're
accessing the page tables at all.  I count *ONE* instance in drivers/
where page tables are accessed directly.

-- Dave

