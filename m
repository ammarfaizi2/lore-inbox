Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269804AbRHaX60>; Fri, 31 Aug 2001 19:58:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269829AbRHaX6Q>; Fri, 31 Aug 2001 19:58:16 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:47118 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S269804AbRHaX6G>; Fri, 31 Aug 2001 19:58:06 -0400
Subject: Re: SMP, APIC and networking issues...
To: javadesigner@yahoo.com (java programmer)
Date: Sat, 1 Sep 2001 00:38:57 +0100 (BST)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20010831231156.90554.qmail@web14206.mail.yahoo.com> from "java programmer" at Aug 31, 2001 04:11:56 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15cxsH-0004F6-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> The supposed trick is to boot with a  "noapic" 
> option, since this is believed to be a APIC issue, 
> not a driver issue (as mentioned, this problem 
> has been seen for both 3com and intel cards).
> 
> Is "noapic" still the recommended approach for SMP
> kernels or is it advisable to use 2.4.9 to solve 
> this specific issue ?

If you are still seeing the problem then yes try noapic, but also let
me know if its happening with current kernels. The apic has multiple effects
and not all of them are necessarily hardware issues at all

The big one is that interrupts can get delayed and become much more 
asynchronous which can obviously have impacts on driver races
