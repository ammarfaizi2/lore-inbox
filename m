Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286311AbSAHKvG>; Tue, 8 Jan 2002 05:51:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286239AbSAHKu5>; Tue, 8 Jan 2002 05:50:57 -0500
Received: from gate.perex.cz ([194.212.165.105]:58377 "EHLO gate.perex.cz")
	by vger.kernel.org with ESMTP id <S285630AbSAHKut>;
	Tue, 8 Jan 2002 05:50:49 -0500
Date: Tue, 8 Jan 2002 11:50:03 +0100 (CET)
From: Jaroslav Kysela <perex@suse.cz>
X-X-Sender: <perex@pnote.perex-int.cz>
To: Abramo Bagnara <abramo@alsa-project.org>
cc: Takashi Iwai <tiwai@suse.de>, Linus Torvalds <torvalds@transmeta.com>,
        "J.A. Magallon" <jamagallon@able.es>, Alan Cox <alan@redhat.com>,
        Christoph Hellwig <hch@ns.caldera.de>,
        "sound-hackers@zabbo.net" <sound-hackers@zabbo.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [s-h] Re: ALSA patch for 2.5.2pre9 kernel
In-Reply-To: <3C3ACBC8.E29CE1CB@alsa-project.org>
Message-ID: <Pine.LNX.4.31.0201081142520.482-100000@pnote.perex-int.cz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 8 Jan 2002, Abramo Bagnara wrote:

> Jaroslav Kysela wrote:
> >
> > On Tue, 8 Jan 2002, Takashi Iwai wrote:
> >
> > > Agreed.  The hw specific header files should be bound with *.c code
> > > together.
> >
> > The problem is that we should export some header files to user space as
> > well to allow access to hardware related features.
>
> Don't you think it's better to split this in "external" headers (placed
> in include/sound together with asound.h) and "internal" ones (placed in
> drivers/*/)?
>
> To present kernel space struct layout for specific hardware to user
> space does not seem a lot sensible to me (and might also give some
> errors unless nasty #ifdef __KERNEL__ tricks).

I'm open for all cleanups including this. Although I'm not sure about the
right place for shared internal header files. References including the
directory structure layout (like #include "../../generic/ac97/ac97_codec.h")
are not happiest solution in my eyes and creating a new internal directory
with header files definitely breaks the current linux/include directory
structure.

						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
SuSE Linux    http://www.suse.com
ALSA Project  http://www.alsa-project.org

