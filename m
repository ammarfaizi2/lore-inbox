Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132372AbRD0Wr0>; Fri, 27 Apr 2001 18:47:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132387AbRD0WrH>; Fri, 27 Apr 2001 18:47:07 -0400
Received: from sgi.SGI.COM ([192.48.153.1]:28711 "EHLO sgi.com")
	by vger.kernel.org with ESMTP id <S132372AbRD0Wq5>;
	Fri, 27 Apr 2001 18:46:57 -0400
Message-ID: <3AE9F63B.D04A91EE@sgi.com>
Date: Fri, 27 Apr 2001 15:44:11 -0700
From: LA Walsh <law@sgi.com>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.3 i686)
X-Accept-Language: en, en-US, en-GB, fr
MIME-Version: 1.0
To: Rik van Riel <riel@conectiva.com.br>
CC: Rogier Wolff <R.E.Wolff@BitWizard.nl>,
        Xavier Bestel <xavier.bestel@free.fr>,
        Goswin Brederlow <goswin.brederlow@student.uni-tuebingen.de>,
        William T Wilson <fluffy@snurgle.org>, Matt_Domsch@Dell.com,
        linux-kernel@vger.kernel.org
Subject: Re: 2.4 and 2GB swap partition limit
In-Reply-To: <Pine.LNX.4.33.0104271842550.17635-100000@duckman.distro.conectiva>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rik van Riel wrote:

> On Fri, 27 Apr 2001, LA Walsh wrote:
>
> >     An interesting option (though with less-than-stellar performance
> > characteristics) would be a dynamically expanding swapfile.  If you're
> > going to be hit with swap penalties, it may be useful to not have to
> > pre-reserve something you only hit once in a great while.
>
> This makes amazingly little sense since you'd still need to
> pre-reserve the disk space the swapfile grows into.

---
    Why?  Why not have a zero length file that you grow only if you spill?
If you can't spill, you are out of memory -- or reserve a 'safety'
margin ahead -- like reserve 32k at a time and grow it.  It may make
little sense, but I believe it is what is used on pseudo OS's
like Windows -- you *can* preallocate, but the normal case has
Windows managing the swap file and growing it as needed up to
available disk space.  If it is doable in windows, you'd think there'd
be some way of doing it in Linux, but perhaps linux's complexity
doesn't allow for that type of feature.

    As for disk-space reserves, if you have 5% reserved for
root' on a 20G ext disk, that still amounts to 1G reserved for root.
Seems an automatically sizing swap file might be just fine for some people
not me, I don't even like to use swap, but I'm not my mom using windows ME either).

    But, conversely, if it's coming out of space I wouldn't normally
use anyway -- say the "5%" -- i.e. the 5% is something I'd likely only
use under *rare* conditions.  I might have enough memory and the
right system load that I also 'rarely' use swap -- so not reserving
1G/1G (2xMEM) on my laptop both of which will rarely get used seems like
a waste of 2G.  I suppose if I put it that way I might convince myself
to use it,

--
The above thoughts and           | They may have nothing to do with
writings are my own.             | the opinions of my employer. :-)
L A Walsh                        | Trust Technology, Core Linux, SGI
law@sgi.com                      | Voice: (650) 933-5338



