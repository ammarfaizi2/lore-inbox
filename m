Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318107AbSGMG2A>; Sat, 13 Jul 2002 02:28:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318109AbSGMG17>; Sat, 13 Jul 2002 02:27:59 -0400
Received: from holomorphy.com ([66.224.33.161]:43168 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S318107AbSGMG17>;
	Sat, 13 Jul 2002 02:27:59 -0400
Date: Fri, 12 Jul 2002 23:29:47 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: linux-kernel@vger.kernel.org
Subject: Re: lazy_buddy-2.5.25-1
Message-ID: <20020713062947.GD21551@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	linux-kernel@vger.kernel.org
References: <20020710085917.GP25360@holomorphy.com> <20020713062232.GC21551@holomorphy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Description: brief message
Content-Disposition: inline
In-Reply-To: <20020713062232.GC21551@holomorphy.com>
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 12, 2002 at 11:22:32PM -0700, William Lee Irwin III wrote:
> Okay, people bugged me about this so here it is, testbooted on an
> 8cpu 16GB i386 box:

A little birdie told me I forgot the following on top of this:

Cheers,
Bill


===== mm/page_alloc.c 1.130 vs edited =====
--- 1.130/mm/page_alloc.c	Fri Jul 12 23:14:35 2002
+++ edited/mm/page_alloc.c	Fri Jul 12 23:29:27 2002
@@ -362,6 +362,7 @@
 	list_del(&page->list);
 	area[found_order].locally_free--;
 	split_pages(zone, page, order, found_order);
+	return page;
 }
 
 #ifdef CONFIG_SOFTWARE_SUSPEND
