Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291539AbSBSSEa>; Tue, 19 Feb 2002 13:04:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291558AbSBSSEV>; Tue, 19 Feb 2002 13:04:21 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:29189 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S291539AbSBSSEQ>; Tue, 19 Feb 2002 13:04:16 -0500
Date: Tue, 19 Feb 2002 10:02:46 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Jakob Kemi <jakob.kemi@telia.com>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] hex <-> int conversion routines.
In-Reply-To: <02021915240900.00635@jakob>
Message-ID: <Pine.LNX.4.33.0202191000340.26476-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 19 Feb 2002, Jakob Kemi wrote:
>
> I also added three other hex-functions that can replace a lot of duplicated code.
>
> int  hexint_nibble (char x);		// hex digit to int.
> int  hexint_byte   (const char *src);	// hex digit-pair to int.
> char inthex_nibble (int x);		// int to hex digit.
> void inthex_byte   (int x, char* dest);	// int to hex digit pair.

Is there any reason to do all of this?

I suspect 99% of all users can (and probably should) be replaced with
"sscanf()" instead. Which does a lot more, of course, and is not the
fastest thing out there due to that, but anybody who does hex->int
conversion inside some critical loop is just crazy.

		Linus

