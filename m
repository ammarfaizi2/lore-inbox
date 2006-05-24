Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932314AbWEXXSm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932314AbWEXXSm (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 May 2006 19:18:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932318AbWEXXSl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 May 2006 19:18:41 -0400
Received: from wr-out-0506.google.com ([64.233.184.229]:31698 "EHLO
	wr-out-0506.google.com") by vger.kernel.org with ESMTP
	id S932314AbWEXXSl convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 May 2006 19:18:41 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=nAzQnoOZUFXlC1SimualqAowklWxN3hv+fVFd1AKl65uzSmv9SiQUjx7LJ/bI6TjFnCHG6ZJNHLQaKdIY9L2UhxH2zrJJ+ufI4b0VXlAfw3IazeewZpzYeeK3/mOVlQnK980Bs7xgIWdi1VDyF84W3HxJISq5zxbf+wdPGY/4Pw=
Message-ID: <21d7e9970605241618x7eaeb010h60817b5ca944acd9@mail.gmail.com>
Date: Thu, 25 May 2006 09:18:40 +1000
From: "Dave Airlie" <airlied@gmail.com>
To: "Jon Smirl" <jonsmirl@gmail.com>
Subject: Re: OpenGL-based framebuffer concepts
Cc: "D. Hazelton" <dhazelton@enter.net>, "Alan Cox" <alan@lxorguk.ukuu.org.uk>,
       "Kyle Moffett" <mrmacman_g4@mac.com>,
       "Manu Abraham" <abraham.manu@gmail.com>,
       "linux cbon" <linuxcbon@yahoo.fr>,
       "Helge Hafting" <helge.hafting@aitel.hist.no>, Valdis.Kletnieks@vt.edu,
       linux-kernel@vger.kernel.org
In-Reply-To: <9e4733910605240827w309c4dc7of42ea2def10960c9@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
	format=flowed
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20060519224056.37429.qmail@web26611.mail.ukl.yahoo.com>
	 <200605232338.54177.dhazelton@enter.net>
	 <21d7e9970605232108u27bc3ae7mbd161778c51afaf5@mail.gmail.com>
	 <200605240017.45039.dhazelton@enter.net>
	 <21d7e9970605232214l3349df0dka162f794f8eddf95@mail.gmail.com>
	 <9e4733910605240827w309c4dc7of42ea2def10960c9@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> But now it is a year latter and kernel graphics sits exactly where it
> was a year ago. There has been zero forward progress. The X developer
> obsession of reducing all OSes to a least common denominator is
> clearly holding back Linux graphics support. Merging DRM and fbdev is
> a win for Linux since it eliminates one of the places where two
> independent drivers are trying to control the same piece of hardware.
> The merging is blocked because of issues with DRM on BSD (merging
> would introduce GPL code into DRM which couldn't then be ported onto
> BSD without forking).

It has absolutely nothing to do with the GPL vs BSD licensing on the
code it has to do with the belief that fbdev isn't a complete enough
model to do what needs to be done and merging it into the DRM is just
going to make things worse rather than better, I've no idea where you
ever came up with it being a licensing thing at all... the FreeBSD ppl
have on interest in taking fbdev code anyways...

Having a shared layer allows the two drivers to at least discuss the
ownership of the hardware, we have two stacks of software, merging
them into one stack isn't going to solve any magical problems, it just
means we have one larger mess, my belief is once the two can
communicate, the DRM can disable fbdev if a proper solution on top of
the DRM becomes available...  merging fbdev into the DRM is always the
wrong answer, so please stop talking.

> I'm still sticking with my core driver principles:
> 1) One driver per device
> 2) A loaded driver must mark the device in use
> 3) Don't touch hardware that the driver doesn't own
> 4) Don't use root priv to bypass OS functions
> The current graphics code violates all of these

And that's nice for you, it isn't nice in the real world where we have
two drivers driving the device and need to fix it without breaking it
first.
>
> Blocking my changes has resulted in the loss of a full time developer
> from an area that is woefully understaffed. I would strongly suggest
> that anyone considering doing work in this area to learn from my
> experience. Since acceptance of any work you do is questionable, only
> work on tiny pieces. Then when your work is blocked you won't have
> lost months of effort. I would recommend doing no more that a week's
> work before trying to get it merged. And don't start on other changes
> while waiting on results from the first one. If the first one is
> blocked (likely) you don't want your second change depending on it.

That's called working in the kernel, it's always been like that, you
seemed to think your code wasn't going to require re-writes, it did,
you didn't agree with the maintainers suggestions stating you had all
those code depending on it working like you stated.. I could go on,
but I'm just wasting more of the small amounts of time I have to work
on this stuff.

Dave.
