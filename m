Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264357AbUE3Ubv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264357AbUE3Ubv (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 May 2004 16:31:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264337AbUE3Ubv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 May 2004 16:31:51 -0400
Received: from twilight.ucw.cz ([81.30.235.3]:18304 "EHLO midnight.ucw.cz")
	by vger.kernel.org with ESMTP id S264357AbUE3UbX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 May 2004 16:31:23 -0400
Date: Sun, 30 May 2004 22:31:46 +0200
From: Vojtech Pavlik <vojtech@suse.cz>
To: Giuseppe Bilotta <bilotta78@hotpop.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Fw: Re: keyboard problem with 2.6.6
Message-ID: <20040530203146.GA1941@ucw.cz>
References: <20040529070953.GB850@ucw.cz> <MPG.1b22ab00a1ccd0799896a3@news.gmane.org> <20040529133704.GA6258@ucw.cz> <MPG.1b22c626ab9fcdc79896a5@news.gmane.org> <20040529154443.GA15651@ucw.cz> <MPG.1b23d2eba99fff039896a6@news.gmane.org> <20040530114332.GA1441@ucw.cz> <MPG.1b23f41bee99410e9896a8@news.gmane.org> <20040530125918.GA1611@ucw.cz> <MPG.1b2424ed871e68c89896aa@news.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <MPG.1b2424ed871e68c89896aa@news.gmane.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 30, 2004 at 06:08:39PM +0200, Giuseppe Bilotta wrote:

> > The Linux kernel reports them as KEY_LEFTMETA, KEY_RIGHTMETA and
> > KEY_COMPOSE.
> 
> In X standard keyboards Meta is mapped as the second symbol for 
> Alt.
> 
> // definition for the extra keys on 104-key "Windows95" keyboards
> xkb_symbols "pc104" {
>     include "us(generic101)"
>     key <LALT> {	[ 	Alt_L,	Meta_L		]	};
>     key <RALT> {	[	Alt_R,	Meta_R		]	};
>     key <LWIN> {	[	Super_L			]	};
>     key <RWIN> {	[	Super_R			]	};
>     key <MENU> {	[	Menu			]	};
> 
>     // modifier mappings
>     modifier_map Mod1   { Alt_L, Alt_R, Meta_L, Meta_R };
>     modifier_map Mod4   { Super_L, Super_R };
> }; 
> 
> // definition of Euro-style, Right "logo" key == [Mode_switch, Multi_key]
> xkb_symbols "pc104euro" {
>     include "us(pc104)"
>     key <RALT> {        [       Mode_switch             ]       
> };
>     key <RWIN> {	[	Multi_key		]	};
> };

Interesting. Nevertheless it's just a naming difference, and thus
shouldn't be a problem.

> > I'm not very familiar with xkb configuration. Perhaps you'd be willing
> > to write that definition file? I'll certainly help you from the kernel
> > side - I can even generate a list of keycode - scancode - meaning
> > relations for you.
> 
> If you do generate a list of keycode - scancode - meaning pairs 
> it will surely make my life easier.
> 
> I'm not particularly familiar with xkb configuration either. I 
> can *probably* make it work (i.e. test it as functional) on my 
> Dell Inspiron 8200 keyboard and on a standard pc104 keyboard 
> only. You probably need somebody else to work out the details 
> for other keyboards, though.

Ok, I'll try to produce something.

-- 
Vojtech Pavlik
SuSE Labs, SuSE CR
