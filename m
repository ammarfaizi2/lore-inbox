Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265478AbSJXOyt>; Thu, 24 Oct 2002 10:54:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265477AbSJXOyV>; Thu, 24 Oct 2002 10:54:21 -0400
Received: from franka.aracnet.com ([216.99.193.44]:24761 "EHLO
	franka.aracnet.com") by vger.kernel.org with ESMTP
	id <S265475AbSJXOyO>; Thu, 24 Oct 2002 10:54:14 -0400
Date: Thu, 24 Oct 2002 07:51:46 -0700
From: "Martin J. Bligh" <mbligh@aracnet.com>
Reply-To: "Martin J. Bligh" <mbligh@aracnet.com>
To: Dave McCracken <dmccr@us.ibm.com>, Bill Davidsen <davidsen@tmr.com>
cc: Rik van Riel <riel@conectiva.com.br>,
       "Eric W. Biederman" <ebiederm@xmission.com>,
       Andrew Morton <akpm@digeo.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Linux Memory Management <linux-mm@kvack.org>
Subject: Re: [PATCH 2.5.43-mm2] New shared page table patch
Message-ID: <2834413140.1035445904@[10.10.2.3]>
In-Reply-To: <9100000.1035470286@baldur.austin.ibm.com>
References: <9100000.1035470286@baldur.austin.ibm.com>
X-Mailer: Mulberry/2.1.2 (Win32)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>> Another thought, how does this play with NUMA systems? I don't have the
>>> problem, but presumably there are implications.
>> 
>> At some point we'll probably only want one shared set per node.
>> Gets tricky when you migrate processes across nodes though - will
>> need more thought
> 
> Page tables can only be shared when they're pointing to the same 
> data pages anyway, so I think it's just part of the larger problem 
> of node-local memory.

Yes, same problem as text replication. You're right, it's probably not 
worth solving otherwise - too small a percentage of the real problem.

M.

