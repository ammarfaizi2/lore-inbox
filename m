Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290549AbSARAVw>; Thu, 17 Jan 2002 19:21:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290551AbSARAVm>; Thu, 17 Jan 2002 19:21:42 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:13073 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S290549AbSARAVc>; Thu, 17 Jan 2002 19:21:32 -0500
Subject: Re: [patch] VAIO irq assignment fix
To: kai@tp1.ruhr-uni-bochum.de (Kai Germaschewski)
Date: Fri, 18 Jan 2002 00:33:20 +0000 (GMT)
Cc: torvalds@transmeta.com (Linus Torvalds), davej@suse.de (Dave Jones),
        jes@wildopensource.com (Jes Sorensen),
        alan@lxorguk.ukuu.org.uk (Alan Cox), linux-kernel@vger.kernel.org,
        marcelo@conectiva.com.br (Marcelo Tosatti)
In-Reply-To: <Pine.LNX.4.33.0201180000490.1434-100000@vaio> from "Kai Germaschewski" at Jan 18, 2002 12:14:29 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16RMy8-0005UN-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Unfortunately, the PCI interrupt routing stuff in ACPI is not in a static 
> table, but needs the full-blown AML interpreter. Bad, but we can't do 
> anything about it.

Is that true of the MPS table as well ? Can you deduce one from the other
even if you dont have a usable APIC ?

> It would be nicer to dynamically add the table, e.g. have the bootloader
> load it, kind of like the initrd, but that seems not possible without a
> lot of effort. (Or is the initrd protocol flexible enough to allow for 
> this?)

It may not be enough. The AML can be doing register setup and configuration.
