Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261217AbVBFRLi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261217AbVBFRLi (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Feb 2005 12:11:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261228AbVBFRJz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Feb 2005 12:09:55 -0500
Received: from clock-tower.bc.nu ([81.2.110.250]:17818 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S261217AbVBFRHw
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Feb 2005 12:07:52 -0500
Subject: Re: [RFC] Reliable video POSTing on resume (was: Re: [ACPI]
	Samsung P35, S3, black screen (radeon))
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Pavel Machek <pavel@ucw.cz>
Cc: Jon Smirl <jonsmirl@gmail.com>, ncunningham@linuxmail.org,
       Carl-Daniel Hailfinger <c-d.hailfinger.devel.2005@gmx.net>,
       ACPI List <acpi-devel@lists.sourceforge.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20050205093550.GC1158@elf.ucw.cz>
References: <e796392205020221387d4d8562@mail.gmail.com>
	 <420217DB.709@gmx.net> <4202A972.1070003@gmx.net>
	 <20050203225410.GB1110@elf.ucw.cz>
	 <1107474198.5727.9.camel@desktop.cunninghams> <4202DF7B.2000506@gmx.net>
	 <1107485504.5727.35.camel@desktop.cunninghams>
	 <9e4733910502032318460f2c0c@mail.gmail.com>
	 <20050204074454.GB1086@elf.ucw.cz>
	 <9e473391050204093837bc50d3@mail.gmail.com>
	 <20050205093550.GC1158@elf.ucw.cz>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1107695583.14847.167.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Sun, 06 Feb 2005 16:02:34 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sad, 2005-02-05 at 09:35, Pavel Machek wrote:
> Rumors say that notebooks no longer have video bios at C000h:0; rumors
> say that video BIOS on notebooks is simply integrated into main system
> BIOS. I personaly do not know if rumors are true, but PCs are ugly
> machines....
> 							

A small number of laptop systems are known to pull this trick. There are
other problems too - the video bios boot may make other assumptions
about access to PCI space, configuration, interrupts, timers etc.

Some systems (intel notably) appear to expect you to use the bios
save/restore video state not re-POST.

