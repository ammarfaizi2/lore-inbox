Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268937AbUIBUUX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268937AbUIBUUX (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Sep 2004 16:20:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268764AbUIBURH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Sep 2004 16:17:07 -0400
Received: from pfepb.post.tele.dk ([195.41.46.236]:18052 "EHLO
	pfepb.post.tele.dk") by vger.kernel.org with ESMTP id S268948AbUIBUIm
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Sep 2004 16:08:42 -0400
Date: Thu, 2 Sep 2004 22:11:00 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: Oliver Antwerpen <olli@giesskaennchen.de>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Kernel Build error (objdump fails)
Message-ID: <20040902201100.GA15298@mars.ravnborg.org>
Mail-Followup-To: Oliver Antwerpen <olli@giesskaennchen.de>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <41377705.9060305@giesskaennchen.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41377705.9060305@giesskaennchen.de>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 02, 2004 at 09:39:49PM +0200, Oliver Antwerpen wrote:
> Hi folks,
> 
> when compiling the linux kernel (I tried 2.6.8, 2.6.8.1, 2.6.9-rc1) I get:
> 
>   CC      arch/i386/kernel/acpi/sleep.o
>   AS      arch/i386/kernel/acpi/wakeup.o
>   LD      arch/i386/kernel/acpi/built-in.o
> arch/i386/kernel/acpi/boot.o: file not recognized: File truncated
> make[2]: *** [arch/i386/kernel/acpi/built-in.o] Error 1
> make[1]: *** [arch/i386/kernel/acpi] Error 2
> make: *** [arch/i386/kernel] Error 2

Strange...
Try the following:
rm arch/i386/kernel/acpi/boot.o
make V=1

Since you have tried several versions I assume this file has been rebuild,
so it will still fail.

Try:
nm -p arch/i386/kernel/acpi/boot.o
objdump -x arch/i386/kernel/acpi/boot.o

Try running the gcc command by hand and see if .o file is still bad.

	Sam
