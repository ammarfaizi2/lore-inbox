Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261503AbTIOQXB (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Sep 2003 12:23:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261500AbTIOQWx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Sep 2003 12:22:53 -0400
Received: from amdext2.amd.com ([163.181.251.1]:12975 "EHLO amdext2.amd.com")
	by vger.kernel.org with ESMTP id S261541AbTIOQW3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Sep 2003 12:22:29 -0400
Message-ID: <99F2150714F93F448942F9A9F112634C0638B1DE@txexmtae.amd.com>
From: richard.brunner@amd.com
To: alan@lxorguk.ukuu.org.uk, davidsen@tmr.com
cc: zwane@linuxpower.ca, linux-kernel@vger.kernel.org
Subject: RE: [PATCH] 2.6 workaround for Athlon/Opteron prefetch errata
Date: Mon, 15 Sep 2003 11:21:59 -0500
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
X-WSS-ID: 137B38A0358700-01-01
Content-Type: text/plain;
 charset=iso-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I think Alan brought up a very good point. Even if you
use a generic kernel that avoids prefetch use on Athlon
(which I am opposed to), it doesn't solve the problem
of user space programs detecting that the ISA supports
prefetch and using prefetch instructions and hitting the
errata on Athlon.

The user space problem worries me more, because the expectation
is that if CPUID says the program can use perfetch, it could
and should regardless of what the kernel decided to do here.

Andi's patch solves both the kernel space and the user space
issues in a pretty small footprint.


] -Rich ...
] AMD Fellow
] richard.brunner at amd com 

> -----Original Message-----
> From: Alan Cox [mailto:alan@lxorguk.ukuu.org.uk] 
> Sent: Monday, September 15, 2003 12:46 AM

> You also need it for userspace prefetch fault fixup for a 
> kernel without
> CONFIG_MK7 to run stuff perfectly on Athlon.
> 

