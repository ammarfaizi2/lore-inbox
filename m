Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262648AbUEQTsa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262648AbUEQTsa (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 May 2004 15:48:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262634AbUEQTsa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 May 2004 15:48:30 -0400
Received: from dsl092-053-140.phl1.dsl.speakeasy.net ([66.92.53.140]:50560
	"EHLO grelber.thyrsus.com") by vger.kernel.org with ESMTP
	id S262794AbUEQTr6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 May 2004 15:47:58 -0400
From: Rob Landley <rob@landley.net>
To: John Bradford <john@grabjohn.com>,
       Rene Rebe <rene@rocklinux-consulting.de>
Subject: Re: Distributions vs kernel development
Date: Wed, 12 May 2004 14:11:59 -0500
User-Agent: KMail/1.5.4
Cc: shemminger@osdl.org, linux-kernel@vger.kernel.org, rock-user@rocklinux.org
References: <409BB334.7080305@pobox.com> <20040509.105253.26927810.rene@rocklinux-consulting.de> <200405091053.i49ArBnh000172@81-2-122-30.bradfords.org.uk>
In-Reply-To: <200405091053.i49ArBnh000172@81-2-122-30.bradfords.org.uk>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200405121412.00068.rob@landley.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 09 May 2004 05:53, John Bradford wrote:

> > And no, it is not like Gentoo where you need to rebuild on each box or
> > so.
>
> I keep hearing about projects which I hope will be what you describe above
> for ROCK Linux.  Unfortunately, I haven't found one that goes far enough in
> that direction yet.  Maybe there just isn't the demand for it these days.

As a side effect of debugging busybox, I created a shellscript that compiles a 
stripped down Linux From Scratch system entirely from source.

By "debugging busybox" I mean upgrading it so that it can be used to replace 
the corresponding gnu packages (coreutils, patch, bash, diffutils, gawk, sed, 
bzip, findutils, grep, tar, util-linux...) and then an actual development 
environment (binutils, gcc, make, etc) built on top of that and the whole 
system successfully recompiled with itself.

I recently got it working to the point where you can chroot into the resulting 
system, and posted a version of the script to the busybox list a few days 
ago.  I have an upgraded version (based on Mariusz Mazur's 2.6.5.1 kernel 
headers and a lot of cleanups), and will be posting the script along with my 
current source tarball as soon as I figure out the best place to put a 134 
megabyte file that may be downloaded more than once.  (I need to attach a 
proper server to my cable modem, but this project is what I want to use, so 
there's a chicken and egg problem here... :)

I didn't know about Rock Linux until now.  I intend to look into it as soon as 
I clear my to-do list a bit, and maybe try to converge what I'm doing with 
that.

As for the rest of your article: don't assume that trading a familiar set of 
problems for an unfamiliar set of problems automatically solves more than it 
causes.  Build from source has more potential, sure.  And when the standard 
laptop has a 10 ghz 64 bit processor and 4 gigabytes of ram, it'll make a lot 
of sense (although compiling KDE or anything from the FSF will still suck).  
But compiling stuff from source is HEAVILY dependent on sequencing; 
./configure won't add ncurses support unless you installed ncurses first.  
How much stuff do you rebuild because you just added openssl, or switched to 
alsa from oss?  How do you keep track of the dependencies so it CAN rebuild?

If your build system is a static command set like my shellscript, "build this 
list of packages in this order", how much of an improvement is this really 
over a binary distro?  (Improvement, yes.  Panacea, no.)

Binary system bundlers protect people from a HUGE amount of crap.  Dragging 
this back on topic by the scruff of the neck, trying to get uclibc to work 
with a 2.6 kernel without having a 2.4 kernel on the box to loot headers from 
involves tracking down a third package just for the cleaned up headers.  Just 
knowing that you NEED to do that is black magic.  Grandma ain't dealing with 
this any time soon.  (Although mine have both taken to the internet 
remarkably well.  Both from windows machines, one via AOL...)

Rob

P.S.  I've looked at gentoo on several occasions.  Even downloaded the CD and 
tried to get up enthusiasm for inflicting it upon my laptop.  I've done Linux 
from scratch since version 3.0.  I've automated Linux From Scratch builds in 
various contexts for about four years now.  Installing Gentoo is just too 
much like work.

-- 
www.linucon.org: Linux Expo and Science Fiction Convention
October 8-10, 2004 in Austin Texas.  (I'm the con chair.)


