Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262329AbUHBTZg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262329AbUHBTZg (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Aug 2004 15:25:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262391AbUHBTZg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Aug 2004 15:25:36 -0400
Received: from the-village.bc.nu ([81.2.110.252]:55476 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S262329AbUHBTZe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Aug 2004 15:25:34 -0400
Subject: Re: finding out the boot cpu number from userspace
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: "Martin J. Bligh" <mbligh@aracnet.com>
Cc: jmoyer@redhat.com, Arjan van de Ven <arjanv@redhat.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <35890000.1091472541@[10.10.2.4]>
References: <20040802121635.GE14477@devserv.devel.redhat.com>
	 <12690000.1091461852@[10.10.2.4]>
	 <16654.29342.977105.723775@segfault.boston.redhat.com>
	 <30660000.1091467382@[10.10.2.4]>
	 <1091468548.810.3.camel@localhost.localdomain>
	 <35890000.1091472541@[10.10.2.4]>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1091470979.857.7.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Mon, 02 Aug 2004 19:23:00 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Llu, 2004-08-02 at 19:49, Martin J. Bligh wrote:
> Ah, OK didn't know that ... however, I'm not convinced that panicing is 
> really that useful ... what happens if you proceed? IIRC, this is before 
> console_init as well, so people won't even see the error. At least it 
> should only do that on machines that are borked in such a fashion - 99% of 
> machines will work fine, AFAICS.

The APM power off one is actually very common. Another one the ACPI guys
are now fighting that we also hit with SMM is E750x systems, where both
SMM traps and ACPI appear only to work on the boot CPU.

The panic at least made sure that we didnt end up with random mysterious
later problems that would be "fun" to debug.

(Note btw we sometimes care that kexec runs the new boot code on the
right processor because the 16bit entry points for some things also use
SMM traps on certain bioses in order to get a clean entry/stack/etc)


Alan
