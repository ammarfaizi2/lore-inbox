Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317147AbSEXOjL>; Fri, 24 May 2002 10:39:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317148AbSEXOjK>; Fri, 24 May 2002 10:39:10 -0400
Received: from mail3.aracnet.com ([216.99.193.38]:50345 "EHLO
	mail3.aracnet.com") by vger.kernel.org with ESMTP
	id <S317145AbSEXOjI>; Fri, 24 May 2002 10:39:08 -0400
Date: Fri, 24 May 2002 07:38:17 -0700
From: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>
Reply-To: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>
To: BALBIR SINGH <balbir.singh@wipro.com>, dipankar@in.ibm.com
cc: linux-kernel@vger.kernel.org, Rusty Russell <rusty@rustcorp.com.au>,
        Paul McKenney <paul.mckenney@us.ibm.com>,
        lse-tech@lists.sourceforge.net
Subject: RE: [Lse-tech] Re: [RFC] Dynamic percpu data allocator
Message-ID: <1572245169.1022225896@[10.10.2.3]>
In-Reply-To: <AAEGIMDAKGCBHLBAACGBKEKPCJAA.balbir.singh@wipro.com>
X-Mailer: Mulberry/2.1.2 (Win32)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Is there a reason to delay the implementation of CPU local memory,
> or are we waiting for NUMA guys to do it? Is it not useful in an
> SMP system to allocate CPU local memory?

That should be pretty easy to do now, if I understand what you're
asking for ... when you allocate the area for cpu N, just do
alloc_pages_node (cpu_to_nid(smp_processor_id())) or something
similar.

M.

