Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317964AbSFSSDV>; Wed, 19 Jun 2002 14:03:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317965AbSFSSDU>; Wed, 19 Jun 2002 14:03:20 -0400
Received: from sweetums.bluetronic.net ([66.57.88.6]:53655 "EHLO
	sweetums.bluetronic.net") by vger.kernel.org with ESMTP
	id <S317964AbSFSSDS>; Wed, 19 Jun 2002 14:03:18 -0400
Date: Wed, 19 Jun 2002 14:01:07 -0400 (EDT)
From: Ricky Beam <jfbeam@bluetronic.net>
To: Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>
cc: Toby Inkster <tobyink@goddamn.co.uk>, <linux-kernel@vger.kernel.org>
Subject: Re: .i2c-old.ver.d: No such file or directory
In-Reply-To: <Pine.LNX.4.44.0206171307100.22308-100000@chaos.physics.uiowa.edu>
Message-ID: <Pine.GSO.4.33.0206191345560.10816-100000@sweetums.bluetronic.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 17 Jun 2002, Kai Germaschewski wrote:
>On Mon, 17 Jun 2002, Toby Inkster wrote:
>> Below are the last few lines of output before the errors start. I can send my .config if anyone thinks it might help.
...
>> i2c-old.c:17:27: linux/i2c-old.h: No such file or directory
>
>The problem is that the i2c code is currently broken, it includes
>linux/i2c-old.h which doesn't exist. You'll see the error much more
>clearly if you run "make KBUILD_VERBOSE= dep" ;)

Yes.  This is due to the "New and Improved Build System (tm)". (It's not
really new -- kbuild has been around as an option for a long time.  And
it's very certainly *not* currently an improvement.)  Get used to a lot
being broken in interesting ways for a while.

I just love the way the road to progress is paved with a high density of
nuclear land mines.  What a very lovely mess kbuild integration is creating.

I like the idea of "build in one pass", but that's kind of annoying in a
very broken development branch.  When I enter "make bzImage" that and only
that is what I (and almost everyone who builds kernels) expect to be built.

As one who used to manage source code for a living, let me share a simple
rule: never break the build system; when the build is broken, NO ONE gets
anything done.  One cannot completely replace a build environment over
night. (esp. when there are as many fingers in the pie as Linux.)

--Ricky


