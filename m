Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261333AbVB0DLC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261333AbVB0DLC (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 26 Feb 2005 22:11:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261338AbVB0DLC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 26 Feb 2005 22:11:02 -0500
Received: from lantana.tenet.res.in ([202.144.28.166]:53977 "EHLO
	lantana.cs.iitm.ernet.in") by vger.kernel.org with ESMTP
	id S261333AbVB0DKv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 26 Feb 2005 22:10:51 -0500
Date: Sun, 27 Feb 2005 08:41:02 +0530 (IST)
From: Payasam Manohar <pmanohar@lantana.cs.iitm.ernet.in>
To: linux-kernel@vger.kernel.org
cc: linux-os <linux-os@analogic.com>
Subject: Re: Invalid module format in Fedora core2
In-Reply-To: <20050225205004.GA15773@mars>
Message-ID: <Pine.LNX.4.60.0502270839570.27326@lantana.cs.iitm.ernet.in>
References: <Pine.LNX.4.60.0502252056130.17145@lantana.cs.iitm.ernet.in>
 <Pine.LNX.4.61.0502251031170.626@chaos.analogic.com> <20050225205004.GA15773@mars>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
X-MailScanner-Information: Please contact the ISP for more information
X-MailScanner: Mail-scanner Found to be clean
X-MailScanner-From: pmanohar@lantana.cs.iitm.ernet.in
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


hai sam,
    thanks for ur valuable info reg. 2.6 module insertion.




   Thanks&Regards,

   P.Manohar,
  n Fri, 25 Feb 2005, it was written:

>>
>> There are new books that you are supposed to buy which will
>> tell you how to re-write all your modules to interface with
>> the new crap.
> Whats wrong with the free articles at lwn.net?
>
>>
>> I attached a typical makefile so you can see how complicated
>> this new crap is.
> This is utterly crap.
>
> There is no difference in the Makefile being in-kernel or for an
> external module if the Makefile is used solely to specify content of the
> Module.
>
> So for a sample module named mymodule you need:
>
> Makefile:
> obj-m      := mymodule.o
> mymodule-y := file1.o file2.o file3.o
>
> Here assuming 3 files are needed to build the actual module.
> If you then want some wrapping to make things a bit easier you can add a
> second file:
>
>
> makefile:
> VERS := $(shell uname -r)
> CDIR := $(shell pwd)
>
> all:
> 	$(MAKE) V=1 -C /usr/src/linux-$(VERS) SUBDIRS=$(CDIR) modules
> 	strip -x -R .note -R .comment mymodule.ko
>
> And nothing special is needed with respect to vermagic etc. The kernel
> do it for you.
>
> Please keep in mind the original poster did not ask for a method that
> could be used for both 2.4 _and_ 2.6.
>
> 	Sam
>
