Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280082AbRKEAmN>; Sun, 4 Nov 2001 19:42:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280081AbRKEAl6>; Sun, 4 Nov 2001 19:41:58 -0500
Received: from a904j637.tower.wayne.edu ([141.217.140.65]:26357 "HELO
	mail.outstep.com") by vger.kernel.org with SMTP id <S280082AbRKEAlA>;
	Sun, 4 Nov 2001 19:41:00 -0500
To: Ryan Cumming <bodnar42@phalynx.dhs.org>
Subject: Re: Special Kernel Modification
Message-ID: <1004920141.3be5dd4db68a0@mail.outstep.com>
Date: Sun, 04 Nov 2001 19:29:01 -0500 (EST)
From: lonnie@outstep.com
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <3BE5D6EC.8040204@outstep.com> <E160XU3-00012T-00@localhost>
In-Reply-To: <E160XU3-00012T-00@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
User-Agent: IMP/PHP IMAP webmail program 2.2.5
X-Originating-IP: 192.168.1.100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Ryan,

>From what I can see. With chrooting, I have to make a complete "fake" system an
then place the users below that into a home directory, or make a complete "fake"
system for each user.

I was trying to find a simple solution that would allow for:

I was initially thinking about something like this for each user:

/system (real) /dev/hda4 (chrooted also)
      |
      /bin
      /etc
      /lib



/home (each user chrooted)
     |
     /user1
     |     |
     |     /system (mounted /dev/hda4)
     |            |
     |            /bin
     |            /etc
     |            /lib
     |
     /user2
     |     |
     |     /system (mounted /dev/hda4)
     |            |
     |            /bin
     |            /etc
     |            /lib
     |
     /user n
          |
          /system (mounted /dev/hda4)
                 |
                 /bin
                 /etc
                 /lib

The basic problem is that I did not want, for example "user2" to be able to "cd
.." or some thing to go out of user2

I was hoping to be able to accomplish this at the filesystem level somehow, and
possibly without the need to mount the /dev/hda4 onto each /home/user/system, or
without having to make entire copies of the chrooted environment for each user.

Cheers,
Lonnie

Quoting Ryan Cumming <bodnar42@phalynx.dhs.org>:

> On November 4, 2001 16:01, Lonnie Cumberland wrote:
> > I have look into using things like "chroot" to restrict the users
> for
> > this very special server, but that solution is not what we need.
> ....
> > Is there someone who might be able to give me some information on how
> I
> > could add a few lines to the VFS filesystem so that I might set some
> > type of extended attribute to prevent users from navigating out of
> the
> > locations.
>
> I fail to see the difference between "chroot" and "preventing users from
>
> navigating out of locations". Would you care to clarify what was wrong
> was
> chroot that you believe you can solve with a different approach?
> -Ryan
>
