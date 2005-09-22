Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030459AbVIVRhr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030459AbVIVRhr (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Sep 2005 13:37:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030460AbVIVRhr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Sep 2005 13:37:47 -0400
Received: from bayc1-pasmtp02.bayc1.hotmail.com ([65.54.191.162]:61733 "EHLO
	BAYC1-PASMTP02.BAYC1.HOTMAIL.COM") by vger.kernel.org with ESMTP
	id S1030459AbVIVRhq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Sep 2005 13:37:46 -0400
Message-ID: <BAYC1-PASMTP0225E685AD4FA9108A11B1AE970@CEZ.ICE>
X-Originating-IP: [67.71.125.52]
X-Originating-Email: [seanlkml@sympatico.ca]
Message-ID: <44657.10.10.10.28.1127410663.squirrel@linux1>
In-Reply-To: <200509221212.01811.gene.heskett@verizon.net>
References: <200509221514.44027.roffermanns@sysgo.com>
    <200509221131.41838.gene.heskett@verizon.net>
    <4332D447.6050503@adaptec.com>
    <200509221212.01811.gene.heskett@verizon.net>
Date: Thu, 22 Sep 2005 13:37:43 -0400 (EDT)
Subject: Re: Linus GIT tree disappeared from http://www.kernel.org/git/?
From: "Sean" <seanlkml@sympatico.ca>
To: "Gene Heskett" <gene.heskett@verizon.net>
Cc: linux-kernel@vger.kernel.org
User-Agent: SquirrelMail/1.4.4-2
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Priority: 3 (Normal)
Importance: Normal
X-OriginalArrivalTime: 22 Sep 2005 17:37:13.0796 (UTC) FILETIME=[44ADA040:01C5BF9C]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, September 22, 2005 12:12 pm, Gene Heskett said:

> Well, I think what I was trying to ask but got lost in the bushes was
> "do I have a valid download?"  and, how do I go about keeping it upto
> date now that I have it?  I've read about half the git.txt stuff in
> the Documentation dir, but nothing sticks out as being the magic
> updater command.

Gene,

In order to update your copy of the kernel repository just run "git pull".
   Unfortunately there still seem to be some issues with kernel.org,
hopefully that'll be fixed up soon.

The warning you're getting from git about "alternates" will be fixed in
the next release of git.   You _could_ use your current version of git to
track the official git repository and get this fix before it's officially
released:

$ cd ~
$ git clone rsync://rsync.kernel.org/pub/scm/git/git.git/ git-repo
$ cd git-repo
$ git checkout
$ make install

Which should upgrade your current version of git to the very latest. 
After which you can upgrade git whenever you like by running:

$ cd ~/git-repo
$ git pull
$ make install

Cheers,
Sean

