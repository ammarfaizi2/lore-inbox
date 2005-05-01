Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261613AbVEANnX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261613AbVEANnX (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 1 May 2005 09:43:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261611AbVEANnW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 1 May 2005 09:43:22 -0400
Received: from postfix3-1.free.fr ([213.228.0.44]:44225 "EHLO
	postfix3-1.free.fr") by vger.kernel.org with ESMTP id S261613AbVEANnB
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 1 May 2005 09:43:01 -0400
Subject: Re: HyperThreading, kernel 2.6.10, 1 logical CPU idle !!
From: Boris Fersing <mastermac@free.fr>
To: linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <4273FA88.1060405@free.fr>
References: <3Z3u8-28Z-9@gated-at.bofh.it> <4273E2BB.9010509@shaw.ca>
	 <4273FA88.1060405@free.fr>
Content-Type: text/plain; charset=UTF-8
Date: Sun, 01 May 2005 15:42:48 +0200
Message-Id: <1114954969.27940.1.camel@electron>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.1.1 
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I disabled SMT in the kernel config and yet it seems to work ...

Boris.

Le samedi 30 avril 2005 à 23:37 +0200, Boris Fersing a écrit :
> Robert Hancock a écrit :
> 
> > Boris Fersing wrote:
> >
> >> Hi there,
> >> I've a p4 HT 3,06Ghz, I've HT enabled in the BIOS and in the kernel :
> >>
> >> Linux electron 2.6.10-cj5 #6 SMP Fri Mar 4 02:18:08 CET 2005 i686 Mobile
> >> Intel(R) Pentium(R) 4     CPU 3.06GHz GenuineIntel GNU/Linux .
> >>
> >> But it seems that one of my cpus is idle (gkrellm monitor or top) :
> >>
> >> Cpu0  : 88.0% us, 12.0% sy,  0.0% ni,  0.0% id,  0.0% wa,  0.0% hi,
> >> 0.0% si
> >> Cpu1  :  0.0% us,  0.3% sy,  0.0% ni, 99.7% id,  0.0% wa,  0.0% hi,
> >> 0.0% si
> >>
> >>
> >> I'm actually compiling thunderbird with MAKEOPTS="-j3", so , the second
> >> should be used, shouldn't it ?
> >
> >
> > Are you sure that it is actually compiling multiple files at once?
> >
> Yes I'm sure, Even if I launch more than 1 gcc, or for example, start a
> compilation + video encoding (mencoder) + ... the second CPU won't work
> (idle 100% or sometimes 99,9%).
> 
> Regards,
> 
> Boris.
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

