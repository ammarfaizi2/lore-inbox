Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280136AbRKEDFP>; Sun, 4 Nov 2001 22:05:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280163AbRKEDFF>; Sun, 4 Nov 2001 22:05:05 -0500
Received: from adsl-63-194-239-202.dsl.lsan03.pacbell.net ([63.194.239.202]:41457
	"EHLO mmp-linux.matchmail.com") by vger.kernel.org with ESMTP
	id <S280146AbRKEDEx>; Sun, 4 Nov 2001 22:04:53 -0500
Date: Sun, 4 Nov 2001 19:04:46 -0800
From: Mike Fedyk <mfedyk@matchmail.com>
To: lonnie@outstep.com
Cc: Ryan Cumming <bodnar42@phalynx.dhs.org>, linux-kernel@vger.kernel.org
Subject: Re: Special Kernel Modification
Message-ID: <20011104190446.B16017@mikef-linux.matchmail.com>
Mail-Followup-To: lonnie@outstep.com,
	Ryan Cumming <bodnar42@phalynx.dhs.org>,
	linux-kernel@vger.kernel.org
In-Reply-To: <3BE5D6EC.8040204@outstep.com> <E160XU3-00012T-00@localhost> <1004920141.3be5dd4db68a0@mail.outstep.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1004920141.3be5dd4db68a0@mail.outstep.com>
User-Agent: Mutt/1.3.23i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 04, 2001 at 07:29:01PM -0500, lonnie@outstep.com wrote:
> Hello Ryan,
> 
> >From what I can see. With chrooting, I have to make a complete "fake" system an
> then place the users below that into a home directory, or make a complete "fake"
> system for each user.

> The basic problem is that I did not want, for example "user2" to be able to "cd
> .." or some thing to go out of user2
> 
> I was hoping to be able to accomplish this at the filesystem level somehow, and
> possibly without the need to mount the /dev/hda4 onto each /home/user/system, or
> without having to make entire copies of the chrooted environment for each user.
> 

Chroot will allow you to keel a user within a certain directory tree, and as
long as you use hard links on the same FS, you won't waste much space for
each chroot...

Also, why don't you want the users to be able to see the executable
directories?  They're only writable by root, right?

If you set each user's home directory to mode 0700 no other user will be
able to cd into that dir...

The real question is why do you want to split each user so much?

Mike
