Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263264AbTDZA2n (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Apr 2003 20:28:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263993AbTDZA2n
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Apr 2003 20:28:43 -0400
Received: from bay-bridge.veritas.com ([143.127.3.10]:13764 "EHLO
	mtvmime03.VERITAS.COM") by vger.kernel.org with ESMTP
	id S263264AbTDZA2n (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Apr 2003 20:28:43 -0400
Date: Sat, 26 Apr 2003 01:42:51 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@localhost.localdomain
To: "Martin J. Bligh" <mbligh@aracnet.com>
cc: Timothy Miller <miller@techsource.com>, "H. Peter Anvin" <hpa@zytor.com>,
       <linux-kernel@vger.kernel.org>
Subject: Re: TASK_UNMAPPED_BASE & stack location
In-Reply-To: <3280000.1051308382@[10.10.2.4]>
Message-ID: <Pine.LNX.4.44.0304260138380.1229-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 25 Apr 2003, Martin J. Bligh wrote:
> >> 128Mb of it? The bottom page, or even a few Mb, sure ... 
> >> but 128Mb seems somewhat excessive ..

Yes.

> > Considering that your process space is 4gig, and that that 128Mb doesn't
> > really exist anywhere (no RAM, no page table entries, nothing), it's
> > really not excessive.  
> 
> I need the virtual space.

Plus you would (very often) get more physical.  i386 ELF text typically
begins at 0x08048000: putting stack just below text in many cases shares
page table between stack+text+data, and saves the page table at top of
user address space.

Hugh

