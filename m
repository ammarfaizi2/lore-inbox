Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261562AbUKHLoY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261562AbUKHLoY (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Nov 2004 06:44:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261793AbUKHLoY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Nov 2004 06:44:24 -0500
Received: from e4.ny.us.ibm.com ([32.97.182.104]:7139 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S261562AbUKHLoT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Nov 2004 06:44:19 -0500
Date: Mon, 8 Nov 2004 17:23:53 +0530
From: Suparna Bhattacharya <suparna@in.ibm.com>
To: Arjan van de Ven <arjan@infradead.org>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] Fix O_SYNC speedup for generic_file_write_nolock
Message-ID: <20041108115353.GA4068@in.ibm.com>
Reply-To: suparna@in.ibm.com
References: <20041108100738.GA4003@in.ibm.com> <1099908278.3577.2.camel@laptop.fenrus.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1099908278.3577.2.camel@laptop.fenrus.org>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 08, 2004 at 11:04:38AM +0100, Arjan van de Ven wrote:
> > +EXPORT_SYMBOL(sync_page_range_nolock);
> 
> 
> why adding this export? nothing appears to be using it (AIO isn't a module after all)
> 

This doesn't have anything to do with AIO. Filesystems which implement 
the equivalent of generic_file_write_nolock may use sync_page_range_nolock
for O_SYNC.

Does that help clarify ?

Regards
Suparna

-- 
Suparna Bhattacharya (suparna@in.ibm.com)
Linux Technology Center
IBM Software Lab, India

