Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129625AbQLBH6x>; Sat, 2 Dec 2000 02:58:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129729AbQLBH6n>; Sat, 2 Dec 2000 02:58:43 -0500
Received: from neon-gw.transmeta.com ([209.10.217.66]:33042 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S129625AbQLBH6c>; Sat, 2 Dec 2000 02:58:32 -0500
To: linux-kernel@vger.kernel.org
From: torvalds@transmeta.com (Linus Torvalds)
Subject: Re: Transmeta and Linux-2.4.0-test12-pre3
Date: 1 Dec 2000 23:27:52 -0800
Organization: Transmeta Corporation
Message-ID: <90a89o$5j7$1@penguin.transmeta.com>
In-Reply-To: <200012020409.UAA04058@adam.yggdrasil.com> <90a065$5ai$1@penguin.transmeta.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <90a065$5ai$1@penguin.transmeta.com>,
Linus Torvalds <torvalds@transmeta.com> wrote:
>
>Anyway, I do have this machine working now, although not everything is
>to my liking.  Unlike older picture-books, for example, this one has a
>WinModem.  Ugh.  And the sound chip is supported, but only by the ALSA
>driver (the OSS version is too broken to be used). 

Oh - another detail: do _not_ get the latest ALSA driver: 0.5.9d is
apparently broken, while 0.5.8a works fine once you fix the MAP_NR()
issue (ie use "struct page *page = virt_to_page(addr)" instead of using
"int nr = MAP_NR(addr)", and do the arithmetic on "struct page" pointers
instead of ints. 

		Linus
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
