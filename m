Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289655AbSAWCdx>; Tue, 22 Jan 2002 21:33:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289653AbSAWCdo>; Tue, 22 Jan 2002 21:33:44 -0500
Received: from CPE-144-137-3-240.vic.bigpond.net.au ([144.137.3.240]:16648
	"HELO stinkpad.jmason.org") by vger.kernel.org with SMTP
	id <S289603AbSAWCdY>; Tue, 22 Jan 2002 21:33:24 -0500
To: avfs@fazekas.hu
Cc: Miklos.Szeredi@eth.ericsson.se (Miklos Szeredi),
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [Avfs] Re: [ANNOUNCE] FUSE: Filesystem in Userspace 0.95 
In-Reply-To: Message from Daniel Phillips <phillips@bonn-fries.net> 
   of "Tue, 22 Jan 2002 20:07:15 BST." <E16T6GJ-0001rq-00@starship.berlin> 
From: jm@jmason.org (Justin Mason)
X-GPG-Key-Fingerprint: 0A48 2D8B 0B52 A87D 0E8A  6ADD 4137 1B50 6E58 EF0A
Date: Wed, 23 Jan 2002 13:33:13 +1100
Message-Id: <20020123023318.AE5F310710@stinkpad.jmason.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Daniel Phillips said:

> I've been meaning to have a read through this for some time, and I'm finally 
> getting around to it.  Random question: you seem to have embedded much of Joe 
> Orton's Neon project (http://freshmeat.net/projects/neon/) in your tgz.  Is 
> there any particular reason for that?  Isn't this going to turn into a 
> maintainance problem eventually?

It provides an API for remote DAV fs access, which AVFS/FUSE uses for the
dav module.  I wrote the initial DAV support, hence the reply ;)

There are some problems with it, namely that FUSE would work better with a
block-oriented GET/PUT api instead of a file-oriented one which Neon
provides.  So it should probably be replaced with calls to a HTTP client
implementation anyway, instead, at some point.

Not sure how it could be a maintainance problem, though; as long as Neon
is linked into the FUSE userspace daemon statically, it shouldn't collide
with other stuff.

--j.
