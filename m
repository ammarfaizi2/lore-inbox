Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265449AbSJXOcg>; Thu, 24 Oct 2002 10:32:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265457AbSJXOcg>; Thu, 24 Oct 2002 10:32:36 -0400
Received: from pixpat.austin.ibm.com ([192.35.232.241]:43990 "EHLO
	baldur.austin.ibm.com") by vger.kernel.org with ESMTP
	id <S265449AbSJXOcf>; Thu, 24 Oct 2002 10:32:35 -0400
Date: Thu, 24 Oct 2002 09:38:06 -0500
From: Dave McCracken <dmccr@us.ibm.com>
To: "Martin J. Bligh" <mbligh@aracnet.com>, Bill Davidsen <davidsen@tmr.com>
cc: Rik van Riel <riel@conectiva.com.br>,
       "Eric W. Biederman" <ebiederm@xmission.com>,
       Andrew Morton <akpm@digeo.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Linux Memory Management <linux-mm@kvack.org>
Subject: Re: [PATCH 2.5.43-mm2] New shared page table patch
Message-ID: <9100000.1035470286@baldur.austin.ibm.com>
In-Reply-To: <2832683854.1035444175@[10.10.2.3]>
References: <Pine.LNX.3.96.1021024064536.14473B-100000@gatekeeper.tmr.com>
 <2832683854.1035444175@[10.10.2.3]>
X-Mailer: Mulberry/3.0.0a4 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--On Thursday, October 24, 2002 07:22:56 -0700 "Martin J. Bligh"
<mbligh@aracnet.com> wrote:

>> Another thought, how does this play with NUMA systems? I don't have the
>> problem, but presumably there are implications.
> 
> At some point we'll probably only want one shared set per node.
> Gets tricky when you migrate processes across nodes though - will
> need more thought

Page tables can only be shared when they're pointing to the same data pages
anyway, so I think it's just part of the larger problem of node-local
memory.

Dave McCracken

======================================================================
Dave McCracken          IBM Linux Base Kernel Team      1-512-838-3059
dmccr@us.ibm.com                                        T/L   678-3059

