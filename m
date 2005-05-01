Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261528AbVEAOZB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261528AbVEAOZB (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 1 May 2005 10:25:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261642AbVEAOZB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 1 May 2005 10:25:01 -0400
Received: from wproxy.gmail.com ([64.233.184.201]:1228 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261528AbVEAOYi convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 1 May 2005 10:24:38 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=IdcH20SAfFcaFlC287q6uOQVx/Y/P+hYKUkiN13WnRF1JDU845UUE5XwPuHNAOLvAt1FQvK78sRYlBqd6n9RfaNik1sOAFTfLtpMUVk89tYgKnNn+gSIeQN+bHup5sZE9+51dYcKcVbnTExreKtRJe+bFMxPvenlsiYZDSDKKjE=
Message-ID: <2cd57c9005050107244ffde141@mail.gmail.com>
Date: Sun, 1 May 2005 22:24:33 +0800
From: Coywolf Qi Hunt <coywolf@gmail.com>
Reply-To: coywolf@lovecn.org
To: Boris Fersing <mastermac@free.fr>
Subject: Re: HyperThreading, kernel 2.6.10, 1 logical CPU idle !!
Cc: linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <1114954969.27940.1.camel@electron>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
References: <3Z3u8-28Z-9@gated-at.bofh.it> <4273E2BB.9010509@shaw.ca>
	 <4273FA88.1060405@free.fr> <1114954969.27940.1.camel@electron>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

It seems the problem was already solved.Try the latest mm tree: 2.6.12-rc3-mm2.

FYI:
sched2-fix-smt-scheduling-problems-fix.patch
sched2-fix-smt-scheduling-problems.patch


On 5/1/05, Boris Fersing <mastermac@free.fr> wrote:
> I disabled SMT in the kernel config and yet it seems to work ...
> 
> Boris.
> 
> Le samedi 30 avril 2005 à 23:37 +0200, Boris Fersing a écrit :
> > Robert Hancock a écrit :
> >
> > > Boris Fersing wrote:
> > >
> > >> Hi there,
> > >> I've a p4 HT 3,06Ghz, I've HT enabled in the BIOS and in the kernel :
> > >>
> > >> Linux electron 2.6.10-cj5 #6 SMP Fri Mar 4 02:18:08 CET 2005 i686 Mobile
> > >> Intel(R) Pentium(R) 4     CPU 3.06GHz GenuineIntel GNU/Linux .
> > >>
> > >> But it seems that one of my cpus is idle (gkrellm monitor or top) :
> > >>
> > >> Cpu0  : 88.0% us, 12.0% sy,  0.0% ni,  0.0% id,  0.0% wa,  0.0% hi,
> > >> 0.0% si
> > >> Cpu1  :  0.0% us,  0.3% sy,  0.0% ni, 99.7% id,  0.0% wa,  0.0% hi,
> > >> 0.0% si
> > >>
> > >>
> > >> I'm actually compiling thunderbird with MAKEOPTS="-j3", so , the second
> > >> should be used, shouldn't it ?
> > >
> > >
> > > Are you sure that it is actually compiling multiple files at once?
> > >
> > Yes I'm sure, Even if I launch more than 1 gcc, or for example, start a
> > compilation + video encoding (mencoder) + ... the second CPU won't work
> > (idle 100% or sometimes 99,9%).
> >
> > Regards,
> >
> > Boris.



-- 
Coywolf Qi Hunt
http://sosdg.org/~coywolf/
