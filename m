Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261467AbRETHT3>; Sun, 20 May 2001 03:19:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261468AbRETHTU>; Sun, 20 May 2001 03:19:20 -0400
Received: from smtp3.libero.it ([193.70.192.53]:35772 "EHLO smtp3.libero.it")
	by vger.kernel.org with ESMTP id <S261467AbRETHTF>;
	Sun, 20 May 2001 03:19:05 -0400
Message-ID: <3B076FE2.A8B49526@alsa-project.org>
Date: Sun, 20 May 2001 09:18:58 +0200
From: Abramo Bagnara <abramo@alsa-project.org>
Organization: Opera Unica
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.4 i586)
X-Accept-Language: it, en
MIME-Version: 1.0
To: Alexander Viro <viro@math.psu.edu>
CC: Linus Torvalds <torvalds@transmeta.com>, Pavel Machek <pavel@suse.cz>,
        James Simmons <jsimmons@transvirtual.com>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Neil Brown <neilb@cse.unsw.edu.au>,
        Jeff Garzik <jgarzik@mandrakesoft.com>,
        "H. Peter Anvin" <hpa@transmeta.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: no ioctls for serial ports? [was Re: LANANA: To Pending DeviceNumber 
 Registrants]
In-Reply-To: <Pine.GSO.4.21.0105191943300.7162-100000@weyl.math.psu.edu>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alexander Viro wrote:
> 
> On Sat, 19 May 2001, Linus Torvalds wrote:
> 
> >
> > What you're really proposing is to make ioctl's be ASCII strings.
> >
> > Which is not necessarily a bad idea, and I think plan9 did something
> > similar (or rather, if I remember correctly, plan9 has control streams
> > that were ASCII. Or am I confused?).
> 
> You are not. Control streams in question look like normal files. Normally
> driver exports a tree with several data files (e.g. fd0, fd1, fd2, fd3)
> and several control files (e.g. fd0ctl, fd1ctl, fd2ctl, fd3ctl). write()
> to the latter passes commands. No extra syscalls needed.

I've just had a "so simple to risk to be stupid" idea.

To have /proc/self/fd/N/ioctl would not have the potential to suppress
ioctl needs for *all* current uses?

-- 
Abramo Bagnara                       mailto:abramo@alsa-project.org

Opera Unica                          Phone: +39.546.656023
Via Emilia Interna, 140
48014 Castel Bolognese (RA) - Italy

ALSA project               http://www.alsa-project.org
It sounds good!
