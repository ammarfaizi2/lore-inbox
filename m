Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269618AbUICJ5L@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269618AbUICJ5L (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Sep 2004 05:57:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269599AbUICJzR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Sep 2004 05:55:17 -0400
Received: from fw.osdl.org ([65.172.181.6]:54229 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S269587AbUICJta (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Sep 2004 05:49:30 -0400
Date: Fri, 3 Sep 2004 02:47:33 -0700
From: Andrew Morton <akpm@osdl.org>
To: Bernhard Rosenkraenzer <bero@arklinux.org>
Cc: linux-kernel@vger.kernel.org, Bjorn Helgaas <bjorn.helgaas@hp.com>
Subject: Re: [PATCH] 2.6.9-rc1-mm3 i8042 compilation
Message-Id: <20040903024733.2a4ca6ac.akpm@osdl.org>
In-Reply-To: <200409030943.10516.bero@arklinux.org>
References: <20040903014811.6247d47d.akpm@osdl.org>
	<200409030943.10516.bero@arklinux.org>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bernhard Rosenkraenzer <bero@arklinux.org> wrote:
>
> On Friday 03 September 2004 10:48, Andrew Morton wrote:
> > +acpi-based-i8042-keyboard-aux-controller-enumeration.patch
> 
> This one is broken:

OK, thanks.  I'll drop it.  I think it's being redone anyway.

> drivers/input/serio/i8042.c: In function `acpi_i8042_kbd_add':
> drivers/input/serio/i8042.c:1133: error: `i8042_data_reg' undeclared (first 
> usein this function)
> drivers/input/serio/i8042.c:1133: error: (Each undeclared identifier is 
> reported only once
> drivers/input/serio/i8042.c:1133: error: for each function it appears in.)
> drivers/input/serio/i8042.c:1134: error: `i8042_command_reg' undeclared (first 
> use in this function)
> drivers/input/serio/i8042.c:1135: error: `i8042_status_reg' undeclared (first 
> use in this function)
> 
> Looks like it's assigning values to variables that are neither declared nor 
> used anywhere - so the fix is fairly easy (attached).
> 
> LLaP
> bero
> 
