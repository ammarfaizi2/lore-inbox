Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131461AbRCNQ3W>; Wed, 14 Mar 2001 11:29:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131463AbRCNQ3N>; Wed, 14 Mar 2001 11:29:13 -0500
Received: from web11802.mail.yahoo.com ([216.136.172.156]:44039 "HELO
	web11802.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S131461AbRCNQ2q>; Wed, 14 Mar 2001 11:28:46 -0500
Message-ID: <20010314162805.93928.qmail@web11802.mail.yahoo.com>
Date: Wed, 14 Mar 2001 08:28:05 -0800 (PST)
From: Jeffrey Butler <jeffreymbutler@yahoo.com>
Subject: Re: poll() behaves differently in Linux 2.4.1 vs. Linux 2.2.14 (POLLHUP)
To: "David S. Miller" <davem@redhat.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <15022.53815.129522.746120@pizda.ninka.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

What version of Solaris should the poll() call behave
like?  I tried the test program that I posted in the
original post on this thread on a couple of versions
of Solaris, and they all behaved like Linux 2.2, not
Linux 2.4.

The following version strings are from sysinfo on the
Solaris machines that I tested:

Machine 1:
CPU Type is               sparcv8plus+vis
App Architecture is       sparc
Kernel Architecture is    sun4u
OS Name is                SunOS
OS Version is             5.7
OS Distribution is        Solaris 7 5/99
s998s_u2SunServer_09 SPARC
Kernel Version is         SunOS Release 5.7 Version
Generic_106541-11 [UNIX(R) System V Release 4.0]

Machine 2:
SunOS xxx.xxx.xxx.xxx 5.5.1 Generic_103640-29 sun4u
sparc SUNW,Ultra-5_10.

Does Linux 2.4 poll() behave like Solaris 8 poll()
with respect to poll()?  If I had access to a Solaris
8 machine I would have tested it because I realize the
Solaris versions are a bit out of date.

-jeff

--- "David S. Miller" <davem@redhat.com> wrote:
> 
> Jeffrey Butler writes:
>  >   I've noticed that poll() calls on IPv4 sockets
> do
>  > not behave the same under linux 2.4 vs. linux
> 2.2.14. 
>  > Linux 2.4 will return POLLHUP for a socket that
> is not
>  > connected (and has never been connected) while
> Linux
>  > 2.2 will not.
>  >   The following example program demonstrates the
>  > problem when it's run under linux 2.4:
> 
> True, this behavior was changed from 2.2.x.  We now
> match the behavior
> of other svr4 systems, in particular Solaris.  This
> new behavior in
> 2.4.x will not change.
> 
> Later,
> David S. Miller
> davem@redhat.com


__________________________________________________
Do You Yahoo!?
Yahoo! Auctions - Buy the things you want at great prices.
http://auctions.yahoo.com/
