Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263758AbTLPGe1 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Dec 2003 01:34:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264364AbTLPGe1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Dec 2003 01:34:27 -0500
Received: from fw.osdl.org ([65.172.181.6]:44975 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263758AbTLPGe0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Dec 2003 01:34:26 -0500
Date: Mon, 15 Dec 2003 22:34:38 -0800
From: Andrew Morton <akpm@osdl.org>
To: Pavel Machek <pavel@ucw.cz>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6 kgdb without serial port
Message-Id: <20031215223438.196295a8.akpm@osdl.org>
In-Reply-To: <20031215200640.GA3724@elf.ucw.cz>
References: <20031215200640.GA3724@elf.ucw.cz>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pavel Machek <pavel@ucw.cz> wrote:
>
> Hi!
> 
> 2.6 kgdb patches in -mm tree seem to contain kgdb-over-ethernet stuff,
> but still require me to fill in serial port interrupt/address. Is
> there easy way to make it work without serial port? [This notebook has
> none :-(].

That's a bit ugly, but things should still work OK?  Give it some random
UART address but specify an ethernet connection at boot time - the kgdb
stub should never touch the UART.

