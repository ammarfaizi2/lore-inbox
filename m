Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314514AbSECQFt>; Fri, 3 May 2002 12:05:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314552AbSECQFs>; Fri, 3 May 2002 12:05:48 -0400
Received: from mail3.aracnet.com ([216.99.193.38]:38372 "EHLO
	mail3.aracnet.com") by vger.kernel.org with ESMTP
	id <S314514AbSECQFq>; Fri, 3 May 2002 12:05:46 -0400
Date: Fri, 03 May 2002 09:05:05 -0700
From: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>
Reply-To: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>
To: Leandro Tavares Carneiro <leandro@ep.petrobras.com.br>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: High Memory Address Space
Message-ID: <4058141609.1020416704@[10.10.2.3]>
In-Reply-To: <1020437001.2951.45.camel@linux60>
X-Mailer: Mulberry/2.1.2 (Win32)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> How is the maximum memory address space, per process or for all process,
> using High Memory Suport to 64Gb? 

Roughly speaking, the high memory (above 896MB phys) is mapped directly 
into user address spaces, mapped a page at a time into the kernel 
virtual address space via kmap and friends into a small window.

> Is possible to alocate more than 3GB for one process? 

Not really, you could shift the boundary to 3.5Gb or so in theory,
and eek out a little more, but in practice that just makes you
run out of kernel address space instead if you have enough memory
to make it worthwhile (unless you wanted the users pages swapped
out). 

M.

