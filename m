Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129307AbRBTVIB>; Tue, 20 Feb 2001 16:08:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130136AbRBTVHv>; Tue, 20 Feb 2001 16:07:51 -0500
Received: from www.pcxperience.com ([199.217.242.242]:23028 "EHLO
	gannon.zelda.pcxperience.com") by vger.kernel.org with ESMTP
	id <S129307AbRBTVHo>; Tue, 20 Feb 2001 16:07:44 -0500
Message-ID: <3A92DC4D.647EA0BB@pcxperience.com>
Date: Tue, 20 Feb 2001 15:06:21 -0600
From: "James A. Pattie" <james@pcxperience.com>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.1 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: Tom Sightler <ttsig@tuxyturvy.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: Reiserfs, 3 Raid1 arrays, 2.4.1 machine locks up
In-Reply-To: <3A91A6E7.1CB805C1@pcxperience.com> <96s93d$hh6$1@lennie.clouddancer.com> <20010220135326.013DF682A@mail.clouddancer.com> <3A92AA23.9A0BAC43@pcxperience.com> <20010220181849.F1C68682B@mail.clouddancer.com> <003701c09b75$59f56ff0$25040a0a@zeusinc.com> <3A92CBE6.A84B7ED3@pcxperience.com> <006b01c09b78$f8dd7e20$25040a0a@zeusinc.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Tom Sightler wrote:

> > > There seem to be several reports of reiserfs falling over when memory is
> > > low.  It seems to be undetermined if this problem is actually reiserfs
> or MM
> > > related, but there are other threads on this list regarding similar
> issues.
> > > This would explain why the same disk would work on a different machine
> with
> > > more memory.  Any chance you could add memory to the box temporarily
> just to
> > > see if it helps, this may help prove if this is the problem or not.
> > >
> >
> > Out of all the old 72 pin simms we have, we have it maxed out at 48 MB's.
> I'm
> > tempted to take the 2 drives out and put them in the k6-2, but that's too
> much
> > of a hassle.  I'm currently going to try 2.4.1-ac19 and see what happens.
> >
> > The machine does have 128MB of swap space working, and whenever I've
> checked
> > memory usage (while the system was still responding), it never went over a
> > couple megs of swap space used.
>
> Ah yes, but, from what I've read, the problem seems to occur when
> buffer/cache memory is low (<6MB), you could have tons of swap and still
> reach this level.
>
> Later,
> Tom

You were right!  I managed to find another 32MB of memory to bump it up to 64
MB total and it worked perfectly.  It appears that I had only about 4 MB of
buffer/cache in the 48 MB system and over 15MB in the 64 MB system.  I did my
install and switched back to the 48MB running normally and its working just
fine.

Thanks,


--
James A. Pattie
james@pcxperience.com

Linux  --  SysAdmin / Programmer
PC & Web Xperience, Inc.
http://www.pcxperience.com/



