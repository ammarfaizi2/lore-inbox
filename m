Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135219AbRDRRKD>; Wed, 18 Apr 2001 13:10:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S133087AbRDRRJy>; Wed, 18 Apr 2001 13:09:54 -0400
Received: from neon-gw.transmeta.com ([209.10.217.66]:37644 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S135220AbRDRRJn>; Wed, 18 Apr 2001 13:09:43 -0400
Date: Tue, 17 Apr 2001 14:46:09 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Pavel Machek <pavel@suse.cz>
cc: kernel list <linux-kernel@vger.kernel.org>
Subject: Re: i386 cleanups
In-Reply-To: <20010417232614.A4377@bug.ucw.cz>
Message-ID: <Pine.LNX.4.31.0104171443060.1029-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 17 Apr 2001, Pavel Machek wrote:
>
> These are tiny cleanups you might like. sizes are "logically"
> long.

No. Sizes are not "logical". They are whatever you decide they are, ie
it's purely a complier convention.

At least earlier, size_t was defined as "unsigned int" in user mode, and
doing anything else would make gcc complain about clashes with its
compiled-in __builtin_size_t that it uses for the builtin prototypes (ie
if you had a declaration for "void *memcpy(void *dest, const void *src,
size_t n);" and your size_t didn't match the gcc builtin_size_t, you'd get
a "redefined with different arguments" warning or something).

		Linus

