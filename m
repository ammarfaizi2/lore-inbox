Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262921AbTJGVIA (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Oct 2003 17:08:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262901AbTJGVIA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Oct 2003 17:08:00 -0400
Received: from [209.195.52.120] ([209.195.52.120]:11479 "HELO
	warden2.diginsite.com") by vger.kernel.org with SMTP
	id S262930AbTJGVCB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Oct 2003 17:02:01 -0400
From: David Lang <david.lang@digitalinsight.com>
To: Bradley Chapman <kakadu_croc@yahoo.com>
Cc: mru@users.sourceforge.net, linux-kernel@vger.kernel.org
Date: Tue, 7 Oct 2003 13:57:24 -0700 (PDT)
Subject: Re: devfs and udev
In-Reply-To: <20031007131719.27061.qmail@web40910.mail.yahoo.com>
Message-ID: <Pine.LNX.4.58.0310071354580.19220@dlang.diginsite.com>
References: <20031007131719.27061.qmail@web40910.mail.yahoo.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 7 Oct 2003, Bradley Chapman wrote:

> Date: Tue, 7 Oct 2003 06:17:19 -0700 (PDT)
> From: Bradley Chapman <kakadu_croc@yahoo.com>
> To: mru@users.sourceforge.net
> Cc: linux-kernel@vger.kernel.org
> Subject: Re: devfs and udev
>
> Mr. Rullgard,
>
> > I noticed this in the help text for devfs in 2.6.0-test6:
> >
> > Note that devfs has been obsoleted by udev,
> > <http://www.kernel.org/pub/linux/utils/kernel/hotplug/>.
> > It has been stripped down to a bare minimum and is only provided for
> > legacy installations that use its naming scheme which is
> > unfortunately different from the names normal Linux installations
> > use.
> >
> > Now, this puzzles me, for a few of reasons. Firstly, not long ago,
> > devfs was spoken of as the way to go, and all drivers were rewritten
> > to support it. Why this sudden change? Secondly, that link only
> > leads me to a package describing itself as an experimental
> > proof-of-concept thing, not to be used for anything serious. How can
> > something that incomplete obsolete a working system like devfs?
> > Thirdly, udev appears to respond to hotplug events only. How is it
> > supposed to handle device files not corresponding to any physical
> > device? Finally, I quite liked the idea of a virtual filesystem for
> > /dev. It reduced the clutter quite a bit. As for the naming scheme,
> > it could easily be changed.
>
> I think the two things which really prevented devfs from working were:
>
> 1. The namespace was too different from the original and required additional
> configuration to maintain compatibility (devfsd and changes to core /etc
> files.)

the namespace was different becouse Linus demanded that it be different,
origionally it had a mode where it would generate all the same names (and
another mode that generated sun style names) one of the requirements
before it was put in was to change it to the existing devfs-only names.

blame devfs for a lot of things (bugs, etc) but not the names.

David Lang

> 2. Devfs was not immediately picked up my the major distros, which meant that
> any moderate end-user who wanted to use it would have to be careful when
> setting it up or risk massive core breakage due to the changed device nodes
> (initscripts failing and the like).
>
> I used it for a very long time, personally; it was a good idea, and it had
> potential. If the namespace that had been used was the same flat namespace as
> the original /dev, it would have probably taken off. As it is, I think udev
> is the new way of doing this (I haven't used it yet).
>
> Brad
>
> =====
> Brad Chapman
>
> Permanent e-mail: kakadu_croc@yahoo.com
>
> __________________________________
> Do you Yahoo!?
> The New Yahoo! Shopping - with improved product search
> http://shopping.yahoo.com
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>

-- 
"Debugging is twice as hard as writing the code in the first place.
Therefore, if you write the code as cleverly as possible, you are,
by definition, not smart enough to debug it." - Brian W. Kernighan
