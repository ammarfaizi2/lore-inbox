Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281267AbRKPJyv>; Fri, 16 Nov 2001 04:54:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281264AbRKPJyl>; Fri, 16 Nov 2001 04:54:41 -0500
Received: from [62.245.135.174] ([62.245.135.174]:1665 "EHLO mail.teraport.de")
	by vger.kernel.org with ESMTP id <S281265AbRKPJy2>;
	Fri, 16 Nov 2001 04:54:28 -0500
Message-ID: <3BF4E24D.2E7567A7@TeraPort.de>
Date: Fri, 16 Nov 2001 10:54:21 +0100
From: Martin Knoblauch <Martin.Knoblauch@TeraPort.de>
Organization: TeraPort GmbH
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.4.13-ac4 i686)
X-Accept-Language: en, de
MIME-Version: 1.0
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: akpm@zip.com.au
Subject: Re: Insanely high "Cached" value
X-MIMETrack: Itemize by SMTP Server on lotus/Teraport/de(Release 5.0.7 |March 21, 2001) at
 11/16/2001 10:54:20 AM,
	Serialize by Router on lotus/Teraport/de(Release 5.0.7 |March 21, 2001) at
 11/16/2001 10:54:28 AM,
	Serialize complete at 11/16/2001 10:54:28 AM
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Re: Insanely high "Cached" value
> 
> From: Andrew Morton (akpm@zip.com.au)
> Date: Sat Nov 10 2001 - 00:17:01 EST
> 
> 
> Steven Walter wrote:
> >
> > My system has been running a little over twelve days now, and I just
> > noticed that the "Cached" value in both 'free' and /proc/meminfo is
> > insanely high. This wasn't the case the last time I checked, which was
> > probably a day ago.
> >
> > Just before checking it this time, I ran a "du -s *" in /usr, which
> > generated a lot of I/O, as it to be expected. Perhaps the large amount
> > of I/O has uncovered a bug of some sort?
> >
> > This is kernel 2.4.13 (hopefully it's not something that's already been
> > reported and fixed; I haven't seen it if is has) patched with ext3, kdb,
> > lm_sensors, and the pre-empt patch. Seems likely to be only a simple VM
> > problem, however, and an asthetic one at that.
> 
> It's an ext3 bug. Harmless, fixed in the (ext3-enriched) 2.4.15-pre2.
> 

 Hmm. Are you sure it is ext3 only? I see the same (coming and going, no
real harm) on 2.4.13-ac4+preempt without having EXT3 enabled. Also
happens with 2.4.13 plain.

# CONFIG_EXT3_FS is not set
CONFIG_EXT2_FS=y


Martin
-- 
------------------------------------------------------------------
Martin Knoblauch         |    email:  Martin.Knoblauch@TeraPort.de
TeraPort GmbH            |    Phone:  +49-89-510857-309
C+ITS                    |    Fax:    +49-89-510857-111
http://www.teraport.de   |    Mobile: +49-170-4904759
