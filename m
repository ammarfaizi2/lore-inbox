Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132835AbRC2UTS>; Thu, 29 Mar 2001 15:19:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132834AbRC2UTI>; Thu, 29 Mar 2001 15:19:08 -0500
Received: from proxyd.rim.net ([206.51.26.194]:49449 "HELO mhs99ykf.rim.net")
	by vger.kernel.org with SMTP id <S132835AbRC2US5>;
	Thu, 29 Mar 2001 15:18:57 -0500
Message-ID: <A9FD1B186B99D4119BCC00D0B75B4D8107F45928@xch01ykf.rim.net>
From: Aaron Lunansky <alunansky@rim.net>
To: "'Guest section DW'" <dwguest@win.tue.nl>
Cc: linux-kernel@vger.kernel.org
Subject: RE: Mount locks on bad ISO image?
Date: Thu, 29 Mar 2001 15:15:17 -0500
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm running 2.4.2 so it's probably just the broken loop device.


Thanks,
Aaron


-----Original Message-----
From: Guest section DW [mailto:dwguest@win.tue.nl]
Sent: March 29, 2001 15:13
To: Aaron Lunansky; linux-kernel@vger.kernel.org
Subject: Re: Mount locks on bad ISO image?


On Thu, Mar 29, 2001 at 02:16:03PM -0500, Aaron Lunansky wrote:
> I tried mounting a file as an ISO image (turns out it was corrupted) -
after
> running mount file.iso /cdrom -o loop
> mount hung and did not respond.. I could not ^Z it into the background, or
> kill, or kill -9 it...
> 
> I'm certain that I have ISO and loopback support compiled into my kernel.
> 
> Anyone know what might be going on?

Answer 1: in 2.4.2 the loop device does not work
 (but things are better in the -ac patches).
Answer 2: the kernel tends to believe filesystem data,
 and a corrupted filesystem can seriously confuse the kernel.

If you make sure that the problem does not lie in loop
(you can mount other images without problems), then
I wouldnt mind seeing your image (or rather, the first
MB or two of it) to see whether the isofs code must be
improved. (In that case, put some smallish fragment up for ftp
and mail the URL to aeb@cwi.nl. Don't mail cd images.)

Andries
