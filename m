Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750801AbWHaIz3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750801AbWHaIz3 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 31 Aug 2006 04:55:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750837AbWHaIz3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 31 Aug 2006 04:55:29 -0400
Received: from smtp.osdl.org ([65.172.181.4]:32184 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750801AbWHaIz2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 31 Aug 2006 04:55:28 -0400
Date: Thu, 31 Aug 2006 01:54:30 -0700
From: Andrew Morton <akpm@osdl.org>
To: David Chinner <dgc@sgi.com>
Cc: Yao Fei Zhu <walkinair@cn.ibm.com>, linux-kernel@vger.kernel.org,
       haveblue@us.ibm.com, xfs@oss.sgi.com
Subject: Re: kernel BUG in __xfs_get_blocks at
 fs/xfs/linux-2.6/xfs_aops.c:1293!
Message-Id: <20060831015430.6df0d8ba.akpm@osdl.org>
In-Reply-To: <20060831081726.GV5737019@melbourne.sgi.com>
References: <44F67847.6030307@cn.ibm.com>
	<20060831074742.GD807830@melbourne.sgi.com>
	<44F6979C.4070309@cn.ibm.com>
	<20060831081726.GV5737019@melbourne.sgi.com>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.17; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 31 Aug 2006 18:17:26 +1000
David Chinner <dgc@sgi.com> wrote:

> > BTW, I have CONFIG_PPC_64K_PAGES enabled.
> 
> But that might be a good place to start. Can you see if you can
> reproduce the problem without this config option set?

It would be useful to compare the compiler warning output for 64k pages
versus that for smaller-pages.  

Several quite worrisome-looking warnings are emitted from various parts of
the kernel with 64k pages.  Related to arithmetic on short types.
