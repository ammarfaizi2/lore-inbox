Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262452AbSLSQDE>; Thu, 19 Dec 2002 11:03:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265773AbSLSQDE>; Thu, 19 Dec 2002 11:03:04 -0500
Received: from server.ehost4u.biz ([209.51.155.18]:48315 "EHLO
	host.ehost4u.biz") by vger.kernel.org with ESMTP id <S262452AbSLSQDE>;
	Thu, 19 Dec 2002 11:03:04 -0500
Message-ID: <1040314254.3e01ef8e3f7b1@209.51.155.18>
Date: Thu, 19 Dec 2002 11:10:54 -0500
From: billyrose@billyrose.net
To: root@chaos.analogic.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: Intel P6 vs P7 system call performance
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
User-Agent: Internet Messaging Program (IMP) 3.1
X-Originating-IP: 65.132.64.69
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - host.ehost4u.biz
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [32001 32001] / [32001 32001]
X-AntiAbuse: Sender Address Domain - host.ehost4u.biz
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Richard B. Johnson wrote:

> Because the number pushed onto the stack is a displacement, not
> an address, i.e., -4095. To have the address act as an address,
> you need to load a full-pointer, i.e. SEG:OFFSET (like the old
> 16-bit days). The offset is 32-bits and the segment is whatever
> the kernel has set up for __USER_CS (0x23). All the 'near' calls
> are calls to a signed displacement, same for jumps.

call's and jmp's use displacement, ret's are _always_ absolute.
