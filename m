Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265655AbUBJNbP (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Feb 2004 08:31:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265865AbUBJNbO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Feb 2004 08:31:14 -0500
Received: from wombat.indigo.net.au ([202.0.185.19]:10765 "EHLO
	wombat.indigo.net.au") by vger.kernel.org with ESMTP
	id S265655AbUBJNbI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Feb 2004 08:31:08 -0500
Date: Tue, 10 Feb 2004 21:32:57 +0800 (WST)
From: Ian Kent <raven@themaw.net>
To: Mike Bell <kernel@mikebell.org>
cc: linux-kernel@vger.kernel.org
Subject: Re: devfs vs udev, thoughts from a devfs user
In-Reply-To: <20040210113417.GD4421@tinyvaio.nome.ca>
Message-ID: <Pine.LNX.4.58.0402102104050.5127@raven.themaw.net>
References: <20040210113417.GD4421@tinyvaio.nome.ca>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-MailScanner: Found to be clean
X-MailScanner-SpamCheck: not spam, SpamAssassin (score=-2.5, required 8,
	EMAIL_ATTRIBUTION, IN_REP_TO, QUOTED_EMAIL_TEXT, REFERENCES,
	REPLY_WITH_QUOTES, USER_AGENT_PINE)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Please lets not start another thread that gets us nowhere.

I'm only marginally familiar with devfs and I don't use on a day to day 
basis (but maybe I do now that I have a Gentoo install) but from what I 
have seen....

On Tue, 10 Feb 2004, Mike Bell wrote:

> 
> I keep hearing about how udev has no naming policy in the kernel, while
> devfs has a fixed one and if you don't like it tough. But udev relies on

>From what I can see devfs doesn't have much naming policy in the kernel. 
It appears to be mostly in devfsd.

> 
> Meanwhile, devfs (or a devfs-like solution) offer several things which
> udev just can't. Having a special kernel-exported filesystem just for
> /dev means your user-space daemon can see when a program is trying to
> access a device file that doesn't exist yet, you can't do that with
> udev and tmpfs. Moreover, it means you've got a functional /dev that
> accurately represents the system regardless of whether the user-space
> daemon is running yet. With udev, you're stuck with a static /dev unless
> udev is running. This can happen when broken system or doing a fresh
> installation, or if you accidentally break your udev binary. And heavens
> help you if linux ever moves to dynamic device files, that would make a
> static /dev completely unusable. Which would in turn mean that your
> system is unusable unless udev is running. It's not a big problem, but
> myself I find myself using devfs without devfsd for those two reasons
> every once in a while, and in those instances devfs is really nice.
> 

OK so udev is an alternative under active development. Good, life is all 
about choices.

> So the question is, is a devfs-like implementation really unfixable? And

Yes. I tried using devfs and see there is a lot of work to do to make it 
acceptable quality but .... see below ...

> 
> Finally, from /my/ experience, the one thing people disliked most about
> devfs was the long names for hard drive partitions. But isn't one of the

I happen to like those names.

> first things on the agenda for 2.7 taking the partition detection code
> out of the kernel and replacing it with device-mapper? If you do that,
> then the block devices you actually USE are all device mapper created.

Oh, more work before we begin.

> 
> Sorry if any of these points has already been discussed on
> linux-kernel, I don't have time to read the list so I'm going based on
> what's been reported in things like kernel-traffic.

There is another problem. There is no coherent support group to develop, 
test and disseminate the product. I've been subscribed to the mailing list 
for a while now and have seen only one message. Nothing is going to 
be fixed if the people that would like to use it don't get together to 
support it and develop it.

It's not as if people aren't making an effort. Andrey Borzenkov appears to 
have implemented some significant fixes for devfs and Bradley Chapman has 
been maintaining a branch of devfsd which is a much cleaner restructuring 
of the devfsd code. But Bradley has no way to get this code debugged and 
out to the user public.

So if devfs is needed by people then we must get together and do what is 
needed to support and develop the product.

Lets not forget that, at this point, udev is a recommended replacement for 
devfs, but is (I believe) still in development. So it may well happen 
that udev is an appropriate replacement for devfs at some point and that 
must be considered fairly and sensibly when the time comes.
 
Ian

