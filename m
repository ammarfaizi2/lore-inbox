Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261791AbUC0PaA (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 27 Mar 2004 10:30:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261795AbUC0PaA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 27 Mar 2004 10:30:00 -0500
Received: from ms-smtp-03.texas.rr.com ([24.93.47.42]:43405 "EHLO
	ms-smtp-03-eri0.texas.rr.com") by vger.kernel.org with ESMTP
	id S261791AbUC0P36 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 27 Mar 2004 10:29:58 -0500
Date: Sat, 27 Mar 2004 09:29:40 -0600
From: Dave McCracken <dmccr@us.ibm.com>
To: Andrew Morton <akpm@osdl.org>
cc: linux-kernel@vger.kernel.org
Subject: Re: 230-objrmap fixes for 2.6.3-mjb2
Message-ID: <236840000.1080401380@[10.1.1.4]>
In-Reply-To: <20040326152523.5bfe41db.akpm@osdl.org>
References: <20040325214529.GJ20019@dualathlon.random>
 	<Pine.LNX.4.44.0403261107100.16019-100000@localhost.localdomain>
 	<20040326180235.GD9604@dualathlon.random>
 <20040326152523.5bfe41db.akpm@osdl.org>
X-Mailer: Mulberry/3.0.3 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--On Friday, March 26, 2004 15:25:23 -0800 Andrew Morton <akpm@osdl.org>
wrote:

> It would be really, really nice if we could clean this crap up.  mmap_sem
> protects the vma tree, i_shared_sem protects the per-address_space vma
> lists and page_table_lock protects the pagetables.
> 
> Does this sound like something we can achieve?
> 
> (Could page_table_lock then become per-vma?)

The page_table_lock protection includes pgd and pmd.  Would they receive
adequate protection with a per-vma lock?  Could we come up with some
lockless scheme for managing them?  They're pretty much write-once, as it
stands.

Dave McCracken

