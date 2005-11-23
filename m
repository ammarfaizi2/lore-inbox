Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932078AbVKWSRN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932078AbVKWSRN (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Nov 2005 13:17:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932131AbVKWSRN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Nov 2005 13:17:13 -0500
Received: from khepri.openbios.org ([80.190.231.112]:6319 "EHLO
	khepri.openbios.org") by vger.kernel.org with ESMTP id S932078AbVKWSRL
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Nov 2005 13:17:11 -0500
Date: Wed, 23 Nov 2005 19:17:08 +0100
From: Stefan Reinauer <stepan@openbios.org>
To: Andi Kleen <ak@suse.de>
Cc: yhlu <yinghailu@gmail.com>, discuss@x86-64.org, linuxbios@openbios.org,
       linux-kernel@vger.kernel.org, yhlu <yhlu.kernel@gmail.com>
Subject: Re: [LinuxBIOS] x86_64: apic id lift patch
Message-ID: <20051123181708.GB27398@openbios.org>
References: <86802c440511211349t6a0a9d30i60e15fa23b86c49d@mail.gmail.com> <20051121220605.GD20775@brahms.suse.de> <43849FA5.4020201@lanl.gov> <2ea3fae10511230919l4d9829d8j3ce5d820b74074d1@mail.gmail.com> <20051123173636.GL20775@brahms.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051123173636.GL20775@brahms.suse.de>
X-Operating-System: Linux 2.6.14-20051104171614-smp on an x86_64
User-Agent: Mutt/1.5.9i
X-Duff: Orig. Duff, Duff Lite, Duff Dry, Duff Dark,
	Raspberry Duff, Lady Duff, Red Duff, Tartar Control Duff
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Andi Kleen <ak@suse.de> [051123 18:36]:
> You probably don't need most of it. Just a basic SRAT table (no AML methods)
> and enough to keep the ACPI interpreter from aborting early.
> 
> Or alternatively just fix the bug that caused you to go with discontig
> APICs in the first place.
 
Andi,

I really like your insisting way, but what we tried to express is that
there is hardware that just forces you to have discontiguous APIC ids,
so either you disable parts of the hardware or you are forced to do
nasty things.

Wrt the ACPI tables a good rule of thumb is that if you start to have
some of them you have to have them all. For example if you have a logical
subset of them and try to cover the rest with PIRQ or MPTABLE you will
fail because Linux moans about incorrect tables without even looking at
them. And no, there is no reason for not reading a HPET table when
there's no MADT available. And no, I'm not going to send a fix since I'm
really not motivated to dig into that code any minute more than
absolutely necessary.

I agree that there's a reason that the Linux ACPI code is as it is, but 
in fact as it is a reaction to zillions of buggy bioses it is not always
the best solution to have clean firmware not working with it "fixed" to
behave like the others out there. 

Stefan


