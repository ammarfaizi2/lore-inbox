Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265027AbUFGTxU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265027AbUFGTxU (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Jun 2004 15:53:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265028AbUFGTxU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Jun 2004 15:53:20 -0400
Received: from 153.Red-213-4-13.pooles.rima-tde.net ([213.4.13.153]:31242 "EHLO
	kerberos.felipe-alfaro.com") by vger.kernel.org with ESMTP
	id S265027AbUFGTxT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Jun 2004 15:53:19 -0400
Subject: Re: APM realy sucks on 2.6.x
From: Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>
To: Pavel Machek <pavel@ucw.cz>
Cc: Sebastian Kloska <kloska@scienion.de>, linux-kernel@vger.kernel.org
In-Reply-To: <20040607144841.GD1467@elf.ucw.cz>
References: <40C0E91D.9070900@scienion.de>
	 <20040607123839.GC11860@elf.ucw.cz> <40C46F7F.7060703@scienion.de>
	 <20040607140511.GA1467@elf.ucw.cz> <40C47B94.6040408@scienion.de>
	 <20040607144841.GD1467@elf.ucw.cz>
Content-Type: text/plain
Date: Mon, 07 Jun 2004 21:53:20 +0200
Message-Id: <1086638000.2220.8.camel@teapot.felipe-alfaro.com>
Mime-Version: 1.0
X-Mailer: Evolution 1.5.9.1 (1.5.9.1-1) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2004-06-07 at 16:48 +0200, Pavel Machek wrote:

> HP sells compaq nx5000 notebooks with Linux preloaded. Unfortunately
> suspend-to-RAM is not there (IIRC). That's because suspend-to-RAM is
> hard to do with ACPI.

It took some time for me to work, but now ACPI S3 (suspend to RAM) is
finally working for me (I have been trying it since 2.4.22 with no
luck). Only one thing is required before suspending:

# modprobe ds
# cardctl eject

This ejects my CardBus NIC before going to sleep. Not doing so, causes
the system to freeze when resuming.

