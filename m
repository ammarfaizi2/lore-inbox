Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261432AbRERSeL>; Fri, 18 May 2001 14:34:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261431AbRERSeB>; Fri, 18 May 2001 14:34:01 -0400
Received: from [206.14.214.140] ([206.14.214.140]:28174 "EHLO
	www.transvirtual.com") by vger.kernel.org with ESMTP
	id <S261430AbRERSdr>; Fri, 18 May 2001 14:33:47 -0400
Date: Fri, 18 May 2001 11:32:54 -0700 (PDT)
From: James Simmons <jsimmons@transvirtual.com>
To: Pavel Machek <pavel@suse.cz>
cc: Linus Torvalds <torvalds@transmeta.com>,
        Alexander Viro <viro@math.psu.edu>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Neil Brown <neilb@cse.unsw.edu.au>,
        Jeff Garzik <jgarzik@mandrakesoft.com>,
        "H. Peter Anvin" <hpa@transmeta.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: LANANA: To Pending Device Number Registrants
In-Reply-To: <20010517104226.B44@toy.ucw.cz>
Message-ID: <Pine.LNX.4.10.10105181130510.12643-100000@www.transvirtual.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> > They might also be exactly the same channel, except with certain magic
> > bits set. The example peter gave was fine: tty devices could very usefully
> > be opened with something like
> > 
> > 	fd = open("/dev/tty00/nonblock,9600,n8", O_RDWR);
> > 
> > where we actually open up exactly the same channel as if we opened up
> > /dev/cua00, we just set the speed etc at the same time. Which makes things
> 
> Hmm, there might be problem with this. How do you change speed without
> reopening device? [Remember: your mice knows when you close device]

If you implement it as a filesystem you coould have a settings file in the
tty filesystem. Something like this:

echo "115200" >  /dev/tty/settings


