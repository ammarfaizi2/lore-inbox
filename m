Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422740AbWCXJAx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422740AbWCXJAx (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Mar 2006 04:00:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422748AbWCXJAx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Mar 2006 04:00:53 -0500
Received: from zproxy.gmail.com ([64.233.162.194]:5240 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1422740AbWCXJAx convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Mar 2006 04:00:53 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=SiP52Ium/UKaj+OYgtdVSx2tK1Aqi2qilXqmg6powcLvjJxrCb49/a08aJpGuYcyjMZHiz3Eb+y+I3BYzeBqakQB+xvfadW7ZkGApqJLARlmdkQmhjdFmFy8/aids9l/f9j2Vu44LBPw5qOQ1l+rAaz6HePWNpZDwEdbTLh9lHM=
Message-ID: <9a8748490603240100v33097236v1ccc79871b285941@mail.gmail.com>
Date: Fri, 24 Mar 2006 10:00:26 +0100
From: "Jesper Juhl" <jesper.juhl@gmail.com>
To: "moreau francis" <francis_moreau2000@yahoo.fr>
Subject: Re: How to test vanilla kernel
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20060324082444.69962.qmail@web25812.mail.ukl.yahoo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20060324082444.69962.qmail@web25812.mail.ukl.yahoo.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/24/06, moreau francis <francis_moreau2000@yahoo.fr> wrote:
> I'm wondering how you folks, install and run the latest vanilla kernel.

There are many ways to test a kernel.

The most basic test would be to grab the kernel sources, build a new
kernel, install it, boot it & see if it blows up.

If you want to get a bit more advanced the kernel sources include a
few modules to stress test different parts of the infrastructure. You
can run those.

You can build your kernels with different (sometimes unusual)
configuration options to test if some combination of options produce
bad results.

You can also write a few apps that test the various syscalls. Use
fuzzers to pass in random values to syscalls and check for errors.
Write scripts/apps to create/delete lots of random files, dirs etc to
test filesystems.
Run benchmark apps on different kernel versions to test for
performance regressions.

In short, use your imagination and try to crash the kernel in various ways.
If you happen to provoke a crash, bug, other unwanted behaviour;
gather all the info, and send in a bug report - see
Documentation/ReportingBugs.


> I guess
> that people install their prefered distrib as a start point

Ofcourse, you need a working install before you start replacing your kernel.

> and then download
> the kernel sources.

Yup.

>But each distrib patch and update the kernel,

Many do, but not all of them, some ship vanilla kernels, like my
personal favorite, Slackware.

> is it safe to
> forget them ?
>
Unless you have something setup on your box which depends on
functionality patched into the kernel by your vendor, then yes,
running a vanilla kernel is perfectly OK - if it was not we'd never
get it tested ;-)


> BTW, is there a 'best' distrib to achieve that ?
>
No.
Use whatever distro you happen to prefer.


--
Jesper Juhl <jesper.juhl@gmail.com>
Don't top-post  http://www.catb.org/~esr/jargon/html/T/top-post.html
Plain text mails only, please      http://www.expita.com/nomime.html
