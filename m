Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267384AbSLLAxh>; Wed, 11 Dec 2002 19:53:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267388AbSLLAxh>; Wed, 11 Dec 2002 19:53:37 -0500
Received: from kweetal.tue.nl ([131.155.2.7]:45194 "EHLO kweetal.tue.nl")
	by vger.kernel.org with ESMTP id <S267384AbSLLAxg>;
	Wed, 11 Dec 2002 19:53:36 -0500
Date: Thu, 12 Dec 2002 02:01:16 +0100
From: Andries Brouwer <aebr@win.tue.nl>
To: Pavel Machek <pavel@ucw.cz>
Cc: "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org
Subject: Re: PATCH: Four function buttons on DELL Latitude X200
Message-ID: <20021212010116.GA10297@win.tue.nl>
References: <m3d6ocjd81.fsf@Janik.cz> <E18LBeK-00046y-00@calista.inka.de> <at2r5v$fib$1@cesium.transmeta.com> <20021210213444.GA451@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021210213444.GA451@elf.ucw.cz>
User-Agent: Mutt/1.3.25i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 10, 2002 at 10:34:44PM +0100, Pavel Machek wrote:

> > The PC only has so many possible keycodes (with E0 and E1 it's still
> > in the sub-300 range.)  It won't fit within 128, but I would really
> > like an algorithmic mapping from scancodes to keycodes so we don't
> > continue to have this problem.
> > 
> > For example, using a 16-bit keycode model:
> > 
> > 
> > 	Scancode		Keycode (binary)
> > 	mxxxxxxx	 	m0000000 0xxxxxxx
> > 	E0 mxxxxxxx		m0000000 1xxxxxxx
> > 	E1 mxxxxxxx yyyyyyyy	mxxxxxxx yyyyyyyy
> > 
> > m = make/break bit
> 
> Well, nothing prevents keyboard manufacturers from using 0xe2 as a
> prefix, too. I think there are really *weird* keyboards out there.
> 
> 								Pavel

Indeed. See, for example,

	http://www.win.tue.nl/~aeb/linux/kbd/scancodes-2.html#ss2.18

for a keyboard that uses 0x80 as a prefix.
