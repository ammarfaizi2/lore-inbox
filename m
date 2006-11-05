Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161441AbWKESRd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161441AbWKESRd (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Nov 2006 13:17:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161438AbWKESRd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Nov 2006 13:17:33 -0500
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:45705 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1161441AbWKESRc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Nov 2006 13:17:32 -0500
Subject: Re: sc3200 cpu + apm module kernel crash
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Nicolas FR <nicolasfr@gmail.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <b9481e140611031506u42e326dbs5c0e97d14c5fb5b3@mail.gmail.com>
References: <b9481e140611031506u42e326dbs5c0e97d14c5fb5b3@mail.gmail.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Sun, 05 Nov 2006 18:21:57 +0000
Message-Id: <1162750917.31873.38.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ar Sad, 2006-11-04 am 00:06 +0100, ysgrifennodd Nicolas FR:
> I have thrown a bunch of  "printk(KERN_INFO "apm: I am here\n");" and
> noticed the crash is happening just when calling apm_event_handler();
> and does not even execute any instruction in this function... This is
> the point I don't understand, how can it crash just on calling a
> function and not executing the first statement in this function?

APM is BIOS code so the assembler inlines trap into the firmware and the
firmware sometimes isn't very good, particularly the 32bit entry points
which are not used by a certain other vendors products.

In those cases you need to trace the asm code in the firmware and see if
the firmware is buggy.

