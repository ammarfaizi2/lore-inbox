Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290509AbSAQWho>; Thu, 17 Jan 2002 17:37:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290502AbSAQWhh>; Thu, 17 Jan 2002 17:37:37 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:61445 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S290509AbSAQWg0>; Thu, 17 Jan 2002 17:36:26 -0500
Date: Thu, 17 Jan 2002 14:35:30 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Dave Jones <davej@suse.de>
cc: Jes Sorensen <jes@wildopensource.com>,
        Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>, <linux-kernel@vger.kernel.org>,
        Marcelo Tosatti <marcelo@conectiva.com.br>
Subject: Re: [patch] VAIO irq assignment fix
In-Reply-To: <Pine.LNX.4.33.0201171804510.23659-100000@Appserv.suse.de>
Message-ID: <Pine.LNX.4.33.0201171433260.3114-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 17 Jan 2002, Dave Jones wrote:
>
> Your patch is also useful for the case of CONFIG_ACPI=n
> Worth keeping for that alone.

No. Could we please integrate this not with ACPI, but with the much more
limited "arch/i386/kernel/acpitable.c", which does NOT imply full ACPI,
only scanning the tables for information in static format (like the irq
routing stuff).

That we can/will/should always enable, and we should NOT EVER encourage
this kind of "per-BIOS" crud. That just becomes a total horror to maintain
in the long run.

Please?

		Linus

