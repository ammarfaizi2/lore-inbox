Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129354AbRB1XTp>; Wed, 28 Feb 2001 18:19:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129359AbRB1XT0>; Wed, 28 Feb 2001 18:19:26 -0500
Received: from panic.ohr.gatech.edu ([130.207.47.194]:14758 "HELO
	havoc.gtf.org") by vger.kernel.org with SMTP id <S129354AbRB1XTX>;
	Wed, 28 Feb 2001 18:19:23 -0500
Message-ID: <3A9D8779.BC475CFC@mandrakesoft.com>
Date: Wed, 28 Feb 2001 18:19:21 -0500
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.2 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: whitney@math.berkeley.edu
Cc: LKML <linux-kernel@vger.kernel.org>,
        "William A. Stein" <was@math.harvard.edu>
Subject: Re: via 686a audio driver rate locked at 48Khz
In-Reply-To: <Pine.LNX.4.30.0102280937520.6854-100000@mf1.private>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Wayne Whitney wrote:
> I have a system with an MSI-6321 motherboard with the Via 686a
> southbridge, and I'm having a little trouble with the via82cxxx_audio
> sound driver.  The stock 2.4.2 driver produces only a rhythmic a buzzing
> sound.  I saw a patch here a week or two ago for 'rate locking', so I
> tried that (it didn't apply cleanly to 2.4.2, but I think I applied it by
> hand correctly).

FYI I sent that change to Linus just now, and posted a quick update on
the Web site:  http://sourceforge.net/projects/gkernel/

> That patch makes some things work fine (e.g. playing a .wav file), but
> others sound lousy (e.g. playing a 44.1KHz mp3 with xmms).  Am I correct
> in thinking that it sounds lousy because of the translation from 44.1KHz
> sampling to 48KHz sampling?

Probably..  If you are locked at 48 Khz, -something- has to upsample to
48 Khz if your audio samples are at a different frequency.  Of course
you might also be needing more CPU cycles or memory due to the required
upsampling.

> If so, is there any hope of supporting
> Variable Rate on this hardware?

To be honest I don't know yet.  I haven't fully assured myself that the
driver is doing things 100% correctly to set up variable rate.  There
-are- codecs locked at 48 Khz, so users with those codecs are stuck at
48 Khz..


> Below is copious debugging output, although not the output of
> via-audio-diag, as I could not find it on sourceforge (and the gtf.org URL
> is gone).

It's in the tarball in the download section of
http://sourceforge.net/projects/gkernel/

	Jeff


-- 
Jeff Garzik       | "You see, in this world there's two kinds of
Building 1024     |  people, my friend: Those with loaded guns
MandrakeSoft      |  and those who dig. You dig."  --Blondie
