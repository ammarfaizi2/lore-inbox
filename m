Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750984AbWIUTn7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750984AbWIUTn7 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Sep 2006 15:43:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751444AbWIUTn7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Sep 2006 15:43:59 -0400
Received: from smtp.osdl.org ([65.172.181.4]:13471 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750984AbWIUTn7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Sep 2006 15:43:59 -0400
Date: Thu, 21 Sep 2006 12:43:36 -0700
From: Andrew Morton <akpm@osdl.org>
To: Bernhard Rosenkraenzer <bero@arklinux.org>
Cc: linux-kernel@vger.kernel.org, Chuck Ebbert <76306.1226@compuserve.com>,
       Andi Kleen <ak@muc.de>
Subject: Re: "Int 6: CR2" on bootup w/ 2.6.18-rc7-mm1
Message-Id: <20060921124336.5dae2e09.akpm@osdl.org>
In-Reply-To: <200609211412.08561.bero@arklinux.org>
References: <200609211412.08561.bero@arklinux.org>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 21 Sep 2006 14:12:08 +0200
Bernhard Rosenkraenzer <bero@arklinux.org> wrote:

> This happens when trying to boot 2.6.18-rc7-mm1 on a truly ancient (Pentium 1) 
> box:
> 
> Uncompressing Linux... Ok, booting the kernel.
> 
> Int 6: CR2 00000000 err 00000000 EIP c0381719 CS 00000060 flags 00010046
> Stack: 00000000 c036f4d1 00000000 c0100199 000001b8 0505c600 00c036cc 001f0fc3
> 
> (No further details even with initcall_debug loglevel=7).
> c0381719 appears to be in ACPI code -- but the Int 6 error happens even with 
> acpi=off.

Well Chuck's new early-fault handler has gone and handled an early fault.

I assume that machine runs 2.6.18 OK with the same .config?
