Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273029AbRIIUXe>; Sun, 9 Sep 2001 16:23:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273031AbRIIUXY>; Sun, 9 Sep 2001 16:23:24 -0400
Received: from mailout01.sul.t-online.com ([194.25.134.80]:50188 "EHLO
	mailout01.sul.t-online.de") by vger.kernel.org with ESMTP
	id <S273029AbRIIUXN>; Sun, 9 Sep 2001 16:23:13 -0400
Message-ID: <3B9BCF6C.3BFC9466@t-online.de>
Date: Sun, 09 Sep 2001 22:22:04 +0200
From: SPATZ1@t-online.de (Frank Schneider)
X-Mailer: Mozilla 4.76 [de] (X11; U; Linux 2.4.3-test i686)
X-Accept-Language: en
MIME-Version: 1.0
To: rvandam@liwave.com
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: FW: OT: Integrating Directory Services for Linux
In-Reply-To: <001001c1395f$a246cd70$1f0201c0@w2k001>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ron Van Dam schrieb:
> 

(DS into Kernel for simplifying Management)

> I know some one out there is comparing this concept to the Windows registry.
> I was thinking that this would be a distributed database with journalling,
> with all of the checks of a filesystem to protect the database. The database
> would also need to be extensible so that userland developers can import
> schema to extend the functionally of the database. For instance, the
> database could be used to manage a DHCP or DNS server, or  storing your user
> profile (.gnome or .kde) configurations. It should also support partitioning
> if I have multiple sites connected by a WAN, I can partition the database
> information so that only the essential information is replicated between
> sites and the WAN isn't clogged with replication traffic.
> 
> Comments?

Hello...

Some comments, yes :

1.) Why add an extra-DS-System to the existing ones ?
We have OpenLDAP, NDS (going down), ADS (going up, pushed by MS) and
NIS+ out there, plus things like X.500 or how they are called. Currently
Linux can work with most of them except ADS, AFAIK (better or worse with
some, but it can)
Why re-invent the wheel a 4th or even 5th time ?
I would say that linux is best at working together with nearly every
other OS or sec-application, so i would suggest that it gets linux
further if these connections and capabilities are extended, and not by
re-inventing something like ADS...

2.) I think these DS-Systems are really a part of userland, and the
kernel itself should never mess around with high-level-security issues
like Access Controll Lists or such things...this is the job of
userlandtools.
The problem i see, if you force these things into the kernel, you will
get a significant performance impact, because if you start to do
(perhaps complicated) securitychecks *everytime* before calling a single
function, you will loose time...and performance is one of the points
where linux is ahead of other OSes, IMHO.

3.) To the idea of a "linux-registry":
I do not like this, UNIX lives now 30 years with /etc and human-readable
configfiles and without a "database", and i think its a good compromise
between usability and "keep-it-simple".
And it works.
We see at WinXY, what problems a "registry" produce, e.g. to be usefull,
*every* application would have to use it (in the right way!), and we
see, this does not work, even not under W2k, where MS should have all
possibilities to prevent applications from messing around with the
registry, but it is still possible to crash a W2k by simply deleting
some strings....

Solong..
Frank.

--
Frank Schneider, <SPATZ1@T-ONLINE.DE>.                           
Microsoft isn't the answer.
Microsoft is the question, and the answer is NO.
... -.-
