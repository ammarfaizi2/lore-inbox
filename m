Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290930AbSAaFTH>; Thu, 31 Jan 2002 00:19:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290932AbSAaFS5>; Thu, 31 Jan 2002 00:18:57 -0500
Received: from relay1.pair.com ([209.68.1.20]:26632 "HELO relay.pair.com")
	by vger.kernel.org with SMTP id <S290930AbSAaFSo>;
	Thu, 31 Jan 2002 00:18:44 -0500
X-pair-Authenticated: 24.126.75.99
Message-ID: <3C58D50B.FD44524F@kegel.com>
Date: Wed, 30 Jan 2002 21:24:27 -0800
From: Dan Kegel <dank@kegel.com>
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.4.7-10 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Vincent Sweeney <v.sweeney@barrysworld.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: PROBLEM: high system usage / poor SMP network performance
In-Reply-To: <3C56E327.69F8B70F@kegel.com> <001901c1a900$e2bc7420$0201010a@frodo>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Vincent Sweeney wrote:
> So basically you are telling me these are my options:
> 
>     1) Someone is going to have to recode the ircd source we use and
> possibly a modified kernel in the *hope* that performance improves.
>     2) Convert the box to FreeBSD which seems to have a better poll()
> implementation, and where I could support 8K clients easily as other admins
> on my chat network do already.
>     3) Move the ircd processes to some 400Mhz Ultra 5's running Solaris-8
> which run 3-4K users at 60% cpu!
> 
> Now I want to run Linux but unless I get this issue resolved I'm essentialy
> not utilizing my hardware to the best of its ability.

No need to use a modified kernel; plain old 2.4.18 or so should do
fine, it supports the rtsig stuff.  But yeah, you may want to
see if the core of ircd can be recoded.  Can you give me the URL
for the source of the version you use?  I can peek at it.
It only took me two days to recode betaftpd to use Poller...

I do know that the guys working on aio for linux say they
have code that will make poll() much more efficient, so
I suppose another option is to join the linux-aio list and
say "So you folks say you can make plain old poll() more efficient, eh?
Here's a test case for you." :-)

- Dan
