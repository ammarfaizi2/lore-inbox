Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131756AbRDFPwl>; Fri, 6 Apr 2001 11:52:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131806AbRDFPwb>; Fri, 6 Apr 2001 11:52:31 -0400
Received: from fwns2d.raleigh.ibm.com ([204.146.167.236]:56068 "EHLO
	fwns2.raleigh.ibm.com") by vger.kernel.org with ESMTP
	id <S131756AbRDFPwP>; Fri, 6 Apr 2001 11:52:15 -0400
Message-ID: <3ACDE5C5.CEB65D4A@raleigh.ibm.com>
Date: Fri, 06 Apr 2001 16:50:29 +0100
From: Christopher Turcksin <turcksin@raleigh.ibm.com>
Organization: IBM Global Services AMS Design & Development
X-Mailer: Mozilla 4.75 [en] (Win98; U)
X-Accept-Language: en
MIME-Version: 1.0
To: "Eric W. Biederman" <ebiederm@xmission.com>
CC: "Miller, Brendan" <Brendan.Miller@Dialogic.com>,
        "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: Proper way to release binary driver?
In-Reply-To: <EFC879D09684D211B9C20060972035B1D46A39@exchange2ca.sv.dialogic.com> <m1g0fnwoo0.fsf@frodo.biederman.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Eric W. Biederman" wrote:

> If what you are after is a way to release a driver that is not a
> hassle to add to an already working system, you will find a more
> receptive ear.  I have heard some talk, that it would be a good idea
> to figure out how to standardize how to compile a kernel driver
> outside the kernel tree, so it could be trivial enough that anyone
> could do it.  To date there are enough people around who don't have
> problems compiling their own kernel that this hasn't become a major
> issue.

Eric,

I am finding myself exactly in this situation, and I've got a feeling
that this won't be the last time either.

I expect that every future Linux driver I get involved with will be
released under GPL. However, I think that the majority of our customers
will be running a distribution that does not yet support a new driver,
and even at Linux speeds, it'll take a long enough time that customers
cannot afford to wait for the next release that includes the driver.

So the big issue for us appears to be how we support these customers.

There is no way that we can support customers who have custom kernels,
but since they are 'in it' enough to compile their own kernel, I guess
they're able to apply our patch and recompile it. I actually suspect
that there aren't that many who do this anyway.

Where we find we have a problem is the number of different 'standard'
kernels out there. We find that we need to support all releases since
the last year or so for each distribution. And for each of those, we
find that there are many different kernel versions (some bugfixes, some
provide half a dozen different kernels with the CDs, aso.). And since we
do not expect these customers to compile their own kernel, we see no
option but to provide a precompiled binary driver. The numbers multiply
quickly and building all of those becomes an interesting problem.

We had hoped that MODVERSIONS would allow us to provide a single (or at
most a few) binary driver. Kernels with even minor version numbers are
supposed to be stable (even if they are buggy) ie. not have wildly
changing kernel interfaces.

In practice, that doesn't work. A driver compiled with 2.2.16 doesn't
load with 2.2.16-5.0 (from RedHat 6.2) (just an example). 



-- 
bfn,
wabbit

IBM Global Services, UK AMS in Greenock, Scotland.

	" To err is human, but to really foul things up requires the root
password. "
