Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280823AbRKZFWP>; Mon, 26 Nov 2001 00:22:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281012AbRKZFWG>; Mon, 26 Nov 2001 00:22:06 -0500
Received: from cc361913-a.flrtn1.occa.home.com ([24.0.193.171]:8596 "EHLO
	mirai.cx") by vger.kernel.org with ESMTP id <S280823AbRKZFWB>;
	Mon, 26 Nov 2001 00:22:01 -0500
Message-ID: <3C01D177.98E82405@pobox.com>
Date: Sun, 25 Nov 2001 21:21:59 -0800
From: J Sloan <jjs@pobox.com>
Organization: J S Concepts
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.16-pre1 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linuxlist@visto.com
CC: linux-kernel@vger.kernel.org
Subject: [OT] Re: no inetd.conf file
In-Reply-To: <3BE1CB8E0013F650@iso2.vistocorporation.com> (added by
		    administrator@vistocorporation.com)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

rohit prasad wrote:

> Hi,
>
>  I have installed 2.4.7 version of the kernel in my machine.
> I am facing a problem with telnet where all connections are refused.

Sounds like iptables and tcp wrappers are working?

Or you haven't enabled telnetd?

>  When I grep for telnetd there is no telnetd  running.

No, it wouldn't be running unless someone
has connected via telnet.

> If I try to start it the error reported is ,
>
> "telnetd:getpeername:socket operation on non-socket"

Right you don't start telnet by hand, its
invoked from inetd,or rather xinetd.

> I checked for the inetd.conf file it is not present in the /etc directory.

inetd has been replaced by xinetd, which
does seem to have some advantages.

>  I want to know does this xinetd.conf file helps or,
> what else could I do to start telnetd.

Why not run "ntsysv",  and select telnet?

Or, edit /etc/xinetd.d/telnet and then type
"service xinetd restart".

> I have done a "Everything" (All packages) installation of RH7.2 but no inetd.conf

That's as it should be

There is one thing - telnet is not a good thing
to have running, you really want to use secure
shell instead. If you have any concern at all
for security that is.

Finally, this has nothing to do with kernel
development, so try to reserve this list
for actual kernel related questions.

cu

jjs


