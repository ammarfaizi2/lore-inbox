Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265651AbSKASGT>; Fri, 1 Nov 2002 13:06:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265653AbSKASGT>; Fri, 1 Nov 2002 13:06:19 -0500
Received: from amsfep12-int.chello.nl ([213.46.243.18]:11361 "EHLO
	amsfep12-int.chello.nl") by vger.kernel.org with ESMTP
	id <S265651AbSKASGS>; Fri, 1 Nov 2002 13:06:18 -0500
Content-Type: text/plain; charset=US-ASCII
From: Jos Hulzink <josh@stack.nl>
To: Robert Varga <nite@hq.alert.sk>, linux-kernel@vger.kernel.org
Subject: Re: 2.5.45 build failed with ACPI turned on
Date: Fri, 1 Nov 2002 20:12:47 +0100
User-Agent: KMail/1.4.3
References: <20021031194547.GA3555@hq.alert.sk>
In-Reply-To: <20021031194547.GA3555@hq.alert.sk>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200211012012.47050.josh@stack.nl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

After some more puzzling, it becomes clear that much more ACPI code should rely on CONFIG_PM. (Sleep.c should not be compiled in at all without CONFIG_PM) As the ACPI guys seem awake, I assume this will be fixed soon. For now: don't forget to enable CONFIG_PM (Power Management in the root of ACPI / APM configuration)

Jos

On Thursday 31 October 2002 20:45, Robert Varga wrote:
> Hi
>
> Build fails with:
>
> drivers/acpi/sleep.c: In function `acpi_system_suspend':
> drivers/acpi/sleep.c:209: warning: implicit declaration of function
> `do_suspend_lowlevel' drivers/acpi/sleep.c: In function `acpi_sleep_init':
> drivers/acpi/sleep.c:707: `sysrq_acpi_poweroff_op' undeclared (first use in
> this function) drivers/acpi/sleep.c:707: (Each undeclared identifier is
> reported only once drivers/acpi/sleep.c:707: for each function it appears
> in.)
>
> The structure declaration is protected by
>
> #if defined(CONFIG_MAGIC_SYSRQ) && defined(CONFIG_PM)
>
> on line 640.
>
> Config file attached.


