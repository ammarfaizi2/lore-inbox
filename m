Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750798AbWHYNj1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750798AbWHYNj1 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Aug 2006 09:39:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751211AbWHYNj1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Aug 2006 09:39:27 -0400
Received: from web25810.mail.ukl.yahoo.com ([217.12.10.195]:45212 "HELO
	web25810.mail.ukl.yahoo.com") by vger.kernel.org with SMTP
	id S1750798AbWHYNj1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Aug 2006 09:39:27 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.fr;
  h=Message-ID:Received:Date:From:Reply-To:Subject:To:Cc:In-Reply-To:MIME-Version:Content-Type;
  b=Ol58kUWS9VZMJnyRQuBou6pxSlzHCAlgv6JKX2autIXfbR3bInrIzi1utHMLCqW5dEA9eq63PHWib0bjmcdSl9t+pEdpBhxCIWZgryHryy7tTJnl1zuEkCOUe6ZRJ4qAdaTzXSZ9o17M4VtWduOZcTaxKaPUVKaZivgbEw4lfWw=  ;
Message-ID: <20060825133925.47842.qmail@web25810.mail.ukl.yahoo.com>
Date: Fri, 25 Aug 2006 13:39:25 +0000 (GMT)
From: moreau francis <francis_moreau2000@yahoo.fr>
Reply-To: moreau francis <francis_moreau2000@yahoo.fr>
Subject: Re : Re : Re : [HELP] Power management for embedded system
To: Russell King <rmk+lkml@arm.linux.org.uk>
Cc: linux-pm@lists.osdl.org, linux-kernel@vger.kernel.org
In-Reply-To: <20060824215650.GB21439@flint.arm.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Russell King wrote:
> We have some folk who want a method to trigger emergency suspends when
> batteries got low, or if you move the battery cover, etc.  These are
> events which require fast reactions from the system, and coding up some
> additional interface to pass such events to userland, have some daemon
> running to monitor for those events, and issue a PM event is completely
> overkill and, actually, unreliable.
> 

I'm not sure to understand why a daemon is needed. Could you explain ?

>> Could you point out where it is handled ?
> 
> It's both machine class and CPU specific.  I couldn't point you at
> anything specific, except to say that different machines and ARM CPUs
> handle it differently.
> 
> Some CPUs have "wait for interrupt" instructions, some don't.  Some
> need special cache handling around this instruction, some don't.  Some
> machines have a CPU capable of "wait for interrupt" but must not use it.
> 
> It's all handled by the CPU abstraction, and the machine class abstraction.
> 
> See arch_idle in include/asm-arm/arch-*/system.h as the starting point
> for the "default" (== always used) idle implementations.
> 

thanks for that.

Francis



