Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264386AbUEIVBp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264386AbUEIVBp (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 9 May 2004 17:01:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264388AbUEIVBp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 9 May 2004 17:01:45 -0400
Received: from mtvcafw.sgi.com ([192.48.171.6]:47096 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S264386AbUEIVBn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 9 May 2004 17:01:43 -0400
Date: Sun, 9 May 2004 14:06:11 -0700
From: Paul Jackson <pj@sgi.com>
To: Vincent Lefevre <vincent@vinc17.org>
Cc: linux-kernel@vger.kernel.org,
       "Richard B. Johnson" <root@chaos.analogic.com>
Subject: Re: [2.4.26] overcommit_memory documentation clarification
Message-Id: <20040509140611.28e4b2bf.pj@sgi.com>
In-Reply-To: <20040509022043.GE23263@ay.vinc17.org>
References: <20040509001045.GA23263@ay.vinc17.org>
	<Pine.LNX.4.53.0405082142100.25076@chaos>
	<20040509022043.GE23263@ay.vinc17.org>
Organization: SGI
X-Mailer: Sylpheed version 0.8.10claws (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Vincent wrote:
> NULL == (void *) 0 and NULL == 0 must be true
Yes - NULL is compares equal to both (void *)0 and 0.
No - not necessarily the _same_ value - one could be
on a system with 32 bit ints, 64 bit pointers, for example.

> The goal of malloc is to reserve memory.
It's up to the kernel whether sbrk (used by malloc to
obtain virtual address space) reserves memory or not.

Check out:
    /proc/sys/vm/overcommit_memory
    Documentation/sysctl/vm.txt - overcommit_memory

-- 
                          I won't rest till it's the best ...
                          Programmer, Linux Scalability
                          Paul Jackson <pj@sgi.com> 1.650.933.1373
