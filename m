Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261561AbTADWQU>; Sat, 4 Jan 2003 17:16:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261624AbTADWQU>; Sat, 4 Jan 2003 17:16:20 -0500
Received: from daimi.au.dk ([130.225.16.1]:62943 "EHLO daimi.au.dk")
	by vger.kernel.org with ESMTP id <S261561AbTADWQU>;
	Sat, 4 Jan 2003 17:16:20 -0500
Message-ID: <3E175F2F.F8C12CF@daimi.au.dk>
Date: Sat, 04 Jan 2003 23:24:47 +0100
From: Kasper Dupont <kasperd@daimi.au.dk>
Organization: daimi.au.dk
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.18-17.7.xsmp i686)
X-Accept-Language: en
MIME-Version: 1.0
To: anil vijarnia <linux_ker@rediffmail.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: writing from kernel
References: <20030104160255.6187.qmail@webmail28.rediffmail.com>
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

anil vijarnia wrote:
> 
> can anyone tell me how to write into i file from kernel space.
> i tried sys_open,sys_write functions bbbbbut they don't work
> from my module.

That is rarely a good idea. But if you insist on doing it anyway,
you could use filp_open and the methods in the returned struct.
I have an old code example here:

http://www.daimi.au.dk/~kasperd/linux_kernel/kcp.c

-- 
Kasper Dupont -- der bruger for meget tid på usenet.
For sending spam use mailto:aaarep@daimi.au.dk
for(_=52;_;(_%5)||(_/=5),(_%5)&&(_-=2))putchar(_);
