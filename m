Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263597AbTGOGdS (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Jul 2003 02:33:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263743AbTGOGdS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Jul 2003 02:33:18 -0400
Received: from twilight.ucw.cz ([81.30.235.3]:15750 "EHLO twilight.ucw.cz")
	by vger.kernel.org with ESMTP id S263597AbTGOGdM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Jul 2003 02:33:12 -0400
Date: Tue, 15 Jul 2003 08:47:55 +0200
From: Vojtech Pavlik <vojtech@suse.cz>
To: Pavel Machek <pavel@ucw.cz>
Cc: kernel list <linux-kernel@vger.kernel.org>, vojtech@suse.cz
Subject: Re: Bad autorepeat problems in 2.5.75
Message-ID: <20030715064755.GD27368@ucw.cz>
References: <20030714222249.GA11150@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030714222249.GA11150@elf.ucw.cz>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 15, 2003 at 12:22:51AM +0200, Pavel Machek wrote:

> Hi!
> 
> I have bad problems with autorepeat. When switching consoles with
> alt-left / alt-right it sometimes skips wrong number of consoles, and
> sometimes it just keeps repeating even through I already released a
> key.
> 
> Syslog complains:
> 
> Jul 15 00:15:52 amd kernel: atkbd.c: Unknown key (set 2, scancode
> 0x1cb, on isa0060/serio0) pressed.
> Jul 15 00:16:21 amd kernel: atkbd.c: Unknown key (set 2, scancode
> 0x1cb, on isa0060/serio0) pressed.
> Jul 15 00:19:02 amd kernel: atkbd.c: Unknown key (set 2, scancode
> 0x1cd, on isa0060/serio0) pressed.
> Jul 15 00:20:04 amd kernel: atkbd.c: Unknown key (set 2, scancode
> 0x1cd, on isa0060/serio0) pressed.
> 
> Its vesafb -> switching consoles is not exactly fast, maybe that has
> some role?

Probably keyboard interrupts get lost. Bad. Can you track with DEBUG
enabled in i8042.c?

-- 
Vojtech Pavlik
SuSE Labs, SuSE CR
