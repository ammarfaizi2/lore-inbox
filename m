Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289680AbSAWFVq>; Wed, 23 Jan 2002 00:21:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289685AbSAWFVh>; Wed, 23 Jan 2002 00:21:37 -0500
Received: from dsl-213-023-043-159.arcor-ip.net ([213.23.43.159]:46232 "EHLO
	starship.berlin") by vger.kernel.org with ESMTP id <S289677AbSAWFVY>;
	Wed, 23 Jan 2002 00:21:24 -0500
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: jm@jmason.org (Justin Mason), avfs@fazekas.hu
Subject: Re: [Avfs] Re: [ANNOUNCE] FUSE: Filesystem in Userspace 0.95
Date: Wed, 23 Jan 2002 06:26:08 +0100
X-Mailer: KMail [version 1.3.2]
Cc: Miklos.Szeredi@eth.ericsson.se (Miklos Szeredi),
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20020123023318.AE5F310710@stinkpad.jmason.org>
In-Reply-To: <20020123023318.AE5F310710@stinkpad.jmason.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E16TFvE-0001y2-00@starship.berlin>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On January 23, 2002 03:33 am, Justin Mason wrote:
> Daniel Phillips said:
> 
> > I've been meaning to have a read through this for some time, and I'm finally 
> > getting around to it.  Random question: you seem to have embedded much of Joe 
> > Orton's Neon project (http://freshmeat.net/projects/neon/) in your tgz.  Is 
> > there any particular reason for that?  Isn't this going to turn into a 
> > maintainance problem eventually?
> 
> It provides an API for remote DAV fs access, which AVFS/FUSE uses for the
> dav module.  I wrote the initial DAV support, hence the reply ;)
> 
> There are some problems with it, namely that FUSE would work better with a
> block-oriented GET/PUT api instead of a file-oriented one which Neon
> provides.  So it should probably be replaced with calls to a HTTP client
> implementation anyway, instead, at some point.
> 
> Not sure how it could be a maintainance problem, though; as long as Neon
> is linked into the FUSE userspace daemon statically, it shouldn't collide
> with other stuff.

I meant: your version of his code will start to age, or perhaps you will hack
on it, meanwhile he will move ahead with his.  So the two code bases, which
are really the same thing, will start to diverge.  How will you handle that?

--
Daniel
