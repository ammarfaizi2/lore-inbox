Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132261AbRCZA2m>; Sun, 25 Mar 2001 19:28:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132260AbRCZA2c>; Sun, 25 Mar 2001 19:28:32 -0500
Received: from zada.math.leidenuniv.nl ([132.229.231.3]:58125 "EHLO
	zada.math.leidenuniv.nl") by vger.kernel.org with ESMTP
	id <S132257AbRCZA2W>; Sun, 25 Mar 2001 19:28:22 -0500
Date: Mon, 26 Mar 2001 02:27:39 +0200 (MEST)
From: Lennert Buytenhek <buytenh@math.leidenuniv.nl>
To: James Stevenson <mistral@stev.org>
cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: question on /dev/tap0
In-Reply-To: <Pine.LNX.4.21.0103252255170.12913-100000@cyrix.home>
Message-ID: <Pine.LNX.4.30.0103260226440.1589-100000@mara.math.leidenuniv.nl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Intended behaviour. This is because of the access checks done in the
netlink code. Misleading, yes.


On Sun, 25 Mar 2001, James Stevenson wrote:

>
> Hi
>
> would somebody be able to explain to me
> when you try to open /dev/tap0 which is a
> character device file which has the permissions
>
> File: "tap0"
> Size: 0            Filetype: Character Device
> Mode: (0666/crw-rw-rw-)
>
> when tried to open
>
> [mistral@linux /dev]$ cat tap0
> cat: tap0: Operation not permitted
>
> and strace shows that it gets a permission error
> open("tap0", O_RDONLY|0x8000)           = -1 EPERM
>
> is it just me or is this either
> a) a bug
> b) very misleading
>
> thanks
> 	James
>
>


