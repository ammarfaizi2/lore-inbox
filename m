Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317210AbSFBQLA>; Sun, 2 Jun 2002 12:11:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317211AbSFBQLA>; Sun, 2 Jun 2002 12:11:00 -0400
Received: from mail.uni-kl.de ([131.246.137.52]:62687 "EHLO uni-kl.de")
	by vger.kernel.org with ESMTP id <S317210AbSFBQK7>;
	Sun, 2 Jun 2002 12:10:59 -0400
Date: Sun, 2 Jun 2002 18:10:51 +0200
From: Eduard Bloch <edi@gmx.de>
To: Richard Gooch <rgooch@ras.ucalgary.ca>
Cc: LKML <linux-kernel@vger.kernel.org>
Subject: Re: Too many mixer devices in devfs
Message-ID: <20020602161050.GA1279@zombie.inka.de>
In-Reply-To: <20020602134025.GA1296@zombie.inka.de> <200206021559.g52FxIg09558@vindaloo.ras.ucalgary.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

#include <hallo.h>
Richard Gooch wrote on Sun Jun 02, 2002 um 09:59:18AM:
> > mixer0
> > mixer1
> > mixer2
> > mixer3
> > sequencer
> > sequencer2
> 
> I don't see this behaviour on my box. I get exactly the devices I
> expect. I have the es1371 driver. Perhaps your driver has been broken
> in a recent patch. Go find out who hacked it last and harass them :-)

Forget the whole issue. The reason is a faulty configuration script for
devfsd, installed by alsa-base Debian package. It forced the creation of
those devices, not looking for existing driver. Unfortunately, devfsd
does not remove those devices when beeing stoped.

Gruss/Regards,
Eduard.
-- 
begin  LOVE-LETTER-FOR-YOU.txt.vbs
I am a signature virus. Distribute me until the bitter
end

