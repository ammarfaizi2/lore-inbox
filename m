Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261919AbUKPG17@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261919AbUKPG17 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Nov 2004 01:27:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261921AbUKPG16
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Nov 2004 01:27:58 -0500
Received: from smtp818.mail.sc5.yahoo.com ([66.163.170.4]:60037 "HELO
	smtp818.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S261919AbUKPG1O (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Nov 2004 01:27:14 -0500
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PNP support for i8042 driver
Date: Tue, 16 Nov 2004 01:27:10 -0500
User-Agent: KMail/1.6.2
Cc: matthieu castet <castet.matthieu@free.fr>, Adam Belay <ambx1@neo.rr.com>,
       bjorn.helgaas@hp.com, vojtech@suse.cz
References: <41960AE9.8090409@free.fr> <d120d500041115122846b9f0fa@mail.gmail.com> <41993320.3010501@free.fr>
In-Reply-To: <41993320.3010501@free.fr>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200411160127.10954.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 15 November 2004 05:52 pm, matthieu castet wrote:
> Hi,
> 
> Dmitry Torokhov wrote:
> > 
> > I think you need to make an effort to make a PCI device use IRQ12
> > but the idea is that if you don't have a mouse attached (but you do
> > have i8042) and you are short on free interrupts and your HW can
> > use IRQ12 for some other stuff let it have it. That is the reqson why
> > i8042 requests IRQ only when corresponding port is open. No mouse -
> > IRQ is free.
> > 
> And what happen if you use irq12 for an other stuff and you plug your 
> mouse and try to use it. The motherboard hasn't desalocated the irq12 
> for mouse, so there will be a big conflict...
> 

Actually no. The driver will not enable the AUX port unless IRQ12 (or
whatever ACPI/PNP IRQ reported) is available and therefore mouse movement
will not generate any interrupts.

Anyway, I'll shut up if you promise to merge ACPI and PNP together so
i8042 does not have 2 nearly identical implementations in i8042-x86ia64.h

-- 
Dmitry
