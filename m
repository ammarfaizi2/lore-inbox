Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289822AbSBKPcN>; Mon, 11 Feb 2002 10:32:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289823AbSBKPcD>; Mon, 11 Feb 2002 10:32:03 -0500
Received: from [195.89.159.99] ([195.89.159.99]:59122 "EHLO
	kushida.apsleyroad.org") by vger.kernel.org with ESMTP
	id <S289822AbSBKPbu>; Mon, 11 Feb 2002 10:31:50 -0500
Date: Mon, 11 Feb 2002 15:26:55 +0000
From: Jamie Lokier <lk@tantalophile.demon.co.uk>
To: Andrew Morton <akpm@zip.com.au>
Cc: Linus Torvalds <torvalds@transmeta.com>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>, Hugh Dickins <hugh@veritas.com>,
        Marcelo Tosatti <marcelo@conectiva.com.br>,
        "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] BUG preserve registers
Message-ID: <20020211152655.A7564@kushida.apsleyroad.org>
In-Reply-To: <3C65F523.FDDB7FA@zip.com.au> <Pine.LNX.4.33.0202092211001.10024-100000@home.transmeta.com> <3C660517.AAA7FA8@zip.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <3C660517.AAA7FA8@zip.com.au>; from akpm@zip.com.au on Sat, Feb 09, 2002 at 09:28:55PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> The preprocessor is simply pasting together its -I argument and the
> string from the #include statement.  There doesn't seem to be a way
> of getting it to just emit "include/linux/dcache.h" or "drivers/char/serial.c".

Doesn't that work if you do this?

   (cd $(TOPDIR);
    gcc -Idrivers/char -I- -Iinclude \
        -c -o drivers/char/serial.o drivers/char/serial.c)

-- Jamie
