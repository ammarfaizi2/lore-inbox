Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129069AbRBBVes>; Fri, 2 Feb 2001 16:34:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129049AbRBBVei>; Fri, 2 Feb 2001 16:34:38 -0500
Received: from vmlinux.demon.co.uk ([193.237.10.217]:23826 "EHLO vmlinux.net")
	by vger.kernel.org with ESMTP id <S129242AbRBBVeD>;
	Fri, 2 Feb 2001 16:34:03 -0500
Date: Fri, 2 Feb 2001 21:34:12 +0000 (GMT)
From: John Morrison <john@vmlinux.net>
To: Hans Reiser <reiser@namesys.com>
cc: Alan Cox <alan@redhat.com>, Chris Mason <mason@suse.com>,
        Jan Kasprzak <kas@informatics.muni.cz>, <linux-kernel@vger.kernel.org>,
        <reiserfs-list@namesys.com>,
        "Yury Yu. Rupasov" <yura@yura.polnet.botik.ru>
Subject: Re: [reiserfs-list] Re: ReiserFS Oops (2.4.1, deterministic, symlink
In-Reply-To: <3A7B1BFA.F7B4EAD@namesys.com>
Message-ID: <Pine.LNX.4.30.0102022126300.883-100000@vaio.vmlinux.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



My last comment on this...

It makes sense to refuse to build a piece of the kernel if it break's
a machine - anything else is a timebomb waiting to explode.

I feel politics are at play here...I don't really care who's bug it is -
all I know is using pre 2.96 fixes it and everyone needs to be aware of
this. If this means checking in Reiserfs makefile or the main Linux
makefile then so be it.


Its simple logic ;-)


John



> Alan Cox wrote:
> >
> > > So, did Linus say no?  If not, let's ask him with a patch.  Quite simply,
> > > neither we nor the users should be burdened with this, and the patch removes
> > > the burden.
> >
> > Since egcs-1.1.2 and gcc 2.95 miscompile the kernel strstr code dont forget
> > to stop those being used as well. Oh look you'll need CVS gcc to build the
> > kernel... ah but wait that misbuilds DAC960.c...
> >
> > Oh look nothing compiles the kernel.
> >
> > Congratulations 8)
> >
> > Alan
>
>
> Users cannot use gcc 2.96 as shipped in RedHat 7.0 if they want to use
> reiserfs.  It is that simple.  How can you even consider defending allowing the
> use of it without requiring a positive affirmation by the user that they don't
> know what they are doing and want to do it anyway?:-)  I could understand
> arguing that you don't want to be bothered with protecting the users because you
> don't have the time, but if somebody else finds the time to write the patch....
>
> I would indeed encourage Linus to accept patches to test for known bad compilers
> at make time.  It is less work for us all to prevent users from having bugs than
> to respond to their having them.  I look forward to gcc 3.00, and I encourage
> the compiler guys to get over being (understandably) irked that somebody else
> released their code prematurely, and to increment the version number to 2.97 so
> that users can more easily avoid the baddie.
>
> Hans
>

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
