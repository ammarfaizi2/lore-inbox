Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280027AbRLIAwY>; Sat, 8 Dec 2001 19:52:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280537AbRLIAwO>; Sat, 8 Dec 2001 19:52:14 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:27403 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S280251AbRLIAwJ>; Sat, 8 Dec 2001 19:52:09 -0500
Subject: Re: [PATCH] 2.4.16 kernel/printk.c (per processorinitializationcheck)
To: davidm@hpl.hp.com
Date: Sun, 9 Dec 2001 00:55:25 +0000 (GMT)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox),
        marcelo@conectiva.com.br (Marcelo Tosatti),
        akpm@zip.com.au (Andrew Morton), j-nomura@ce.jp.nec.com,
        linux-kernel@vger.kernel.org
In-Reply-To: <15378.45358.807039.55719@napali.hpl.hp.com> from "David Mosberger" at Dec 08, 2001 04:32:46 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16CsFa-0003KV-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I don't think you can do it early enough.  calibrate_delay() requires
> irqs to be enabled and the first printk() happens long before irqs are
> enabled on an AP.

So we make sure our initial console code doesnt need udelay(), or set an
initial safe default like 25MHz
