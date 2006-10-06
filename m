Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932477AbWJFALM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932477AbWJFALM (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Oct 2006 20:11:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932479AbWJFALM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Oct 2006 20:11:12 -0400
Received: from smtp.osdl.org ([65.172.181.4]:44244 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932477AbWJFALL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Oct 2006 20:11:11 -0400
Date: Thu, 5 Oct 2006 17:10:53 -0700
From: Andrew Morton <akpm@osdl.org>
To: Ralf Baechle <ralf@linux-mips.org>
Cc: Russell King <rmk@arm.linux.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: [APM] Share APM emulator between architectures.
Message-Id: <20061005171053.e467a5f4.akpm@osdl.org>
In-Reply-To: <20061005151840.GA16842@linux-mips.org>
References: <20061005151840.GA16842@linux-mips.org>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 5 Oct 2006 16:18:40 +0100
Ralf Baechle <ralf@linux-mips.org> wrote:

> Currently ARM and MIPS both have a copy of the APM emulation code.  Move
> that code to drivers/char and make it selectable through
> SYS_SUPPORTS_APM_EMULATION.  To make this work, fix MIPS Kconfig to use
> kernel/power/Kconfig.

It would have been better to create the new driver as a standalone
patch, then let arm and mips independently migrate over to it later on.

But if Russell's OK with this patch we can run with it.
