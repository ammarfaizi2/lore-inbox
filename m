Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266608AbUBLVgv (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Feb 2004 16:36:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266607AbUBLVgv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Feb 2004 16:36:51 -0500
Received: from fw.osdl.org ([65.172.181.6]:192 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S266608AbUBLVgt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Feb 2004 16:36:49 -0500
Date: Thu, 12 Feb 2004 13:38:31 -0800
From: Andrew Morton <akpm@osdl.org>
To: Mark Haverkamp <markh@osdl.org>
Cc: piggin@cyberone.com.au, linux-kernel@vger.kernel.org, linux-mm@kvack.org,
       cem@osdl.org
Subject: Re: 2.6.3-rc2-mm1
Message-Id: <20040212133831.5d173795.akpm@osdl.org>
In-Reply-To: <1076600437.22976.3.camel@markh1.pdx.osdl.net>
References: <20040212015710.3b0dee67.akpm@osdl.org>
	<402B6251.2060909@cyberone.com.au>
	<1076600437.22976.3.camel@markh1.pdx.osdl.net>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mark Haverkamp <markh@osdl.org> wrote:
>
> On Thu, 2004-02-12 at 03:24, Nick Piggin wrote:
> > Andrew Morton wrote:
> > 
> > >ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.3-rc2/2.6.3-rc2-mm1/
> > >
> > >
> > 
> > Nether this nor the previous one boots on the NUMAQ at osdl.
> > Not sure which is the last -mm that did. 2.6.3-rc2 boots.
> > 
> > I turned early_printk on and nothing. It stops at
> > Loading linux..............
> 
> I saw this behavior with the last mm kernel on my 8-way with
> CONFIG_HIGHMEM64G.  The problem went away when I backed out the
> highmem-equals-user-friendliness.patch

Thanks for working that out.  James Morris reports that the same patch
causes initrd-with-highmem failures.

Having enough bugs to care for, I guess I'll drop it.
