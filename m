Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273112AbRIJA1b>; Sun, 9 Sep 2001 20:27:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273111AbRIJA1V>; Sun, 9 Sep 2001 20:27:21 -0400
Received: from static004-9-151-24.nt02-c4.cpe.charter-ne.com ([24.151.9.4]:40732
	"EHLO Jupiter.LIWAVE.COM") by vger.kernel.org with ESMTP
	id <S273110AbRIJA1L>; Sun, 9 Sep 2001 20:27:11 -0400
Reply-To: <rvandam@liwave.com>
From: "Ron Van Dam" <rvandam@liwave.com>
To: "'Frank Schneider'" <SPATZ1@t-online.de>
Cc: <linux-kernel@vger.kernel.org>
Subject: RE: FW: OT: Integrating Directory Services for Linux
Date: Sun, 9 Sep 2001 20:27:21 -0400
Message-ID: <001501c1398f$5bb85c40$1f0201c0@w2k001>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook 8.5, Build 4.71.2173.0
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4133.2400
In-Reply-To: <3B9BCF6C.3BFC9466@t-online.de>
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Frank Schneider:
>>1.) Why add an extra-DS-System to the existing ones ?
>>We have OpenLDAP, NDS (going down), ADS (going up, pushed by MS) and
>>NIS+ out there, plus things like X.500 or how they are called. Currently
>>Linux can work with most of them except ADS, AFAIK (better or worse with
>>some, but it can)
>>Why re-invent the wheel a 4th or even 5th time ?

 Using ADS or NDS is not a good solution, because in my opinion, it would be
dependent on a another OS. I would rather have the DS maintained on a
OpenSource OS. NIS+ is basically obsolete. OpenLDAP could be turned into a
workable solution, but there is no "consistent" bridge between OpenLDAP and
Linux. For instance if you want to manager user accounts with it you need
PAM, and unfortunately PAM isn't compatible with a lot of userland
applications and services.

In my opinion, I don't see any way for directory services to become a fully
enabled tool without full support from all of the major Linux development
groups. I believe its going require a lot of effort to to make it a reality.
I don't think DS will work unless there some standard for DS established by
the core linux development groups. Another words, what I would like have is
the framework for a standard for implemeting DS for Linux.

>> I think these DS-Systems are really a part of userland, and the
>>kernel itself should never mess around with high-level-security issues
>>like Access Controll Lists or such things...this is the job of
>>userlandtools.

Agreed, the database any other tools can be done in userland and should be.
I started this discussion to see if anyone out there considers DS important
for Linux growth.  I am not sugguesting that this should be in the kernel.
Just some sort of directory system that can manage configurations of a large
number of linux boxes.

However, I don't see how you can manage permissions to kernel function calls
with out some kernel support. Depending on what level of functionally is
included, there may be a need access database information during boot-up,
before userland processes can be started. If you managing kernel functions
calls for userland access, how can you tell if the process has permissions
unless some functionally is built-in the kernel? Think of a directory
service operating more like a file system than a database.

>>The problem i see, if you force these things into the kernel, you will
>>get a significant performance impact, because if you start to do
>>(perhaps complicated) securitychecks *everytime* before calling a single
>>function, you will loose time...and performance is one of the points
>>where linux is ahead of other OSes, IMHO.

You're probably right. Perhaps groups of function calls could be grouped and
other methods could be implemented to manage overhead, or shouldn't even be
considered. However, I believe  here is already some limited support for
this (RSBAC http://www.rsbac.org) and CAPs. Its just not supported in a
directory service.

>>3.) To the idea of a "linux-registry":
>>I do not like this, UNIX lives now 30 years with /etc and human-readable
>>configfiles and without a "database", and i think its a good compromise
>>between usability and "keep-it-simple".
>>And it works.

The Windows Registry isn't anything like what I am suggesting. The Windows
Registry isn't really even a database, is more or less an open draw, shoved
full of  bits and pieces of information everywhere. The Windows registry is
a lot like a /etc directory in non-human readable form. Every Windows box
has its own registry, just like every Unix box has a /etc directory. Think
of a directory service of more than a simple database and more like a shared
file system where you can access configuration information on any box from
any box you choose.

How would you manage 1000 or 10,000 desktop boxes each with their own /etc
directory?  Imagine your supporting several hundred or even several thousand
unix boxes, and you need to apply a standard change to all of them. Lets
also assume your not getting paid by the hour, or you need to get the change
done in just a hour or two. Would you trust a running a script on a
/etc/*.conf file to apply a change on your boxes? I suppose if you really
like to torture yourself, you could modify each of those files by hand,
ouch!

Thanks for the response.
Ron

