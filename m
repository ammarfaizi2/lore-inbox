Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265901AbSLSSig>; Thu, 19 Dec 2002 13:38:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265909AbSLSSig>; Thu, 19 Dec 2002 13:38:36 -0500
Received: from server.ehost4u.biz ([209.51.155.18]:11220 "EHLO
	host.ehost4u.biz") by vger.kernel.org with ESMTP id <S265901AbSLSSif>;
	Thu, 19 Dec 2002 13:38:35 -0500
Message-ID: <1040323590.3e0214063a990@209.51.155.18>
Date: Thu, 19 Dec 2002 13:46:30 -0500
From: billyrose@billyrose.net
To: bart@etpmod.phys.tue.nl
Cc: root@chaos.analogic.com, linux-kernel@vger.kernel.org
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


> Not true. A ret(urn) is (sort of) equivalent to 'pop %eip'. The above
> code would actually jump to address 0xfffff000, but probably be slow
> since it confuses the branch prediction.
>
>
>Bart

that being the case, then the original code that Linus put forth:

        pushl $0xfffff000
        call *(%esp)
        add $4,%esp

would be the way to go as it is highly readable. actually, the code at
0xfffff000 could issue a ret $4 and eliminate the add after the call.

