Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269969AbTGZVhr (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 26 Jul 2003 17:37:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270329AbTGZVhr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 26 Jul 2003 17:37:47 -0400
Received: from cs180094.pp.htv.fi ([213.243.180.94]:57216 "EHLO
	hades.pp.htv.fi") by vger.kernel.org with ESMTP id S269969AbTGZVhq
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 26 Jul 2003 17:37:46 -0400
Subject: Re: 2.6.0-test1: irq18 nobody cared! on Intel D865PERL motherboard
From: Mika Liljeberg <mika.liljeberg@welho.com>
To: Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20030714131240.21759.qmail@linuxmail.org>
References: <20030714131240.21759.qmail@linuxmail.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1059256372.8484.9.camel@hades>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.3 
Date: 27 Jul 2003 00:52:52 +0300
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2003-07-14 at 16:12, Felipe Alfaro Solana wrote:
> I'm having problems with an Intel D865PERL motherboard and Serial ATA
> support. Everytime I boot my RHL9 box using 2.6.0-test1, I get an
> "irq18 nobody cared!" error and then "Disabling IRQ #18". Any attempt
> to access any of the SATA controllers makes the system hang and
> spitting out problems with timings on the "hde" interface.

I have the same problem with Abit IS7-E, which also has the i865PE
chipset.

Add "noirqdebug" to the kernel command line and you should be able to
boot, although the irq will be firing continously until the device
driver gets initialized and catches it.

	MikaL

