Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267039AbTAKETe>; Fri, 10 Jan 2003 23:19:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267041AbTAKETe>; Fri, 10 Jan 2003 23:19:34 -0500
Received: from ns.suse.de ([213.95.15.193]:57616 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id <S267039AbTAKETd>;
	Fri, 10 Jan 2003 23:19:33 -0500
Date: Sat, 11 Jan 2003 05:28:18 +0100
From: Andi Kleen <ak@suse.de>
To: "Randy.Dunlap" <rddunlap@osdl.org>, Andi Kleen <ak@suse.de>
Cc: Valdis.Kletnieks@vt.edu, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.5] speedup kallsyms_lookup
Message-ID: <20030111042818.GB10699@wotan.suse.de>
References: <20030110171950.GA6064@wotan.suse.de> <Pine.LNX.4.33L2.0301101055030.19536-100000@dragon.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.33L2.0301101055030.19536-100000@dragon.pdx.osdl.net>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Ctrl-ScrollLock on mine if I'm following you correctly.
> Same as Sysrq-P if sysrq is enabled, except that the former
> is always available.

Try Ctrl-,Alt/AltGr-,Shift- with the same key.
> 
> Are there other similar functions that are available without
> Sysrq enabled?  If so, where can I find info about them?

Quite a lot.

In your keymap. e.g. on a SuSE system.

getkeycodes will output a map of the key codes.

% less /usr/share/kbd/keymaps/i386/include/linux-keys-bare.inc 

alt keycode  59 = Console_1
alt keycode  60 = Console_2
...
control alt keycode  59 = Console_1
control alt keycode  60 = Console_2
...
alt keycode  71 = Ascii_7
alt keycode  72 = Ascii_8
...
alt keycode 103 = KeyboardSignal
alt keycode 105 = Decr_Console
alt keycode 106 = Incr_Console
...
shift keycode 104 = Scroll_Backward
shift keycode 109 = Scroll_Forward
control alt keycode 111 = Boot
...
keycode  84 = Last_Console              # Alt+SysRq/PrintScrn
#keycode  99 = Control_backslash                # SysRq/PrintScrn
keycode  99 = VoidSymbol
control keycode  99 = Control_backslash

plain   keycode 70 = Scroll_Lock
shift   keycode 70 = Show_Memory
control keycode 70 = Show_State
alt     keycode 70 = Show_Registers
keycode 101 = Break                     # Ctrl+Break/Pause
control keycode 101 = Control_c
shift   keycode 101 = Control_backslash
keycode 119 = Pause                     # Break/Pause




-Andi
