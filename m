Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262728AbULQDbw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262728AbULQDbw (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Dec 2004 22:31:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262733AbULQDbw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Dec 2004 22:31:52 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:6034 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S262728AbULQDbu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Dec 2004 22:31:50 -0500
Date: Thu, 16 Dec 2004 19:31:43 -0800 (PST)
From: Christoph Lameter <clameter@sgi.com>
X-X-Sender: clameter@schroedinger.engr.sgi.com
To: William Lee Irwin III <wli@holomorphy.com>
cc: Hugh Dickins <hugh@veritas.com>, Nick Piggin <nickpiggin@yahoo.com.au>,
       Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>, linux-mm@kvack.org,
       linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: page fault scalability patch V12 [0/7]: Overview and performance
 tests
In-Reply-To: <20041212212456.GB2714@holomorphy.com>
Message-ID: <Pine.LNX.4.58.0412161931010.11341@schroedinger.engr.sgi.com>
References: <41BBF923.6040207@yahoo.com.au>
 <Pine.LNX.4.44.0412120914190.3476-100000@localhost.localdomain>
 <20041212212456.GB2714@holomorphy.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 12 Dec 2004, William Lee Irwin III wrote:

> On Sun, Dec 12, 2004 at 09:33:11AM +0000, Hugh Dickins wrote:
> > Oh, hold on, isn't handle_mm_fault's pmd without page_table_lock
> > similarly racy, in both the 64-on-32 cases, and on architectures
> > which have a more complex pmd_t (sparc, m68k, h8300)?  Sigh.
>
> yes.

Those may fall back to use the page_table_lock for individual operations
that cannot be realized in an atomic way.

