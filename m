Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276249AbRKFAug>; Mon, 5 Nov 2001 19:50:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276424AbRKFAuZ>; Mon, 5 Nov 2001 19:50:25 -0500
Received: from a904j637.tower.wayne.edu ([141.217.140.65]:31471 "HELO
	mail.outstep.com") by vger.kernel.org with SMTP id <S276249AbRKFAuP>;
	Mon, 5 Nov 2001 19:50:15 -0500
To: Jorgen Cederlof <jc@lysator.liu.se>
Subject: Re: Special Kernel Modification
Message-ID: <1005007088.3be730f0d6465@mail.outstep.com>
Date: Mon, 05 Nov 2001 19:38:08 -0500 (EST)
From: lonnie@outstep.com
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20011106013456.B12540@ondska>
In-Reply-To: <20011106013456.B12540@ondska>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit
User-Agent: IMP/PHP IMAP webmail program 2.2.5
X-Originating-IP: 192.168.1.100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks Jorgen,

I am sure that this will help as it looks like what I might need....

Thanks again,
Lonnie

Quoting Jorgen Cederlof <jc@lysator.liu.se>:

> 
> On Sun, Nov 04, 2001 at 19:29:01 -0500, lonnie@outstep.com wrote:
> 
> > From what I can see. With chrooting, I have to make a complete
> > "fake" system an then place the users below that into a home
> > directory, or make a complete "fake" system for each user.
> > 
> > I was trying to find a simple solution that would allow for:
> > 
> > I was initially thinking about something like this for each user:
> > 
> > /system (real) /dev/hda4 (chrooted also)
> >       |
> >       /bin
> >       /etc
> >       /lib
> 
> chtrunk (http://noid.sf.net/chtrunk.html) can set up the namespace
> dynamically for you. Instead of creating a complete system by hand and
> run chroot, just run (you don't need to be root):
> 
>    chtrunk -s /bin /etc /lib /home/user -c program_to_run
> 
> This will give that program access to /bin, /etc, /lib and the home
> directory, but nothing more.
> 
> You can use
> 
>    chtrunk -s /bin /etc /lib /home/user /tmp=/home/user/tmp -c program
> 
> to give every user their own private /tmp.
> 
> As a bonus, the suid/sgid bits will have no effect for these users,
> which will prevent them from becoming root through buggy suid
> programs.
> 
>     Jörgen
> 
