Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129657AbRB0Riv>; Tue, 27 Feb 2001 12:38:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129675AbRB0Ril>; Tue, 27 Feb 2001 12:38:41 -0500
Received: from neon-gw.transmeta.com ([209.10.217.66]:30733 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S129657AbRB0RiX>; Tue, 27 Feb 2001 12:38:23 -0500
Message-ID: <3A9BE5F3.780B24AE@transmeta.com>
Date: Tue, 27 Feb 2001 09:37:55 -0800
From: "H. Peter Anvin" <hpa@transmeta.com>
Organization: Transmeta Corporation
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.0 i686)
X-Accept-Language: en, sv, no, da, es, fr, ja
MIME-Version: 1.0
To: Mack Stevenson <mackstevenson@hotmail.com>
CC: hpa@zytor.com, linux-kernel@vger.kernel.org
Subject: Re: ISO-8859-1 completeness of kernel fonts?
In-Reply-To: <F110arjrfh6BYVKBLEB00013ccb@hotmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mack Stevenson wrote:
> 
> Anyway, I have already pinned down the source file (in 2.2.18) -
> drivers/video/font_sun12x22.c - and would like to try to change this. Yet it
> seems like the kernel boots using the CP437 charmap, so this would need to
> be modified, too -  I suppose that the relevant file is
> drivers/char/consolemap.c.
> 
> - How can I instruct the kernel to use the ISO-8859-1 character map?
> drivers/char/consolemap.c contains three different translation tables -
> CP437, ISO-8859-1 and VT100 mapped to Unicode -; how can I choose one of
> them?
> 
> - Or shouldn't I even bother about this since in the ASCII range CP437 and
> ISO-8859-1 map to the same characters? May I just boot the kernel using an
> unmatched pair of (CP437) charmap and (ISO-8859-1) font, feeling at ease
> because the kernel won't try to print any non-ASCII characters, and only
> later, in userspace, call loadunimap?
> 
> Am I understanding this correctly?
> 

Not really.

You're much better off designing a larger ISO-8859-1 font and load in in
user space.  You can use the 12x22 font in the kernel as a base.

	-hpa

-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
http://www.zytor.com/~hpa/puzzle.txt
