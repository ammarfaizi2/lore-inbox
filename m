Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751094AbWDJJoU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751094AbWDJJoU (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Apr 2006 05:44:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751102AbWDJJoU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Apr 2006 05:44:20 -0400
Received: from nproxy.gmail.com ([64.233.182.188]:1818 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751094AbWDJJoT convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Apr 2006 05:44:19 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=DdEE/j7oydbqEFDQMi2TE6tX2OhZ57uJzKh2CrvUAWOFxAR+HXBhfTjJ7q5VjbEVSJ8/4XTGVXQarAZMyCEebYI43jorAx+OV6lU7YrWkhuYIJbGfN8WKSxiZCAi2AGGocYt0slXxJSnjIdqdsZ5HNck9n9PQhV5F9/VjefGszQ=
Message-ID: <69304d110604100244l691e0100o21007e4b852b7c42@mail.gmail.com>
Date: Mon, 10 Apr 2006 11:44:18 +0200
From: "Antonio Vargas" <windenntw@gmail.com>
To: "Andrew Morton" <akpm@osdl.org>
Subject: Re: Slow swapon for big (12GB) swap
Cc: "Grzegorz Kulewski" <kangur@polcom.net>, linux-kernel@vger.kernel.org
In-Reply-To: <20060410004030.5e48be79.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <Pine.LNX.4.63.0604091338030.31989@alpha.polcom.net>
	 <20060410004030.5e48be79.akpm@osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/10/06, Andrew Morton <akpm@osdl.org> wrote:
> Grzegorz Kulewski <kangur@polcom.net> wrote:
> >
> > I am using big swap here (as a backing for potentially huge tmpfs). And I
> >  wonder why swapon on such big (like 12GB) swap takes about 7 minutes
> >  (continuous disk IO).
>
> It's a bit quicker here:
>
> vmm:/usr/src/25# mkswap /dev/hda6
> Setting up swapspace version 1, size = 54031826 kB
> vmm:/usr/src/25# time swapon /dev/hda6
> swapon /dev/hda6  0.00s user 0.04s system 74% cpu 0.054 total
>
>
> > Is this expected?
>
> Nope.
>

I'm running swap on a 8G LVM logical volume and /tmp on tmpfs and it
works great (used for compilation & DVD-burning stagning area from
other hosts on the network), with no delays on swapon nor mount.


--
Greetz, Antonio Vargas aka winden of network

http://wind.codepixel.com/
windNOenSPAMntw@gmail.com
thesameasabove@amigascne.org

Every day, every year
you have to work
you have to study
you have to scene.
