Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261913AbVCLN6o@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261913AbVCLN6o (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 12 Mar 2005 08:58:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261912AbVCLN6o
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 12 Mar 2005 08:58:44 -0500
Received: from [213.85.13.118] ([213.85.13.118]:42624 "EHLO tau.rusteko.ru")
	by vger.kernel.org with ESMTP id S261913AbVCLN5l (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Mar 2005 08:57:41 -0500
From: Nikita Danilov <nikita@clusterfs.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16946.62799.737502.923025@gargle.gargle.HOWL>
Date: Sat, 12 Mar 2005 16:57:35 +0300
To: Christoph Lameter <clameter@sgi.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org, akpm@osdl.org
Subject: Re: [PATCH] mm counter operations through macros
Newsgroups: gmane.linux.kernel.mm,gmane.linux.kernel
In-Reply-To: <Pine.LNX.4.58.0503111103200.22240@schroedinger.engr.sgi.com>
References: <Pine.LNX.4.58.0503110422150.19280@schroedinger.engr.sgi.com>
	<20050311182500.GA4185@redhat.com>
	<Pine.LNX.4.58.0503111103200.22240@schroedinger.engr.sgi.com>
X-Mailer: VM 7.17 under 21.5 (patch 17) "chayote" (+CVS-20040321) XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Lameter writes:
 > On Fri, 11 Mar 2005, Dave Jones wrote:
 > 
 > > Splitting this last one into inc_mm_counter() and dec_mm_counter()
 > > means you can kill off the last argument, and get some of the
 > > readability back. As it stands, I think this patch adds a bunch
 > > of obfuscation for no clear benefit.
 > 
 > Ok.
 > -----------------------------------------------------------------
 > This patch extracts all the operations on counters protected by the
 > page table lock (currently rss and anon_rss) into definitions in
 > include/linux/sched.h. All rss operations are performed through
 > the following macros:
 > 
 > get_mm_counter(mm, member)		-> Obtain the value of a counter
 > set_mm_counter(mm, member, value)	-> Set the value of a counter
 > update_mm_counter(mm, member, value)	-> Add to a counter

A nitpick, but wouldn't be it clearer to call it add_mm_counter()? As an
additional bonus this matches atomic_{inc,dec,add}() and makes macro
names more uniform.

 > inc_mm_counter(mm, member)		-> Increment a counter
 > dec_mm_counter(mm, member)		-> Decrement a counter

Nikita.
