Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129599AbQKBKXm>; Thu, 2 Nov 2000 05:23:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129981AbQKBKXd>; Thu, 2 Nov 2000 05:23:33 -0500
Received: from panic.ohr.gatech.edu ([130.207.47.194]:37637 "EHLO
	havoc.gtf.org") by vger.kernel.org with ESMTP id <S129599AbQKBKXU>;
	Thu, 2 Nov 2000 05:23:20 -0500
Message-ID: <3A01408D.6DBE85F9@mandrakesoft.com>
Date: Thu, 02 Nov 2000 05:23:09 -0500
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.2.18pre18 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Narancs 1 <narancs1@externet.hu>
CC: kraxel@goldbach.in-berlin.de, linux-kernel@vger.kernel.org
Subject: Re: vesafb doesn't work in 240t10?
In-Reply-To: <Pine.LNX.4.02.10011021050140.10126-100000@prins.externet.hu>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Narancs 1 wrote:
> I used to start vesafb like this:
> /etc/lilo.conf:
> vga=317

> I want to start the kernel in 1024x768 16 bit
> How to do it?
> I've read Doc*/fb/vesafb.txt

vga takes a decimal number, but the number in vesafb.txt is
hexidecimal.  Let us convert 0x317 to decimal:

[jgarzik@rum linux_2_4]$ perl -e 'printf "%d\n", 0x317;'
791

So, use "vga=791" in your lilo.conf.

-- 
Jeff Garzik             | Dinner is ready when
Building 1024           | the smoke alarm goes off.
MandrakeSoft            |	-/usr/games/fortune
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
