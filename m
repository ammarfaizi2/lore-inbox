Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291910AbSBASqB>; Fri, 1 Feb 2002 13:46:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291907AbSBASpv>; Fri, 1 Feb 2002 13:45:51 -0500
Received: from pc1-camc5-0-cust78.cam.cable.ntl.com ([80.4.0.78]:62897 "EHLO
	amadeus.home.nl") by vger.kernel.org with ESMTP id <S291910AbSBASph>;
	Fri, 1 Feb 2002 13:45:37 -0500
Message-Id: <m16Wig6-000OVeC@amadeus.home.nl>
Date: Fri, 1 Feb 2002 18:44:50 +0000 (GMT)
From: arjan@fenrus.demon.nl
To: garzik@havoc.gtf.org (Jeff Garzik)
Subject: Re: [PATCH] Radix-tree pagecache for 2.5
cc: linux-kernel@vger.kernel.org
In-Reply-To: <20020201132953.A27508@havoc.gtf.org>
X-Newsgroups: fenrus.linux.kernel
User-Agent: tin/1.5.8-20010221 ("Blue Water") (UNIX) (Linux/2.4.3-6.0.1 (i586))
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <20020201132953.A27508@havoc.gtf.org> you wrote:
> On Fri, Feb 01, 2002 at 09:06:37AM -0800, Linus Torvalds wrote:
>> Even databases often use multiple files, and quite frankly, a database
>> that doesn't use mmap and doesn't try very hard to not cause extra system
>> calls is going to be bad performance-wise _regardless_ of any page cache
>> locking.

> I've always thought that read(2) and write(2) would in the end wind up
> faster than mmap(2)...  Tests in my rewritten cp/rm/mv type utilities
> seem to bear this out.

the biggest reason for this is that we *suck* at readahead for mmap....
