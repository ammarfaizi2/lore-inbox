Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282655AbRLBBhy>; Sat, 1 Dec 2001 20:37:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282656AbRLBBho>; Sat, 1 Dec 2001 20:37:44 -0500
Received: from adsl-67-36-120-14.dsl.klmzmi.ameritech.net ([67.36.120.14]:23468
	"HELO tabris.net") by vger.kernel.org with SMTP id <S282655AbRLBBha>;
	Sat, 1 Dec 2001 20:37:30 -0500
Content-Type: text/plain; charset=US-ASCII
From: Adam Schrotenboer <ajschrotenboer@lycosmail.com>
Organization: Dome-S-Isle Data
To: Richard Gooch <rgooch@ras.ucalgary.ca>,
        Christian =?iso-8859-1?q?Borntr=E4ger?= 
	<linux-kernel@borntraeger.net>
Subject: Re: 2.4.17pre2: devfs: devfs_mk_dir(printers): could not append to dir: dffe45c0 "", err: -17
Date: Sat, 1 Dec 2001 20:37:24 -0500
X-Mailer: KMail [version 1.3.1]
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <E16A6LR-00042s-00@mrvdom02.schlund.de> <200112011808.fB1I8lq31535@vindaloo.ras.ucalgary.ca>
In-Reply-To: <200112011808.fB1I8lq31535@vindaloo.ras.ucalgary.ca>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20011202013724.9085AFB80D@tabris.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 01 December 2001 13:08, Richard Gooch wrote:
> linux-kernel@borntraeger.net writes:
<snip>
> The new devfs core is less forgiving about these kinds of
> bugs/misuses.
>
> > devfs: devfs_register(nvidiactl): could not append to parent, err: -17
> > devfs: devfs_register(nvidia0): could not append to parent, err: -17
> >
> > with 2.4.16 and before the message was:
> >
> > devfs: devfs_register(): device already registered: "nvidia0"
>
> Who knows what nvidia does? Talk to them. Could be a bug in their
> driver where they create duplicate entries (the old devfs code would
> often let you get away with this). Or again, perhaps something in
> user-space is creating these entries.
>
As of 1541 anyway (haven't tried anything newer, assuming newer exists), the 
make install of the nvidia driver also runs makedevices.sh (a vendor sp 
script that makes the devnodes. This may also have been put in the 
initscripts (mine isn't, but i tend to use the tar.gz fmt, not using the RPMs)
Perhaps there is no check for devfs (likely will be fixed in the next 
release, as this is a new situation)

> > Why has this changed, and what is actually happen? My system runs
> > fine.
>
> You're lucky that the with way you use your system, it still works.
>
<snip> AFAIK, the nvidia scipt does not make the devnodes persistent (if so, 
it's b0rken on my box)

-- 
tabris
