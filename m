Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129901AbRBYGg3>; Sun, 25 Feb 2001 01:36:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129902AbRBYGgU>; Sun, 25 Feb 2001 01:36:20 -0500
Received: from 24.68.61.66.on.wave.home.com ([24.68.61.66]:58629 "HELO
	sh0n.net") by vger.kernel.org with SMTP id <S129901AbRBYGgA>;
	Sun, 25 Feb 2001 01:36:00 -0500
Message-ID: <3A98A7C9.B7F512DD@sh0n.net>
Date: Sun, 25 Feb 2001 01:35:53 -0500
From: Shawn Starr <spstarr@sh0n.net>
Organization: sh0n.net - http://www.sh0n.net/spstarr
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.2 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: Mike Galbraith <mikeg@wen-online.de>
CC: lkm <linux-kernel@vger.kernel.org>
Subject: Re: [ANOMALIES]: 2.4.2 - __alloc_pages: failed - Patch failed
In-Reply-To: <Pine.LNX.4.33.0102250725180.1864-100000@mikeg.weiden.de>
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Right now before OOPS:
Mem:    62244K av,   61292K used,     952K free,       0K shrd,    1496K buff
Swap:  467444K av,   37344K used,  430100K free                   29528K cached

I got a lot of things running, several daemons, netscape, and other things. I put
a 400MB swap for now just to help things.

Here's what happens after oops:

Wait a second...before I didn't have the 400MB swap on, and I had about 952K of
physical ram left. Shouldn't it try and swap if it cant get enough physical
memory?

It did NOT oops with that amount of swap:

If i turn it off:

Mem:    62244K av,   61288K used,     956K free,       0K shrd,    1448K buff
Swap:   64252K av,   38024K used,   26228K free                   29880K cached

and try the xcdrgtk (X CDRoaster)

I get...hrm.. this is really strange. Now its not ooping?!

I dont know it must have to do with something somewhere I cant tell you.

Mike Galbraith wrote:

> On Sun, 25 Feb 2001, Shawn Starr wrote:
>
> > Unsure, the system remains stable after the fault though, strangely /dev/dsp
> > becomes "busy". I suspect it has to do with this somehow.. but im not sure.
> > I submitted a ksymoops dump, maybe that can help.
>
> Drop to single user and do a whopping big dd or iozone or bonnie
> and see what free reports afterward.  If much of your ram becomes
> available, it's not a leak.
>
>         -Mike

