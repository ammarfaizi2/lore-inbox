Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264909AbRFUJgv>; Thu, 21 Jun 2001 05:36:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264910AbRFUJgl>; Thu, 21 Jun 2001 05:36:41 -0400
Received: from hood.tvd.be ([195.162.196.21]:12995 "EHLO hood.tvd.be")
	by vger.kernel.org with ESMTP id <S264909AbRFUJgh>;
	Thu, 21 Jun 2001 05:36:37 -0400
Date: Thu, 21 Jun 2001 11:33:40 +0200 (CEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Lorenzo Marcantonio <lomarcan@tin.it>
cc: Rob Turk <r.turk@chello.nl>, linux-kernel@vger.kernel.org
Subject: Re: SCSI Tape corruption - update
In-Reply-To: <Pine.LNX.4.05.10105080904010.24912-100000@callisto.of.borg>
Message-ID: <Pine.LNX.4.05.10106211122180.1260-100000@callisto.of.borg>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 8 May 2001, Geert Uytterhoeven wrote:
> On Mon, 7 May 2001, Lorenzo Marcantonio wrote:
> > On Mon, 7 May 2001, Rob Turk wrote:
> > > Have you ruled out hardware failures? There's been a few isolated reports
> > 
> > That tape drive (Sony SDT-9000, less than 2 years of service) works
> > perfectly on Windows NT (were it was before) and even on Linux 2.2
> > 
> > Also the cartridge was brand new.
> 
> In the mean time I down/upgraded to 2.2.17 on my PPC box (CHRP LongTrail,
> Sym53c875, HP C5136A  DDS1) and I can confirm that the problem does not happen
> under 2.2.17 neither.
> 
> My experiences:
>   - reading works fine, writing doesn't
>   - 2.2.x works fine, 2.4.x doesn't (at least since 2.4.0-test1-ac10)
>   - hardware compression doesn't matter
>   - I have a sym53c875, Lorenzo has an Adaptec, so most likely it's not a
>     SCSI hardware driver bug
>   - I have a PPC, Lorenzo doesn't, so it's not CPU-specific
>   - corruption is always a block of 32 bytes being replaced by 32 bytes from
>     the previous tape block (depending on block size!) (approx. 6 errors per
>     256 MB)
> 
> Lorenzo, can you please investigate the exact nature of the corruption on your
> system?
>   - How many successive bytes are corrupted?
>   - Where do the corrupted data come from?

Yesterday I noticed the same corruption under 2.2.19 (yes, I run amverify after
backing up my system now, so it detects corruption through the gzip CRCs).

I'll do some more tests (when I find time) to get a higher statistical
certainty that it really doesn't happen under earlier 2.2.x kernels.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds

