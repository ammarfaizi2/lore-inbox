Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267341AbSLKWcB>; Wed, 11 Dec 2002 17:32:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267344AbSLKWcB>; Wed, 11 Dec 2002 17:32:01 -0500
Received: from [195.39.17.254] ([195.39.17.254]:6404 "EHLO Elf.ucw.cz")
	by vger.kernel.org with ESMTP id <S267341AbSLKWb7>;
	Wed, 11 Dec 2002 17:31:59 -0500
Date: Tue, 10 Dec 2002 22:34:44 +0100
From: Pavel Machek <pavel@ucw.cz>
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: PATCH: Four function buttons on DELL Latitude X200
Message-ID: <20021210213444.GA451@elf.ucw.cz>
References: <m3d6ocjd81.fsf@Janik.cz> <E18LBeK-00046y-00@calista.inka.de> <at2r5v$fib$1@cesium.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <at2r5v$fib$1@cesium.transmeta.com>
User-Agent: Mutt/1.4i
X-Warning: Reading this can be dangerous to your mental health.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > In article <m3d6ocjd81.fsf@Janik.cz> you wrote:
> > > this patch add support for four functions key on DELL Latitude X200.
> > 
> > we need a more generic appoach to handle those key codes for various
> > extensions. I think a pure software reconfiguration of the keymaps or a
> > daemon trakcing the raw codes is fine. Perhaps we can make something like a
> > hook into the kernel where all untrapped function keys are send to in raw
> > format?
> > 
> 
> The PC only has so many possible keycodes (with E0 and E1 it's still
> in the sub-300 range.)  It won't fit within 128, but I would really
> like an algorithmic mapping from scancodes to keycodes so we don't
> continue to have this problem.
> 
> For example, using a 16-bit keycode model:
> 
> 
> 	Scancode		Keycode (binary)
> 	mxxxxxxx	 	m0000000 0xxxxxxx
> 	E0 mxxxxxxx		m0000000 1xxxxxxx
> 	E1 mxxxxxxx yyyyyyyy	mxxxxxxx yyyyyyyy
> 
> m = make/break bit

Well, nothing prevents keyboard manufacturers from using 0xe2 as a
prefix, too. I think there are really *weird* keyboards out there.

								Pavel
-- 
Worst form of spam? Adding advertisment signatures ala sourceforge.net.
What goes next? Inserting advertisment *into* email?
