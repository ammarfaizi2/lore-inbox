Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266206AbRGAX0E>; Sun, 1 Jul 2001 19:26:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266207AbRGAXZz>; Sun, 1 Jul 2001 19:25:55 -0400
Received: from neon-gw.transmeta.com ([209.10.217.66]:7175 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S266206AbRGAXZp>; Sun, 1 Jul 2001 19:25:45 -0400
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [Re: gcc: internal compiler error: program cc1 got fatal signal 11]
Date: 1 Jul 2001 16:25:32 -0700
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <9hobhc$7p3$1@cesium.transmeta.com>
In-Reply-To: <200106291248.HAA02327@tomcat.admin.navo.hpc.mil> <20010629142055.49246.qmail@web13907.mail.yahoo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Disclaimer: Not speaking for Transmeta in any way, shape, or form.
Copyright: Copyright 2001 H. Peter Anvin - All Rights Reserved
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <20010629142055.49246.qmail@web13907.mail.yahoo.com>
By author:    szonyi calin <caszonyi@yahoo.com>
In newsgroup: linux.dev.kernel
> 
> Almost always ?
> It seems like gcc is THE ONLY program which gets
> signal 11
> Why the X server doesn't get signal 11 ?
> Why others programs don't get signal 11 ?
> 

gcc happens to be one of the best memory testers known to man -- much
better than most other programs.  A big reason for that is that it
accesses lots of memory in funny patterns, *AND* accesses to it are
likely to be fatal.

It is just the way it is.  gcc doing the signal 11 is HIGHLY
correlated with the hardware you are running on, which means it's
*usually* hardware-related.

> [... Lots of M$ flames ignored ...]

> Some time ago I installed Linux (Redhat 6.0) on my pc (Cx486 8M RAM)
> and gcc had a lot of signal 11 (a couple every hour) I was upgrading
> the kernel every time there was a new kernel and from 2.2.12(or 14)
> no more signal 11 (very rare) Is this still a hardware problem ?
> Was a bug in kernel ?
> 
> I think the last answer is more obvious.(or the gcc
> had a bug and the kernel -- a workaround).

Most likely is that your *hardware* had a bug and the new kernel a
workaround (this is quite common), but without more detail it is very
hard to know.

	-hpa
-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
http://www.zytor.com/~hpa/puzzle.txt
