Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287155AbRL2IYE>; Sat, 29 Dec 2001 03:24:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287159AbRL2IXz>; Sat, 29 Dec 2001 03:23:55 -0500
Received: from [202.54.26.202] ([202.54.26.202]:62103 "EHLO hindon.hss.co.in")
	by vger.kernel.org with ESMTP id <S287155AbRL2IXm>;
	Sat, 29 Dec 2001 03:23:42 -0500
X-Lotus-FromDomain: HSS
From: alad@hss.hns.com
To: linux-kernel@vger.kernel.org
Message-ID: <65256B31.002E1834.00@sandesh.hss.hns.com>
Date: Sat, 29 Dec 2001 13:48:48 +0530
Subject: vmscan.c: shrink_cache() doubt
Mime-Version: 1.0
Content-type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



In shrink_cache(), we have

          if (!page->buffers && (page_count(page) != 1 || !page->mapping))
               goto page_mapped;
          .
          .
          .
page_mapped:
          if (--max_mapped >=0)
               continue;


Assume page->buffers == NULL and page->count == 1, then why jump to page_mapped
if page->mapping == NULL ??

-- Amol



