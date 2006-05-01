Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932326AbWEAXyq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932326AbWEAXyq (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 May 2006 19:54:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932328AbWEAXyq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 May 2006 19:54:46 -0400
Received: from mail1.webmaster.com ([216.152.64.168]:16400 "EHLO
	mail1.webmaster.com") by vger.kernel.org with ESMTP id S932326AbWEAXyp
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 May 2006 19:54:45 -0400
From: "David Schwartz" <davids@webmaster.com>
To: "Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>
Subject: RE: Compiling C++ modules
Date: Mon, 1 May 2006 16:53:47 -0700
Message-ID: <MDEHLPKNGKAHNMBLJOLKEEGCLKAB.davids@webmaster.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.6604 (9.0.2911.0)
In-Reply-To: <161717d50605011046p4bd51bbp760a46da4f1e3379@mail.gmail.com>
X-MIMEOLE: Produced By Microsoft MimeOLE V6.00.2900.2869
Importance: Normal
X-Authenticated-Sender: joelkatz@webmaster.com
X-Spam-Processed: mail1.webmaster.com, Mon, 01 May 2006 16:49:44 -0700
	(not processed: message from trusted or authenticated source)
X-MDRemoteIP: 206.171.168.138
X-Return-Path: davids@webmaster.com
X-MDaemon-Deliver-To: linux-kernel@vger.kernel.org
Reply-To: davids@webmaster.com
X-MDAV-Processed: mail1.webmaster.com, Mon, 01 May 2006 16:49:45 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> > The cost in developer time is borne once. The cost of performance
> > is borne every time you run the application.

> The cost in developer time is borne every time someone needs to
> modify the code.

	Or understand the code. Or debug the code. Or verify that the code operates
correctly. Or reuse the code for another purpose.

	In the bad old days, performance was the number one priority because
computers were slow and resources were scarce -- if you didn't your code
wasn't usable. There is still a small amount of code where performance is
truly the most important priority. Certainly, very low-level kernel code
falls in this category.

	We aren't in the bad old days anymore. And there are quite a few things
that are important other than performance. Clear, simple code is easier to
understand and maintain and more likely to be correct. Modifications are
less likely to break hidden dependencies. Code that isn't heavily optimized
is more likely to be secure.

	And the supreme irony is that the code often performs better anyway! There
are a lot of reasons why this is often the case. For example, clearer more
modular code is easier to optimize algorithmically. Hand optimizations may
remain in code long past the point where they made sense and to the point
where they become pessimizations because of new CPU architectures or smarter
compilers. Poor code organization mixes performance-critical code with code
that's not performance-critical so that the critical code is harder to
identify and optimize.

	I am not saying that the use of C++ over C is likely to improve
performance. I'm saying that there's a lot of code where performance is not
the most important priority, and that this type of code accounts for the
majority of code in a monolithic kernel.

	DS


