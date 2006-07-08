Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964902AbWGHQru@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964902AbWGHQru (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 8 Jul 2006 12:47:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964901AbWGHQru
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 8 Jul 2006 12:47:50 -0400
Received: from smtp.osdl.org ([65.172.181.4]:30145 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S964902AbWGHQrt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 8 Jul 2006 12:47:49 -0400
Date: Sat, 8 Jul 2006 09:47:46 -0700
From: Andrew Morton <akpm@osdl.org>
To: Pavel Machek <pavel@ucw.cz>
Cc: linux-kernel@vger.kernel.org
Subject: Re: pcmcia IDE broken in 2.6.18-rc1
Message-Id: <20060708094746.943d8926.akpm@osdl.org>
In-Reply-To: <20060708145541.GA2079@elf.ucw.cz>
References: <20060708145541.GA2079@elf.ucw.cz>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.17; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 8 Jul 2006 16:55:43 +0200
Pavel Machek <pavel@ucw.cz> wrote:

> Hi!
> 
> When I insert the card, I get
> 
> pccard: PCMCIA card inserted into slot 0
> cs: memory probe 0xe8000000-0xefffffff: excluding
> 0xe8000000-0xefffffff
> cs: memory probe 0xc0200000-0xcfffffff: excluding
> 0xc0200000-0xc11fffff 0xc1a00000-0xc61fffff 0xc6a00000-0xc71fffff
> 0xc7a00000-0xc81fffff 0xc8a00000-0xc91fffff 0xc9a00000-0xca1fffff
> 0xcaa00000-0xcb1fffff 0xcba00000-0xcc1fffff 0xcca00000-0xcd1fffff
> 0xcda00000-0xce1fffff 0xcea00000-0xcf1fffff 0xcfa00000-0xd01fffff
> pcmcia: registering new device pcmcia0.0
> PM: Adding info for pcmcia:0.0
> ide2: I/O resource 0xF887E00E-0xF887E00E not free.
> ide2: ports already in use, skipping probe
> ide2: I/O resource 0xF887E01E-0xF887E01E not free.
> ide2: ports already in use, skipping probe
> ...
> 
> it ends with
> 
> ide-cs: ide_register() at 0xf999c000 & 0xf999c00e, irq 7 failed
> 
> :-(. Back to 2.6.17 once again, I'm afraid...

Appears to be the same bug as http://lkml.org/lkml/2006/6/15/155

That debugging effort dried up at "Can you do some more tracing on hwif."

You're our only hope.  Can you debug it a bit please?
