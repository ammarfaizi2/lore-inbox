Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131763AbRABUk3>; Tue, 2 Jan 2001 15:40:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131806AbRABUkS>; Tue, 2 Jan 2001 15:40:18 -0500
Received: from neon-gw.transmeta.com ([209.10.217.66]:40967 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S131717AbRABUkK>; Tue, 2 Jan 2001 15:40:10 -0500
Message-ID: <3A523578.EC8E9D72@transmeta.com>
Date: Tue, 02 Jan 2001 12:09:28 -0800
From: "H. Peter Anvin" <hpa@transmeta.com>
Reply-To: "H. Peter Anvin" <device@lanana.org>
Organization: Transmeta Corporation
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.0-test12 i686)
X-Accept-Language: en, sv, no, da, es, fr, ja
MIME-Version: 1.0
To: Hubert Mantel <mantel@suse.de>
CC: Geert Uytterhoeven <geert@linux-m68k.org>,
        Linus Torvalds <torvalds@transmeta.com>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Linux Frame Buffer Device Development 
	<linux-fbdev@vuser.vu.union.edu>,
        A2232@gmx.net, Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] devices.txt bugs
In-Reply-To: <Pine.LNX.4.05.10101021122180.7140-100000@callisto.of.borg> <20010102181614.G27745@suse.de>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hubert Mantel wrote:
> 
> Hi,
> 
> On Tue, Jan 02, Geert Uytterhoeven wrote:
> 
> > This patch fixes two things:
> >
> >   - Correct the minor numbers for the frame buffer devices.  We have room for
> >     32 frame buffers since about one year, with more room for future expansion
> >     to 256.  (promised to go in by HPA on Fri, 24 Mar 2000 01:47:05 -0800).
> >
> >   - Fix a typo in the minors for the A2232 serial card
> >
> > --- linux-2.4.0-current/Documentation/devices.txt.orig        Mon Jan  1 23:30:06 2001
> > +++ linux-2.4.0-current/Documentation/devices.txt     Tue Jan  2 11:16:42 2001
> > @@ -660,6 +660,12 @@
> >
> >   29 char     Universal frame buffer
> >                 0 = /dev/fb0          First frame buffer
> > +               1 = /dev/fb1          Second frame buffer
> > +                 ...
> > +              31 = /dev/fb31         32nd frame buffer
> > +
> > +             Backward compatibility aliases {2.6}
> > +
> >                32 = /dev/fb1          Second frame buffer
> 
> How is this supposed to work? /dev/fb1 can either be 29,1 or 29,32. But
> not both at the same time.
> 

The idea is that you're supposed to change your /dev nodes; the old /dev
nodes are supported for a bit.  The device list has been updated.

	-hpa

-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
http://www.zytor.com/~hpa/puzzle.txt
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
