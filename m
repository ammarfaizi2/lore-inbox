Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132861AbRDPGdg>; Mon, 16 Apr 2001 02:33:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132862AbRDPGd0>; Mon, 16 Apr 2001 02:33:26 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:1630 "EHLO
	flinx.biederman.org") by vger.kernel.org with ESMTP
	id <S132861AbRDPGdR>; Mon, 16 Apr 2001 02:33:17 -0400
To: Patrick Shirkey <pshirkey@boosthardware.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Files not linking/replacing.
In-Reply-To: <3ADA524A.7038A81C@boosthardware.com>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 16 Apr 2001 00:31:53 -0600
In-Reply-To: Patrick Shirkey's message of "Mon, 16 Apr 2001 11:00:42 +0900"
Message-ID: <m1eluttkx2.fsf@frodo.biederman.org>
User-Agent: Gnus/5.0803 (Gnus v5.8.3) Emacs/20.5
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Patrick Shirkey <pshirkey@boosthardware.com> writes:

> Hi.
> 
> I hope this is the correct place to report to.
> 
> I have installed kernel 2.4.3 but my system is having a few problems
> compiling things. Not all software is having problems it just seems to
> be the most important ones. like mozilla or alsa-driver, I would like to
> try others to test this but it's kind of frustrating and time consuming.
> 
> I installed the kernel in /usr/local/src because the install file says
> not to do it in /usr/src anymore because of kernel header dependencies.
> 
> The system is booting and obviously I can use the net but the main
> problem seems toi be that a lot of important files have not benn updated
> or relinked to the right dir.
> 
> I installed the new kernel onto Mandrake 7.0 which ships with 2.2.14.
> 
> I'm using a PIII
> and have verified that my software is upto the minimal requirements
> according to the /documentation/changes file. All except mkinitrd which
> I can't install becuse I have an old version of rpm and cannot find the
> tar.gz file on the net.
> 
> An example of what my system is doing:
> 
> I compile the latest stable mozilla.
> First off it complains that /usr/include/bits/errno.h doesn't point to
> the right place.
> So I remove it and link /usr/local/src/linux/include/asm/errno.h to
> /usr/include/bits/errno.h and recompile.
> It gets past that point then complains about /usr/include/bits/socket.h
> so I repeat the process.
> 
> The futility of doing this occurs to me. So I write in to this list in
> the hope that someone may know what I have done wrong or can offer me
> some help to debug.
> 
> Any ideas?

Normally /usr/src/linux on a redhat system contains a kernel with a
known good set of kernel headers.  /usr/include/linux and 
/usr/include/asm are symlinks that point into the known good kernel
headers.  It looks like you removed your known good 2.2.14 known good
kernel headers, or the symlinks to them.

Eric
