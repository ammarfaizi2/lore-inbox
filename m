Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135365AbRAHWCm>; Mon, 8 Jan 2001 17:02:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135317AbRAHWCc>; Mon, 8 Jan 2001 17:02:32 -0500
Received: from 209.102.21.2 ([209.102.21.2]:64263 "EHLO dragnet.seagull.net")
	by vger.kernel.org with ESMTP id <S135293AbRAHWCZ>;
	Mon, 8 Jan 2001 17:02:25 -0500
Message-ID: <3A5A087F.F1C45380@goingware.com>
Date: Mon, 08 Jan 2001 18:35:43 +0000
From: "Michael D. Crawford" <crawford@goingware.com>
Organization: GoingWare Inc. - Expert Software Development and Consulting
X-Mailer: Mozilla 4.73 [en] (X11; U; Linux 2.4.0-ac4 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org, newbie@xfree86.org
Subject: Re: DRI doesn't work on 2.4.0 but does on prerelease-ac5
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

OK, I built XFree86 4.0.2 and DRI seems to be working for me now under
2.4.0-ac4.  (Starting with 2.4.0, it wouldn't, this is with an ATI XPert 2000
AGP).

BUT - although /var/log/XFree86.0.log documents the startup of DRI, DRM and AGP,
and states the info about their initialization and stuff so that it looks like
they're working, I don't notice any performance difference running any of the
Mesa-3.4 demos whether or not I use DRI, and whether I run 4.0.1 or 4.0.2.

This makes me suspect it's not really working, or else my build of the Mesa-3.4
library wasn't configured right - but note that if I disable DRI, one of the
Mesa demos will comment that it's not available.

A specific example is Mesa-3.4/demos/gloss.  It's a rotating textured cylinder
that is partially reflective of what seems to be a landscape that is in front of
the screen being reflecting back to the viewer.  I get a pretty consistent 7.5
frames per second:

- in 4.0.1 with no DRI
- in 4.0.1 with DRI
- in 4.0.2 with no DRI
- in 4.0.2 with DRI

Having agpgart and drm/r128 compiled in or as modules also doesn't appear to
make a difference.

The frame rate for gloss drops to about 3.5 if I run geartrain (another demo)
alongside it.  Geartrain by itself seems to be about the same speed in all
cases, though it doesn't report a number.

There are a couple benchmarking tools in Mesa if someone wanted hard numbers
from me.

Can anyone suggest any 3D code that I can download that does more complex things
than the mesa demos that I can test this with?

Is my DRI really working?  If not, any tips on getting it to do so?

Mike
-- 
Michael D. Crawford
GoingWare Inc. - Expert Software Development and Consulting
http://www.goingware.com/
crawford@goingware.com

   Tilting at Windmills for a Better Tomorrow.
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
