Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132500AbRDNRng>; Sat, 14 Apr 2001 13:43:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132496AbRDNRn0>; Sat, 14 Apr 2001 13:43:26 -0400
Received: from hood.tvd.be ([195.162.196.21]:62326 "EHLO hood.tvd.be")
	by vger.kernel.org with ESMTP id <S132497AbRDNRnM>;
	Sat, 14 Apr 2001 13:43:12 -0400
Date: Sat, 14 Apr 2001 19:42:09 +0200 (CEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Marc SCHAEFER <schaefer@alphanet.ch>
cc: Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: Re: SCSI tape corruption problem
In-Reply-To: <200104140823.KAA30162@vulcan.alphanet.ch>
Message-ID: <Pine.LNX.4.05.10104141940320.12788-100000@callisto.of.borg>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 14 Apr 2001, Marc SCHAEFER wrote:
> Now try this:
> 
>    cd ~archive
>    mt -f /dev/tapes/tape0 rewind
>    tar cvf - . | gzip -9 | dd of=/dev/tapes/tape0 bs=32k
> 
> and then:
> 
>    mt -f /dev/tapes/tape0 rewind
>    dd if=/dev/tapes/tape0 bs=32k | gzip -d | tar --compare -v -f -
> 
> The above is the proper way to talk to a tape drive through gzip.

So you make gzip use blocks of 32 kB.

Do you also mean it is illegal to use blocksize 10 kB (default tar, no gzip)
with a tape drive??

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds



