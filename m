Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285618AbSAHKiO>; Tue, 8 Jan 2002 05:38:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285630AbSAHKiE>; Tue, 8 Jan 2002 05:38:04 -0500
Received: from smtp3.libero.it ([193.70.192.53]:13254 "EHLO smtp3.libero.it")
	by vger.kernel.org with ESMTP id <S285618AbSAHKh7>;
	Tue, 8 Jan 2002 05:37:59 -0500
Message-ID: <3C3ACBC8.E29CE1CB@alsa-project.org>
Date: Tue, 08 Jan 2002 11:36:56 +0100
From: Abramo Bagnara <abramo@alsa-project.org>
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.4.17 i586)
X-Accept-Language: en, it
MIME-Version: 1.0
To: Jaroslav Kysela <perex@suse.cz>
Cc: Takashi Iwai <tiwai@suse.de>, Linus Torvalds <torvalds@transmeta.com>,
        "J.A. Magallon" <jamagallon@able.es>, Alan Cox <alan@redhat.com>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Christoph Hellwig <hch@ns.caldera.de>,
        "sound-hackers@zabbo.net" <sound-hackers@zabbo.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [s-h] Re: ALSA patch for 2.5.2pre9 kernel
In-Reply-To: <Pine.LNX.4.31.0201081116300.482-100000@pnote.perex-int.cz>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jaroslav Kysela wrote:
> 
> On Tue, 8 Jan 2002, Takashi Iwai wrote:
> 
> > Agreed.  The hw specific header files should be bound with *.c code
> > together.
> 
> The problem is that we should export some header files to user space as
> well to allow access to hardware related features.

Don't you think it's better to split this in "external" headers (placed
in include/sound together with asound.h) and "internal" ones (placed in
drivers/*/)?

To present kernel space struct layout for specific hardware to user
space does not seem a lot sensible to me (and might also give some
errors unless nasty #ifdef __KERNEL__ tricks).

-- 
Abramo Bagnara                       mailto:abramo@alsa-project.org

Opera Unica                          Phone: +39.546.656023
Via Emilia Interna, 140
48014 Castel Bolognese (RA) - Italy

ALSA project               http://www.alsa-project.org
It sounds good!
