Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262351AbUEFOFR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262351AbUEFOFR (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 May 2004 10:05:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261798AbUEFOFR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 May 2004 10:05:17 -0400
Received: from [202.125.86.130] ([202.125.86.130]:18061 "EHLO
	ns2.astrainfonets.net") by vger.kernel.org with ESMTP
	id S262381AbUEFOBM convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 May 2004 10:01:12 -0400
Subject: Small problem, Can anybody help me?
Date: Thu, 6 May 2004 19:31:56 +0530
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 8BIT
Message-ID: <1118873EE1755348B4812EA29C55A97222F512@esnmail.esntechnologies.co.in>
Content-class: urn:content-classes:message
X-MS-Has-Attach: 
X-MimeOLE: Produced By Microsoft Exchange V6.5.6944.0
X-MS-TNEF-Correlator: 
Thread-Topic: Small problem, Can anybody help me?
Thread-Index: AcQzcrE7ftyqvwbTQlaFLeptwb+aOw==
From: "Srinivas G." <srinivasg@esntechnologies.co.in>
To: <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

I have written a small hello.c program in the Linux Kernel version
2.4.18-3.

The code is as follows.
-----------------------


define MODULE
#include <linux/module.h>
#include <linux/init.h>

MODULE_LICENSE("GPL");

int Test_init(void)
{
	printk("<1> Hello World\n");
	return 0;
}

void Test_cleanup(void)
{
	printk("<1> Good bye\n");
}

module_init(Test_init);
module_exit(Test_cleanup);


I compiled it under same kernel version that is 2.4.18-3. It was showing
the following errors.

In file included from hello.c:2:
/usr/include/linux/module.h:60: parse error before `atomic_t'
/usr/include/linux/module.h:60: warning: no semicolon at end of struct
or union
/usr/include/linux/module.h:60: warning: no semicolon at end of struct
or union
/usr/include/linux/module.h:62: parse error before `}'
/usr/include/linux/module.h:62: warning: data definition has no type or
storage class
/usr/include/linux/module.h:91: parse error before `}'


The errors came due to a mistake in linux header file. Is it so...

Thanks in advance for any help you can come up with.

Regards,

Srinivas G




