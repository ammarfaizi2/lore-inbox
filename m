Return-Path: <owner-linux-kernel-outgoing@vger.rutgers.edu>
Received: by vger.rutgers.edu via listexpand id <S156093AbQBUV4H>; Mon, 21 Feb 2000 16:56:07 -0500
Received: by vger.rutgers.edu id <S156019AbQBUTBT>; Mon, 21 Feb 2000 14:01:19 -0500
Received: from sgi.SGI.COM ([192.48.153.1]:6205 "EHLO sgi.com") by vger.rutgers.edu with ESMTP id <S154978AbQBUPBy>; Mon, 21 Feb 2000 10:01:54 -0500
Message-ID: <38B18C71.80157FD3@sgi.com>
Date: Mon, 21 Feb 2000 11:05:21 -0800
From: Casey Schaufler <casey@sgi.com>
Organization: Silicon Graphics
X-Mailer: Mozilla 4.7C-SGI [en] (X11; I; IRIX 6.5-ALPHA-1276146520 IP32)
X-Accept-Language: en
MIME-Version: 1.0
To: Sandy Harris <sandy@storm.ca>, linux-kernel@vger.rutgers.edu
Subject: Re: Userland encrypted filesystem that root cannot access.
References: <Pine.LNX.4.10.10002191851530.786-100000@asdf.capslock.lan> <88nmsc$7k5nc@fido.engr.sgi.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: owner-linux-kernel@vger.rutgers.edu

Sandy Harris wrote:

> The authoritative reference is at:
> 
> http://www.radium.ncsc.mil/tpep/library/rainbow/5200.28-STD.html#HDR2.1.1
> 

> For C2 we'd need quite a lot of work.

It's not really as bad as all that. It would be quite a bit for
an individual to try to accomplish, but on the scale of corporate
efforts it's not so bad. It's been done to every commercial OS
(including NT).

> Extensive security auditing,

Audit is a large task, with kernel components, application changes,
a daemon or two, and a whole lot of analysis to make sure you got
everything. Oh, and no small amount of administrator documentation.
On the other hand, a Linux audit trail will be much simpler than
a Vnode based system was.

> dump things that cannot pass,

Chucking programs that don't meet this minimal level of security
is a very satisfying experiance. Except for those programs which
implement and enforce policy (login, su, sendmail, ...) it's pretty
hard for a program to fail the C2 criteria.

What's difficult is that the assumption made in the Trust Technology
world is that a program is bad, unless you can describe why it is good.
This means that any program you decide to trust (include in your
Trusted Computing Base (TCB)) requires a security analysis be written.
A security analysis is generally pretty easy to write once you have a
policy defined.

> add some patches and perhaps some utilities,
> and do a lot more documentation and testing.

Just documentation to stake a claim about what you
expect the system to do relative to your security policy.
Then, enough testing to show that the system implements those claims.
It does have to be complete, however.

> Probably only a major distribution vendor could do this.

There would certainly need to be a distribution. You need to
provide some assurance that the binaries match the source, for
example. You also have to show that you can reproduce the bits.

> You'd need to
> control what goes into a distribution (no un-audited stuff) and you'd
> need considerable resources.

Packages which are developed without revision control or distributed
as binary only would be right out. The distributor would have to do
commercial grade configuration management and control.

> For the B levels we'd need some basic re-design.

Nah. The only missing feature is Mandatory Access Control, and
everybody and their uncle's done that at least twice. Networking's
the only tricky bit, and while there are no standards (IPSEC isn't
done yet, and may never settle in) there is common practice.

The reason that we commercial vendors all developed B1 systems is
that the additional cost over C2 is so small.

> But the Rainbow Series of books are being superceded by the Common
> Criteria:
> 
> http://www.radium.ncsc.mil/tpep/library/ccitse/index.html

Indeed.

C2 is replaced by the Controlled Access Protection Profile (CAPP) and
B1 is replaced by Labeled Security Protection Profile (LSPP).
Evaluations are being done by licensed laboratories rather than by
the NSA. The documentation required is more formal, but the total
weight is less.

I will personally keep saying C2 and B1 because I'm old, they're
what I'm used to, and it's what those pesky customers keep asking for.

Someone will have a candidate C2 distribution by the end of 2000.
Has to happen for Linux (any OS) to compete in the european market.
I expect a candiate B1 early 2001. We are working toward those goals
here at SGI.

-- 

Casey Schaufler				Manager, Trust Technology, SGI
casey@sgi.com				voice: (650) 933-1634

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.rutgers.edu
Please read the FAQ at http://www.tux.org/lkml/
