Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291088AbSCHWzS>; Fri, 8 Mar 2002 17:55:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291214AbSCHWzJ>; Fri, 8 Mar 2002 17:55:09 -0500
Received: from host194.steeleye.com ([216.33.1.194]:41738 "EHLO
	pogo.mtv1.steeleye.com") by vger.kernel.org with ESMTP
	id <S291088AbSCHWyw>; Fri, 8 Mar 2002 17:54:52 -0500
Message-Id: <200203082254.g28MsnO08634@localhost.localdomain>
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.0.4
To: Dave Jones <davej@suse.de>
cc: linux-kernel@vger.kernel.org
Subject: Re: [RFC] modularization of i386 setup_arch and mem_init in 2.4.18
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Fri, 08 Mar 2002 17:54:49 -0500
From: James Bottomley <James.Bottomley@steeleye.com>
X-AntiVirus: scanned for viruses by AMaViS 0.2.1 (http://amavis.org/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> As a sidenote (sort of related topic) :
>  An idea being kicked around a little right now is x86 subarch
>  support for 2.5. With so many of the niche x86 spin-offs appearing
>  lately, all fighting for their own piece of various files in
>  arch/i386/kernel/, it may be time to do the same as the ARM folks
> did,
>  and have..

>   arch/i386/generic/
>   arch/i386/numaq/
>   arch/i386/visws
>   arch/i386/voyager/
>   etc..

I'll go for this (although it's probably a 2.5 thing rather than 2.4).  The 
key to making an effective split is to get the abstractions in the generic 
part correct.  I suspect that each of the different arch's has slightly 
different abstraction requirements of the i386 routines, but if we begin the 
split in one arch and pass it around to the others we'll end up with something 
that is roughly correct.

I'll look at doing at least a generic and voyager in the next week (if I get 
time).

James


