Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313173AbSDOTEq>; Mon, 15 Apr 2002 15:04:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313174AbSDOTEq>; Mon, 15 Apr 2002 15:04:46 -0400
Received: from www.transvirtual.com ([206.14.214.140]:38411 "EHLO
	www.transvirtual.com") by vger.kernel.org with ESMTP
	id <S313173AbSDOTEp>; Mon, 15 Apr 2002 15:04:45 -0400
Date: Mon, 15 Apr 2002 12:04:26 -0700 (PDT)
From: James Simmons <jsimmons@transvirtual.com>
To: tomas szepe <kala@pinerecords.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: 2.5.7 keyboard problem
In-Reply-To: <Pine.LNX.4.44.0204151839560.6489-100000@louise.pinerecords.com>
Message-ID: <Pine.LNX.4.10.10204151202400.1204-100000@www.transvirtual.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> > I saw that already,
> > Here is a snippet from my .config
> 
> Jup, I've got to confirm this: PS/2 keyboards won't work on my
> VIA KT133A-based board on both 2.5.8 vanilla and -dj2/3.
> (no, not even IBM Model M. :D)
> 
> an excerpt from the 2.5.8 .config in question:
> .
> .
> CONFIG_INPUT=y
> CONFIG_INPUT_KEYBDEV=y
> CONFIG_INPUT_MOUSEDEV=y
> .
> .
> CONFIG_SERIO=y
> CONFIG_SERIO_SERPORT=y

Wrong config for DJ tree. Here is what you need for PS/2 input keyboard
support.

CONFIG_SERIO=y
CONFIG_SERIO_I8042=y
CONFIG_I8042_REG_BASE=60
CONFIG_I8042_KBD_IRQ=1
CONFIG_I8042_AUX_IRQ=12

Also don't forget 

CONFIG_INPUT_KEYBOARD=y
CONFIG_KEYBOARD_ATKBD=y

CONFIG_INPUT_MOUSE=y
CONFIG_MOUSE_PS2=y

