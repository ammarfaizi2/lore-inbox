Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268169AbUIBR7C@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268169AbUIBR7C (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Sep 2004 13:59:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268065AbUIBR5L
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Sep 2004 13:57:11 -0400
Received: from web81309.mail.yahoo.com ([206.190.37.84]:27247 "HELO
	web81309.mail.yahoo.com") by vger.kernel.org with SMTP
	id S268805AbUIBR4s (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Sep 2004 13:56:48 -0400
Message-ID: <20040902175647.97709.qmail@web81309.mail.yahoo.com>
Date: Thu, 2 Sep 2004 10:56:47 -0700 (PDT)
From: Dmitry Torokhov <dtor_core@ameritech.net>
Subject: Re: [PATCH] allow i8042 register location override
To: Bjorn Helgaas <bjorn.helgaas@hp.com>
Cc: Alessandro Rubini <rubini@ipvvis.unipv.it>, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>, Vojtech Pavlik <vojtech@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bjorn Helgass wrote:
> Allow the default i8042 register locations to be changed at run-time.
> This is a prelude to adding discovery via the ACPI namespace.
> 
> Signed-off-by: Bjorn Helgaas <bjorn.helgaas@hp.com>
> 

> 
> +static unsigned long i8042_command_reg = I8042_COMMAND_REG;
> +static unsigned long i8042_status_reg = I8042_STATUS_REG;
> +static unsigned long i8042_data_reg = I8042_DATA_REG;
> +

Hi Bjorn,

This will not work as these macros are not constants, see i8042-*io.h
and i8042_platform_init(). What you need to do is add ACPI hooks to
i8042_platform_init for i386/ia64/etc.

--
Dmitry

