Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262338AbUCCDPG (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Mar 2004 22:15:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262339AbUCCDPG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Mar 2004 22:15:06 -0500
Received: from fw.osdl.org ([65.172.181.6]:12733 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262338AbUCCDPD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Mar 2004 22:15:03 -0500
Date: Tue, 2 Mar 2004 19:15:39 -0800
From: Andrew Morton <akpm@osdl.org>
To: Daniel Phillips <phillips@arcor.de>
Cc: paulmck@us.ibm.com, sct@redhat.com, hch@infradead.org,
       linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [RFC] Distributed mmap API
Message-Id: <20040302191539.6bffc687.akpm@osdl.org>
In-Reply-To: <200403022200.39633.phillips@arcor.de>
References: <20040216190927.GA2969@us.ibm.com>
	<200402251604.19040.phillips@arcor.de>
	<20040225140727.0cde826e.akpm@osdl.org>
	<200403022200.39633.phillips@arcor.de>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Daniel Phillips <phillips@arcor.de> wrote:
>
> Here is a rearranged zap_pte_range that avoids any operations for out-of-range
> pfns.

Please remind us why Linux needs this patch?

> +static void invalidate_mmap_range_list(struct list_head *head,
> +		 unsigned long const hba,  unsigned long const hlen, int all)
>  {

I forget what `all' does?  anon+swapcache as well as pagecache?

A bit of API documentation here would be appropriate.
