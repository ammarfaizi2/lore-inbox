Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313089AbSDTTNX>; Sat, 20 Apr 2002 15:13:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313132AbSDTTNW>; Sat, 20 Apr 2002 15:13:22 -0400
Received: from sproxy.gmx.net ([213.165.64.20]:6409 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id <S313089AbSDTTNV>;
	Sat, 20 Apr 2002 15:13:21 -0400
Subject: 32-bit process ids (was: Re: idea to enhance get_pid())
From: Dan Aloni <da-x@gmx.net>
To: dank@kegel.com
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <3CC1AA5C.1DE5C69D@kegel.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 
Date: 20 Apr 2002 22:12:14 +0300
Message-Id: <1019329937.24728.111.camel@callisto.yi.org>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2002-04-20 at 20:50, Dan Kegel wrote:

> I'd like to know more about that bash bug; do you have a URL for it?
> (Is there even a bug tracking system for bash?)
> I looked a bit on gnu.bash.bugs, and found two possibly related
> patches; do these have anything to do with the bug?
> http://groups.google.com/groups?selm=200104130734.AAA12931%40shade.twinsun.com
> http://groups.google.com/groups?selm=200104130854.BAA18368%40shade.twinsun.com

In a post by Linus from 2 years ago, concerning the bash bug 
( http://lwn.net/2000/0120/a/lt-pid.html ), he also writes about
what holds from switching to 32 bit pids. and it's mainly 
because it's unclear about the way pids should be handled in 
a clustering environment.

According to the kernel patch made by the people at Cluster
Infrastructure ( http://ci-linux.sourceforge.net/ ), today 
it is clear that the upper 16 bits of the pid are used for the node
number. 

Linus should consider applying Andries Brouwer's patch from October:
( http://marc.theaimsgroup.com/?l=linux-kernel&m=100274734125520&w=2 )
This is really 2.5 material, but it slipped away for no apparent reason.


