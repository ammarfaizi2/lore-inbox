Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261321AbRESUMI>; Sat, 19 May 2001 16:12:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261324AbRESUL6>; Sat, 19 May 2001 16:11:58 -0400
Received: from smtp3.libero.it ([193.70.192.53]:35265 "EHLO smtp3.libero.it")
	by vger.kernel.org with ESMTP id <S261321AbRESULw>;
	Sat, 19 May 2001 16:11:52 -0400
Message-ID: <3B06D37D.C98BE713@alsa-project.org>
Date: Sat, 19 May 2001 22:11:41 +0200
From: Abramo Bagnara <abramo@alsa-project.org>
Organization: Opera Unica
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.4 i586)
X-Accept-Language: it, en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: Pavel Machek <pavel@suse.cz>, James Simmons <jsimmons@transvirtual.com>,
        Alexander Viro <viro@math.psu.edu>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Neil Brown <neilb@cse.unsw.edu.au>,
        Jeff Garzik <jgarzik@mandrakesoft.com>,
        "H. Peter Anvin" <hpa@transmeta.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: no ioctls for serial ports? [was Re: LANANA: To Pending DeviceNumber 
 Registrants]
In-Reply-To: <Pine.LNX.4.21.0105191152130.14472-100000@penguin.transmeta.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:
> 
> [ Attribution is gone, so I just deleted it.. ]
> 
> > > > >         fd = open("/dev/tty00/nonblock,9600,n8", O_RDWR);
> > > >
> > > > Hmm, there might be problem with this. How do you change speed without
> > > > reopening device? [Remember: your mice knows when you close device]
> 
> The naming scheme is not a replacement for these kinds of ioctl's - it's
> just a way to make them less critical, and get people thinking in other
> directions so that we don't get _more_ ioctl's.

However
	fchdir(fd);
	s = open("speed");
	write(s, "19200\n", 6);

would be enough to solve the problem Pavel is pointing also without the
need to use ioctl.


-- 
Abramo Bagnara                       mailto:abramo@alsa-project.org

Opera Unica                          Phone: +39.546.656023
Via Emilia Interna, 140
48014 Castel Bolognese (RA) - Italy

ALSA project               http://www.alsa-project.org
It sounds good!
