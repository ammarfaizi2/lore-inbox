Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262068AbTIHIRl (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Sep 2003 04:17:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262074AbTIHIRl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Sep 2003 04:17:41 -0400
Received: from mail.cs.tu-berlin.de ([130.149.17.13]:21702 "EHLO
	mail.cs.tu-berlin.de") by vger.kernel.org with ESMTP
	id S262068AbTIHIRj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Sep 2003 04:17:39 -0400
Date: Mon, 8 Sep 2003 10:15:08 +0200 (MEST)
From: Peter Daum <gator@cs.tu-berlin.de>
Reply-To: Peter Daum <gator@cs.tu-berlin.de>
To: Dave Jones <davej@redhat.com>
cc: Andi Kleen <ak@suse.de>, Adrian Bunk <bunk@fs.tum.de>,
       <marcelo.tosatti@cyclades.com.br>, <linux-kernel@vger.kernel.org>
Subject: Re: [2.4 patch] fix CONFIG_X86_L1_CACHE_SHIFT
In-Reply-To: <20030907213924.GA28927@redhat.com>
Message-ID: <Pine.LNX.4.30.0309080934410.5064-100000@swamp.bayern.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Sun, 7 Sep 2003, Dave Jones wrote:

> *nod*. This 'fix' also papers over the bug instead of fixing it.
> Likely it's something like a network card driver setting its cacheline
> size incorrectly. Peter what NIC did you see the problem on ?

All the machines have Forerunner LE ATM NICs and use LAN
Emulation. I made an attempt to check whether the problems also occur
with ethernet, but for some reason the ethernet card also
didn't seem to work with 2.4.22. Maybe I should give this another
try ...

As mentioned, Adrian's patch for "CONFIG_X86_L1_CACHE_SHIFT"
seems to fix my current networking problems, but maybe the real
cause is something else.

Since somebody here mentioned "memory corruption": Already for
years I have been plagued by a bug somewhere in the ATM/LANE code
that causes the machines to crash from time to time (see
http://sourceforge.net/tracker/index.php?func=detail&aid=445059&group_id=7812&atid=107812)

I could not discover any pattern, when and under which
circumstances these crashes happen (usually, they occur with
several months in between) Several times, I managed to get at
least a stack trace, but the actual crashes occured at different
places in the code (which, I guess, could mean that the real
problem is somebody overwriting somebody elses memory). Could
there be any connection?

If somebody has any good idea how to find out, what is going on,
I'll be glad to investigate this further. At least, with my
current networking problems (see the thread "2.4.22 with
CONFIG_M686: networking broken") I have a test case ...

Regards,
               Peter Daum

