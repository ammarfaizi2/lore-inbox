Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263373AbTHVT1I (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Aug 2003 15:27:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263376AbTHVT1I
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Aug 2003 15:27:08 -0400
Received: from lightning.hereintown.net ([141.157.132.3]:51613 "EHLO
	lightning.hereintown.net") by vger.kernel.org with ESMTP
	id S263373AbTHVT1B (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Aug 2003 15:27:01 -0400
Subject: Re: [Bug 1131] New: Unable to compile without "Software Suspend"
	(AMD 64)
From: Chris Meadors <clubneon@hereintown.net>
To: "Martin J. Bligh" <mbligh@aracnet.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, michal-bugzilla@logix.cz
In-Reply-To: <18140000.1061567551@[10.10.2.4]>
References: <18140000.1061567551@[10.10.2.4]>
Content-Type: text/plain
Message-Id: <1061579716.13872.4.camel@clubneon.priv.hereintown.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.3 
Date: 22 Aug 2003 15:15:16 -0400
Content-Transfer-Encoding: 7bit
X-Scanner: exiscan for exim4 (http://duncanthrax.net/exiscan/) *19qHYq-0001fi-Bk*DbmBnEUEPa6*
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2003-08-22 at 11:52, Martin J. Bligh wrote:
> http://bugme.osdl.org/show_bug.cgi?id=1131
> 
>            Summary: Unable to compile without "Software Suspend"
>     Kernel Version: 2.6.0-test3-bk9
>             Status: NEW
>           Severity: high
>              Owner: bugme-janitors@lists.osdl.org
>          Submitter: michal-bugzilla@logix.cz
> 
> 
> Hardware Environment: AMD64
> Software Environment: gcc-3.3
> Problem Description:
> 
> It's impossible to compile kernel without "Software Suspend" on AMD64. At the
> linking time it complains:
>   GEN     .version
>   CHK     include/linux/compile.h
>   UPD     include/linux/compile.h
>   CC      init/version.o
>   LD      init/built-in.o
>   LD      .tmp_vmlinux1
> arch/x86_64/kernel/built-in.o(.text+0xc6bf): In function `do_suspend_lowlevel':
> : undefined reference to `save_processor_state'
> arch/x86_64/kernel/built-in.o(.text+0xc6c6): In function `do_suspend_lowlevel':
> : undefined reference to `saved_context_esp'
> arch/x86_64/kernel/built-in.o(.text+0xc6cd): In function `do_suspend_lowlevel':
> : undefined reference to `saved_context_eax'
> 
> Steps to reproduce:
> On AMD64 deselect "Power management options" -> "Software Suspend" and compile.

It isn't just that.  It is if the ACPI Support -> Sleep States is
enabled (which it is by default), you then have to enable the Software
Suspend for the link to work.  So they are dependent on each other.  If
you disable both it will compile, or enable both.

-- 
Chris

