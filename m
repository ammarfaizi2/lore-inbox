Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750945AbWJ0XAH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750945AbWJ0XAH (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Oct 2006 19:00:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750953AbWJ0XAH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Oct 2006 19:00:07 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:56254 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1750945AbWJ0XAF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Oct 2006 19:00:05 -0400
Subject: Re: [patch] drivers: wait for threaded probes between initcall
	levels
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Andrew Morton <akpm@osdl.org>
Cc: Pavel Machek <pavel@ucw.cz>, Greg KH <greg@kroah.com>,
       Stephen Hemminger <shemminger@osdl.org>,
       Matthew Wilcox <matthew@wil.cx>, Adrian Bunk <bunk@stusta.de>,
       Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-pci@atrey.karlin.mff.cuni.cz
In-Reply-To: <20061027114237.d577c153.akpm@osdl.org>
References: <Pine.LNX.4.64.0610231618510.3962@g5.osdl.org>
	 <20061026224541.GQ27968@stusta.de> <20061027010252.GV27968@stusta.de>
	 <20061027012058.GH5591@parisc-linux.org>
	 <20061026182838.ac2c7e20.akpm@osdl.org>
	 <20061026191131.003f141d@localhost.localdomain>
	 <20061027170748.GA9020@kroah.com> <20061027172219.GC30416@elf.ucw.cz>
	 <20061027113908.4a82c28a.akpm@osdl.org>
	 <20061027114144.f8a5addc.akpm@osdl.org>
	 <20061027114237.d577c153.akpm@osdl.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Fri, 27 Oct 2006 23:59:30 +0100
Message-Id: <1161989970.16839.45.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ar Gwe, 2006-10-27 am 11:42 -0700, ysgrifennodd Andrew Morton:
> IOW, we want to be multithreaded _within_ an initcall level, but not between
> different levels.

Thats actually insufficient. We have link ordered init sequences in
large numbers of driver subtrees (ATA, watchdog, etc). We'll need
several more initcall layers to fix that.

Alan

