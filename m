Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261358AbVGDQas@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261358AbVGDQas (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Jul 2005 12:30:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261409AbVGDQas
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Jul 2005 12:30:48 -0400
Received: from chiark.greenend.org.uk ([193.201.200.170]:26022 "EHLO
	chiark.greenend.org.uk") by vger.kernel.org with ESMTP
	id S261358AbVGDQao (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Jul 2005 12:30:44 -0400
To: hetfield666@gmail.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: notebook buttons trouble, acpi related
In-Reply-To: <1120493152.17493.30.camel@blight.blightgroup>
References: <1120493152.17493.30.camel@blight.blightgroup>
Date: Mon, 4 Jul 2005 17:30:44 +0100
Message-Id: <E1DpTqG-00038x-00@chiark.greenend.org.uk>
From: Matthew Garrett <mgarrett@chiark.greenend.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hetfield <hetfield666@gmail.com> wrote:

> if it turns off tft and change brightness i guess kernel should receive
> some events but
> /proc/acpi/event doesn't get them.

In general, these keys generate events that are handled by the hardware.
The kernel never gets told about them. If you disassemble your DSDT, you
may be able to find methods that correspond to the hotkeys - then you
can use the ACPI generic hotkey driver to bind them to events. However,
this isn't always true and is very hardware dependent.

-- 
Matthew Garrett | mjg59-chiark.mail.linux-rutgers.kernel@srcf.ucam.org
