Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268071AbUHQBaJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268071AbUHQBaJ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Aug 2004 21:30:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268072AbUHQBaJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Aug 2004 21:30:09 -0400
Received: from the-village.bc.nu ([81.2.110.252]:13798 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S268071AbUHQBaD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Aug 2004 21:30:03 -0400
Subject: Re: Fw: [Lhms-devel] Making hotremovable attribute with memory
	section[0/4]
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Dave Hansen <haveblue@us.ibm.com>
Cc: Yasunori Goto <ygoto@us.fujitsu.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-mm <linux-mm@kvack.org>, "Martin J. Bligh" <mbligh@aracnet.com>
In-Reply-To: <1092699350.1822.43.camel@nighthawk>
References: <20040816153613.E6F7.YGOTO@us.fujitsu.com>
	 <1092699350.1822.43.camel@nighthawk>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1092702436.21359.3.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Tue, 17 Aug 2004 01:27:23 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Maw, 2004-08-17 at 00:35, Dave Hansen wrote:
> In any case, the question of the day is, does anyone have any
> suggestions on how to create 2 separate pools for pages: one
> representing hot-removable pages, and the other pages that may not be
> removed?

How do you define the split. There are lots of circumstances where user
pages can be pinned for a long (near indefinite) period of time and used
for DMA.

Consider
- Video capture
- AGP Gart
- AGP based framebuffer (intel i8/9xx)
- O_DIRECT I/O

There are also things like cluster interconnects, sendfile and the like
involved here.

Alan

