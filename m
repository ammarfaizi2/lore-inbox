Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264741AbSKEGq3>; Tue, 5 Nov 2002 01:46:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264771AbSKEGq3>; Tue, 5 Nov 2002 01:46:29 -0500
Received: from franka.aracnet.com ([216.99.193.44]:41149 "EHLO
	franka.aracnet.com") by vger.kernel.org with ESMTP
	id <S264741AbSKEGq2>; Tue, 5 Nov 2002 01:46:28 -0500
Date: Mon, 04 Nov 2002 22:49:16 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
Reply-To: "Martin J. Bligh" <mbligh@aracnet.com>
To: kcn <kcn@263.net>, linux-kernel@vger.kernel.org
Subject: Re: kernel freeze
Message-ID: <3842257604.1036450149@[10.10.2.3]>
In-Reply-To: <002c01c28493$2b489070$31036fa6@zhoulin>
References: <002c01c28493$2b489070$31036fa6@zhoulin>
X-Mailer: Mulberry/2.1.2 (Win32)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>   After I reported a kernel freeze in this mail list("2.4.18 freeze on
> 4G memory."),
> I try 2.4.19 & 2.4.19+rmap14a patch, all of those have been frozen.
> I try to enable kernel profiling to detect what is the problem and found
> the function _text_lock_vmscan make the cpu busy. Any comment?

I'll lay you a large bet that lowmem is full of garbage.
Probably buffer_heads, inodes or PTEs. Output of /proc/meminfo 
and /proc/slabinfo as you approach oblivion would be useful.
As would a description of the workload that triggers it.

M.

