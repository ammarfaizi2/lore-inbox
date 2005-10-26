Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964933AbVJZUzB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964933AbVJZUzB (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Oct 2005 16:55:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964932AbVJZUzB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Oct 2005 16:55:01 -0400
Received: from xproxy.gmail.com ([66.249.82.206]:57654 "EHLO xproxy.gmail.com")
	by vger.kernel.org with ESMTP id S964929AbVJZUys convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Oct 2005 16:54:48 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=gYgPFQGJhdi/n77Aa2mOtshgpLUi/Je4MO8NfZmjD1Hzz7Dpf7ote8gwRC5Z8tJUbs8kKNzS9sC4HqvfXtg+TUxLnEn+sIWkporPs80HJANi1WLFaNDEYgWhU/m6KV+BhKC7RwxlWHcTcmQsty9Rufzho2KOufvpmPLk8r5GY+4=
Message-ID: <5a4c581d0510261354n2ba47a8fr31ae55506980b077@mail.gmail.com>
Date: Wed, 26 Oct 2005 22:54:47 +0200
From: Alessandro Suardi <alessandro.suardi@gmail.com>
To: Dave Airlie <airlied@gmail.com>
Subject: Re: X unkillable in R state sometimes on startx , /proc/sysrq-trigger T output attached
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>
In-Reply-To: <21d7e9970510261225r6b84bc1at4bbb2d7c3754a759@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <5a4c581d0510251335ke8e7ae6n883e0b44a9920ce4@mail.gmail.com>
	 <21d7e9970510260325o2a47e6f5gc64d29eec42de086@mail.gmail.com>
	 <5a4c581d0510260522h3c98d1acsf4715a4d4865121c@mail.gmail.com>
	 <21d7e9970510260528k37cffb12h24d7b6fad7f3ed6e@mail.gmail.com>
	 <5a4c581d0510260620o1a6ad678v6966dba3f40e8601@mail.gmail.com>
	 <21d7e9970510261225r6b84bc1at4bbb2d7c3754a759@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/26/05, Dave Airlie <airlied@gmail.com> wrote:
> >
> > > if you just run X, does it always start to the X cursor without hanging..
> >
> > Will try. Note however, when I experience the problem X doesn't
> >  really "hang" - it spins in CPU.
>
> That's a hang from the graphics developers point of view, your
> graphics card has crashed and X is spinning waiting for the card to
> come back and say it is okay.. something it never does...

OK, thanks for the clarification.

> > For that matter, I'm running it now without issues... it
> >  seems to get in the weird state only on startup.
>
> I probably restart X about 5-10 times per working session and I've
> never seen this yet, I'll do a few more reboots, we have a known issue
> with a bug fix that went into X and I'm not sure if it is in your X
> packages but it probably is.. can you tell me the FC4 xorg rpm titles
> so I can check it, if it causing problems on AGP systems as well I'll
> be pushing RH to release new X packages with a proper fix, that benh
> is working on at the moment..

Sure, here you go:

[asuardi@incident ~]$ grep xorg /var/log/rpmpkgs
fonts-xorg-100dpi-6.8.2-1.noarch.rpm
fonts-xorg-75dpi-6.8.2-1.noarch.rpm
fonts-xorg-base-6.8.2-1.noarch.rpm
xorg-x11-6.8.2-37.FC4.49.2.i386.rpm
xorg-x11-deprecated-libs-6.8.2-37.FC4.49.2.i386.rpm
xorg-x11-devel-6.8.2-37.FC4.49.2.i386.rpm
xorg-x11-font-utils-6.8.2-37.FC4.49.2.i386.rpm
xorg-x11-libs-6.8.2-37.FC4.49.2.i386.rpm
xorg-x11-Mesa-libGL-6.8.2-37.FC4.49.2.i386.rpm
xorg-x11-Mesa-libGLU-6.8.2-37.FC4.49.2.i386.rpm
xorg-x11-tools-6.8.2-37.FC4.49.2.i386.rpm
xorg-x11-twm-6.8.2-37.FC4.49.2.i386.rpm
xorg-x11-xauth-6.8.2-37.FC4.49.2.i386.rpm
xorg-x11-xfs-6.8.2-37.FC4.49.2.i386.rpm

It looks like I installed these packages around Sep 22,
 but I honestly can't remember whether the first of these
 occurrences happened after the installation or before.

Thanks a lot, ciao,

--alessandro

 "All it takes is one decision
  A lot of guts, a little vision to wave
  Your worries, and cares goodbye"

   (Placebo - "Slave To The Wage")
