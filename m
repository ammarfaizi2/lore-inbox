Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271289AbTGQV3o (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Jul 2003 17:29:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271525AbTGQV3o
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Jul 2003 17:29:44 -0400
Received: from pa208.myslowice.sdi.tpnet.pl ([213.76.228.208]:19840 "EHLO
	finwe.eu.org") by vger.kernel.org with ESMTP id S271289AbTGQV3l
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Jul 2003 17:29:41 -0400
Date: Thu, 17 Jul 2003 23:44:33 +0200
From: Jacek Kawa <jfk@zeus.polsl.gliwice.pl>
To: Mikael Pettersson <mikpe@csd.uu.se>
Cc: vojtech@suse.cz, alan@lxorguk.ukuu.org.uk, axboe@suse.de,
       davej@codemonkey.org.uk, linux-kernel@vger.kernel.org
Subject: Re: PS2 mouse going nuts during cdparanoia session.
Message-ID: <20030717214433.GB1858@finwe.eu.org>
Mail-Followup-To: Mikael Pettersson <mikpe@csd.uu.se>,
	vojtech@suse.cz, alan@lxorguk.ukuu.org.uk, axboe@suse.de,
	davej@codemonkey.org.uk, linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030717020324.GA1685@finwe.eu.org>
Organization: Kreatorzy Kreacji Bialej
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I wrote:

[...]
> > This was interesting: 2.5 programs the mouse differently than 2.4.
> > I've been having ps2 mouse problems with the 2.5 input layer,
> > including having to move the mouse much further for a given
> Strange. Here I've got problems with my mouse being actually 'to fast'
> (when working with X-Window; I had to slow it down about 2 times via
> xset to be able to work 'normally'; Actually -since I could not find
> any related bugreports or complains - I thought it was something with 
> how my version of X works with new layer) 

Once I upgraded X to 4.3 and changed /dev/psaux to /dev/input/mice 
everything is OK (and I'm quite happy it works :)

I guess (now) that it's not much related to other problems mentioned in this
thread, but if you think it might be helpful I can post some more info.

BTW - For testing purposes I've tested few different combinations:

AC -'another computer' MC- 'my computer'; both: kernel 2.6.0t1, recently
    upgraded Debian SID

AC  X4.2 and /dev/psaux ->ok
    X4.3 and /dev/psaux -> ok (I hope my sister won't
                               be angry, that I've reconfigured
			       her system when she's back home 8)

MC with different mouse -> no change
MC with different values of xres, yres, psmouse_resolution parameters -> no change

MC, X4.2 and /dev/psaux -> too fast
    X4.2 and /dev/psaux & ACPI off -> too fast
    X4.3 and /dev/psaux -> too fast
    X4.2 and /dev/input/mice -> too fast
          (IIRC - I'm _almost_ sure I tried it with 
 		2.5.75 few days ago [and it did not work])
    X4.3 and /dev/input/mice -> ok

[cut]

jk :-)

-- 
Jacek Kawa
