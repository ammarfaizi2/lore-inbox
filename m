Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261919AbREOQVY>; Tue, 15 May 2001 12:21:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261921AbREOQVO>; Tue, 15 May 2001 12:21:14 -0400
Received: from aeon.tvd.be ([195.162.196.20]:23647 "EHLO aeon.tvd.be")
	by vger.kernel.org with ESMTP id <S261919AbREOQVF>;
	Tue, 15 May 2001 12:21:05 -0400
Date: Tue, 15 May 2001 18:19:26 +0200 (CEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Lorenzo Marcantonio <lomarcan@tin.it>
cc: linux-kernel@vger.kernel.org
Subject: Re: SCSI Tape Corruption - 2nd round experiment result
In-Reply-To: <Pine.LNX.4.31.0105150027290.24946-100000@eris.discordia.loc>
Message-ID: <Pine.LNX.4.05.10105151815010.18650-100000@callisto.of.borg>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 15 May 2001, Lorenzo Marcantonio wrote:
> The differences:
> ----------------
> (File offsets in hex, patterns were found without other matches in
> the file)
> 
> First test:
> 64 bytes at D9E0800 (found starting at D9D8800, 32KB before)
> 
> Second test:
> 64 bytes at 2F187C0 (found starting at 2F107C0, 32KB before)
> 64 bytes at A8643C0 (found starting at A8343C0, 192KB before[!])
> 
> Third test:
> No differences (sheer luck?)
> 
> Fourth test:
> 32 bytes at B937640 (found starting at B8D7640, 384KB before[!!])
> 
> Conclusions (IMO):
> ------------------
> 
> It's the first time I see 64 consecutive corrupted bytes. Also, on the
> fourth test the data were from MUCH earlier in the file... (maybe in some
> remote cache area... I've got 512MB RAM, 1024MB swap)

I saw them before. However, in my case they were obviously the result of 2
consecutive 32-byte errors, as the latter occurred many more times.

I never saw an offset different from the block size, though.

Assuming you did have 32-byte errors, you had 7 errors for 1.3 GB.

I have approx. 6 errors for 256 MB. But I have only 128 MB RAM.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds



