Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267097AbTAUOPJ>; Tue, 21 Jan 2003 09:15:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267098AbTAUOPJ>; Tue, 21 Jan 2003 09:15:09 -0500
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:27882 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id <S267097AbTAUOPH>; Tue, 21 Jan 2003 09:15:07 -0500
Date: Tue, 21 Jan 2003 15:24:08 +0100
From: Adrian Bunk <bunk@fs.tum.de>
To: Nuno Monteiro <nuno@itsari.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [BUG/PATCH] OSS/sb_mixer.c is broken on 2.5.59
Message-ID: <20030121142408.GC6870@fs.tum.de>
References: <20030117161752.GC14939@hobbes.itsari.int>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030117161752.GC14939@hobbes.itsari.int>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 17, 2003 at 04:17:52PM +0000, Nuno Monteiro wrote:

> Hi,
> 
> I know OSS is not all that supported, but it has been mostly working for 
> the past 2.5 revisions. However, 2.5.59 broke it. Here is the fix, it 
> allows sound/oss/sb_mixer.c to comple again -- I havent booted it yet, 
> but its trivial enough to spot it from a mile away :)

This file is OK in 2.5.59. Could it be that your editor or another 
program you use broke it?

> Regards,
> 
> 
> 		Nuno

> --- linux-2.5.59/sound/oss/sb_mixer.c.orig	Fri Jan 17 15:40:41 2003
> +++ linux-2.5.59/sound/oss/sb_mixer.c	Fri Jan 17 15:40:55 2003
> @@ -45,7 +45,7 @@
>  					SOUND_MASK_TREBLE|SOUND_MASK_SPEAKER )
>  
>  #define SB16_RECORDING_DEVICES		(SOUND_MASK_SYNTH | \
> -					SOUND_MASK_LINE | \ SOUND_MASK_MIC | \
> +					SOUND_MASK_LINE | SOUND_MASK_MIC | \
>  					SOUND_MASK_CD)
>  
>  #define SB16_OUTFILTER_DEVICES		(SOUND_MASK_LINE | SOUND_MASK_MIC | \
> @@ -55,7 +55,7 @@
>  					SOUND_MASK_SPEAKER | \
>  					SOUND_MASK_LINE | SOUND_MASK_MIC | \
>  					SOUND_MASK_CD | SOUND_MASK_IGAIN | \
> -					SOUND_MASK_OGAIN | \ SOUND_MASK_VOLUME | \
> +					SOUND_MASK_OGAIN | SOUND_MASK_VOLUME | \
>  					SOUND_MASK_BASS | SOUND_MASK_TREBLE | \
>  					SOUND_MASK_IMIX)
>  


cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

