Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268304AbTGIN4i (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Jul 2003 09:56:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268260AbTGIN4h
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Jul 2003 09:56:37 -0400
Received: from angband.namesys.com ([212.16.7.85]:31399 "EHLO
	angband.namesys.com") by vger.kernel.org with ESMTP id S268270AbTGIN4d
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Jul 2003 09:56:33 -0400
Date: Wed, 9 Jul 2003 18:11:11 +0400
From: Oleg Drokin <green@namesys.com>
To: Stephan von Krawczynski <skraw@ithnet.com>
Cc: mason@suse.com, linux-kernel@vger.kernel.org
Subject: Re: 2.4.22-pre3 and reiserfs boot problem
Message-ID: <20030709141111.GK18307@namesys.com>
References: <20030706183453.74fbfaf2.skraw@ithnet.com> <1057515223.20904.1315.camel@tiny.suse.com> <20030709140138.141c3536.skraw@ithnet.com> <1057757764.26768.170.camel@tiny.suse.com> <20030709134837.GJ18307@namesys.com> <20030709155803.2d1569a8.skraw@ithnet.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030709155803.2d1569a8.skraw@ithnet.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

On Wed, Jul 09, 2003 at 03:58:03PM +0200, Stephan von Krawczynski wrote:
> > > Step one is to figure out if the problem is reiserfs or 3ware.  Instead
> > > of mounting the filesystem, run debugreiserfs -d /dev/xxxx > /dev/null
> > > and see if you still hang.
> > > This will read the FS metadata and should generate enough io to trigger
> > > the hang if it is a 3ware problem.
> Ok, I tried this. debugreiserfs runs without any problems. Disks show quite an
> activity, the whole thing lasts 1-2 minutes.
> mount afterwards shows the same hang.

Hm.

> > Or if this one suceeds, then may be reiserfsck --check /dev/xxxx to get
> > journal replayed. This is in case access pattern matters.
> I can try that, too. What do you expect to see?

Well, it will either hang or not, I think.
It it won't hang, this will complicate matters.
Then next step would be probably to try and mount the partition from usermodelinux if you are able
to conduct such a test.
I am still pretty skeptical about the possibility that recent reiserfs changes broke stuff.

Bye,
    Oleg
