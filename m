Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312619AbSE1Fj1>; Tue, 28 May 2002 01:39:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312681AbSE1Fj0>; Tue, 28 May 2002 01:39:26 -0400
Received: from mout1.freenet.de ([194.97.50.132]:65155 "EHLO mout1.freenet.de")
	by vger.kernel.org with ESMTP id <S312619AbSE1Fj0>;
	Tue, 28 May 2002 01:39:26 -0400
From: Andreas Hartmann <andihartmann@freenet.de>
X-Newsgroups: fa.linux.kernel
Subject: Re: Memory management in Kernel 2.4.x
Date: Tue, 28 May 2002 07:42:11 +0200
Organization: Privat
Message-ID: <acv5bj$m6$1@ID-44327.news.dfncis.de>
In-Reply-To: <fa.n12rl6v.9644rg@ifi.uio.no> <fa.jd9c9pv.190gl8n@ifi.uio.no>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
X-Trace: susi.maya.org 1022564531 710 192.168.1.3 (28 May 2002 05:42:11 GMT)
X-Complaints-To: abuse@fu-berlin.de
User-Agent: KNode/0.7.1
To: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

H. Peter Anvin wrote:

> Followup to:  <1022513156.1126.289.camel@irongate.swansea.linux.org.uk>
> By author:    Alan Cox <alan@lxorguk.ukuu.org.uk>
> In newsgroup: linux.dev.kernel
>> 
>> On a -ac kernel with mode 2 or 3 set for overcommit you have to run out
>> of kernel resources to hang the box. It won't go OOM because it can't.
>> That wouldn't be a VM bug but a leak or poor handling of kernel
>> allocations somewhere. Sadly the changes needed to do that (beancounter
>> patch) were things Linus never accepted for 2.4
>> 
> 
> Well, if you can't fork a new process because that would push you into
> overcommit, then you usually can't actually do anything useful on the
> machine.

>From my experience with mode 2:

you can't do _anything_, if the overcommitment range has been reached. Even 
running programms are crashing if they want to have some more memory. So, 
new processes cannot be started and old processes cannot run and are 
crashing as far as they want to have more memory. At last, there will be 
only one user-process on the machine running - the bad programm, eating up 
all the memory.


Regards,
Andreas Hartmann
