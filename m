Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267975AbTCFKvF>; Thu, 6 Mar 2003 05:51:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267991AbTCFKvF>; Thu, 6 Mar 2003 05:51:05 -0500
Received: from packet.digeo.com ([12.110.80.53]:9441 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S267975AbTCFKvE>;
	Thu, 6 Mar 2003 05:51:04 -0500
Date: Thu, 6 Mar 2003 03:01:29 -0800
From: Andrew Morton <akpm@digeo.com>
To: Andrew Morton <akpm@digeo.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: 2.5.64-mm1
Message-Id: <20030306030129.49f5c96f.akpm@digeo.com>
In-Reply-To: <20030305230712.5a0ec2d4.akpm@digeo.com>
References: <20030305230712.5a0ec2d4.akpm@digeo.com>
X-Mailer: Sylpheed version 0.8.9 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 06 Mar 2003 11:01:30.0427 (UTC) FILETIME=[BDF1C8B0:01C2E3CF]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton <akpm@digeo.com> wrote:
>
> 
> http://www.kernel.org/pub/linux/kernel/people/akpm/patches/2.5/2.5.64/2.5.64-mm1/
> 

It doesn't build with gcc-3.2.1.  Please put a

	#include <linux/string.h>

into include/linux/genhd.h


Also, the remap_file_pages changes make 2.5.64-mm1 an x86-only kernel.


And, with gcc-3.2.1:

mnm:/usr/src/25> nm vmlinux|grep __constant_memcpy | wc
    129     387    3741
mnm:/usr/src/25> nm vmlinux|grep __constant_c_and_count_memset | wc
    233     699    9553

