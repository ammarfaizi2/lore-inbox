Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265631AbSKFGUK>; Wed, 6 Nov 2002 01:20:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265649AbSKFGUJ>; Wed, 6 Nov 2002 01:20:09 -0500
Received: from gw1.cosmosbay.com ([62.23.185.226]:42258 "EHLO
	gw1.cosmosbay.com") by vger.kernel.org with ESMTP
	id <S265631AbSKFGUJ>; Wed, 6 Nov 2002 01:20:09 -0500
Message-ID: <051a01c2855d$7aec8990$760010ac@edumazet>
From: "dada1" <dada1@cosmosbay.com>
To: <linux-kernel@vger.kernel.org>,
       "William Lee Irwin III" <wli@holomorphy.com>
References: <E189FxU-0002ZQ-00@holomorphy>
Subject: hugetlb: No coalescing of adjacent mappings in /proc/pid/maps
Date: Wed, 6 Nov 2002 07:26:44 +0100
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1106
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1106
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello William

I noticed a small problem if a process allocates hugetlb memory using

sys_alloc_hugepages(0, 0, 4*1024*1024, PROT_READ|PROT_WRITE, 0) ;

If this process uses a lot of hugetlb pages, its /proc/pid/maps contains one
entry for each mapping.

Could it be possible to coalesce all consecutive mappings onto only one ? As
standard mmap() calls do ?

