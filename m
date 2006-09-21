Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750721AbWIUUQI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750721AbWIUUQI (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Sep 2006 16:16:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750954AbWIUUQI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Sep 2006 16:16:08 -0400
Received: from colin.muc.de ([193.149.48.1]:24077 "EHLO mail.muc.de")
	by vger.kernel.org with ESMTP id S1750845AbWIUUQF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Sep 2006 16:16:05 -0400
Date: 21 Sep 2006 22:16:03 +0200
Date: Thu, 21 Sep 2006 22:16:03 +0200
From: Andi Kleen <ak@muc.de>
To: Andrew Morton <akpm@osdl.org>
Cc: Bernhard Rosenkraenzer <bero@arklinux.org>, linux-kernel@vger.kernel.org,
       Chuck Ebbert <76306.1226@compuserve.com>
Subject: Re: "Int 6: CR2" on bootup w/ 2.6.18-rc7-mm1
Message-ID: <20060921201603.GA14649@muc.de>
References: <200609211412.08561.bero@arklinux.org> <20060921124336.5dae2e09.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060921124336.5dae2e09.akpm@osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 21, 2006 at 12:43:36PM -0700, Andrew Morton wrote:
> On Thu, 21 Sep 2006 14:12:08 +0200
> Bernhard Rosenkraenzer <bero@arklinux.org> wrote:
> 
> > This happens when trying to boot 2.6.18-rc7-mm1 on a truly ancient (Pentium 1) 
> > box:
> > 
> > Uncompressing Linux... Ok, booting the kernel.
> > 
> > Int 6: CR2 00000000 err 00000000 EIP c0381719 CS 00000060 flags 00010046
> > Stack: 00000000 c036f4d1 00000000 c0100199 000001b8 0505c600 00c036cc 001f0fc3
> > 
> > (No further details even with initcall_debug loglevel=7).
> > c0381719 appears to be in ACPI code -- but the Int 6 error happens even with 
> > acpi=off.
> 
> Well Chuck's new early-fault handler has gone and handled an early fault.
> 
> I assume that machine runs 2.6.18 OK with the same .config?

Int 6 is invalid op. Can you do 

gdb vmlinux
disassemble 0x<number behind EIP>?

and send the full output?

-Andi

