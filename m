Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S129882AbQK0VEN>; Mon, 27 Nov 2000 16:04:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S130343AbQK0VED>; Mon, 27 Nov 2000 16:04:03 -0500
Received: from alcove.wittsend.com ([130.205.0.20]:14609 "EHLO
        alcove.wittsend.com") by vger.kernel.org with ESMTP
        id <S130163AbQK0VDq>; Mon, 27 Nov 2000 16:03:46 -0500
Date: Mon, 27 Nov 2000 16:32:17 -0500
From: "Michael H. Warfield" <mhw@wittsend.com>
To: "Mike A. Harris" <mharris@opensourceadvocate.org>
Cc: "J. Dow" <jdow@earthlink.net>, FyreMoon@fyremoon.net,
        coredumping@hotmail.com, linux-kernel@vger.kernel.org
Subject: Re: About IP address
Message-ID: <20001127163217.B20394@alcove.wittsend.com>
Mail-Followup-To: "Mike A. Harris" <mharris@opensourceadvocate.org>,
        "J. Dow" <jdow@earthlink.net>, FyreMoon@fyremoon.net,
        coredumping@hotmail.com, linux-kernel@vger.kernel.org
In-Reply-To: <07bf01c05664$15462210$0a25a8c0@wizardess.wiz> <Pine.LNX.4.30.0011241729270.5879-100000@asdf.capslock.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.2i
In-Reply-To: <Pine.LNX.4.30.0011241729270.5879-100000@asdf.capslock.lan>; from mharris@opensourceadvocate.org on Fri, Nov 24, 2000 at 05:30:03PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 24, 2000 at 05:30:03PM -0500, Mike A. Harris wrote:
> On Fri, 24 Nov 2000, J. Dow wrote:
> >Date: Fri, 24 Nov 2000 14:15:41 -0800
> >From: J. Dow <jdow@earthlink.net>
> >To: FyreMoon@fyremoon.net, coredumping@hotmail.com
> >Cc: linux-kernel@vger.kernel.org
> >Content-Type: text/plain;
> >        charset="iso-8859-1"
> >Subject: Re: About IP address
> >
> >From: "John Crowhurst" <FyreMoon@fyremoon.net>
> >
> >> > For example, Class B address range is 128.1.0.0 ~ 191.254.0.0
> >> >
> >> > Why 128.0.0.0 and 191.255.0.0 can't use ?
> >> >
> >> > I can't understand it

	Glad you can't understand it, because it's incorrect.  They can
be used but they are both assigned to IANA (Internet Assigned Numbers
Authority) as reserved address blocks.  You can't use them because IANA
controls them and dictates how they might be used if they are ever
used.  Since there may be broken software out there that mishandles
those addresses, it's entirely possible that IANA will never use them
for any routable purpose.  Neither currently have reverse name servers
assigned, so it's presumable that they are simply not in operation
and IANA is keeping them reserved to keep them out of trouble.

> >> This is because its the network and broadcast addresses of a Class A address
> >> range. Simple answer :)

> >That is not a responsive answer, John. And since you gave it I issue you the
> >challenge to declare why 128.0.0.1 through 191.255.255.254 are not legal
> >address ranges.

	It's also not a correct answer.  Under the Class system (A B C D E)
it is not the broadcast address of a Class A address because it is not in
the Class A range 1.*.*.* to 126.*.*.*  (network address 0 and network
address 127 are explicitly reserved in the RFCs).  Under Classless
Inter-Domain Routing (CIDR) it's not relevant because none of the classes
and their broadcast addresses are relevant under CIDR (outside of defining
the default value for the netmask) and that's all determined by the netmask.
So it's not a correct answer under the Class system and it's not a correct
answer under the Classless system, so it's not a correct answer.  Period.

> One possibility: rfc1700

	RFC 1700 is "ASSIGNED NUMBERS" and is dated "October 1994".  Yes,
over 6 years ago.

	Refering someone to RFC 1700 is cruel and unusual punishment.
Refering them to RFC 1700 without quoting any text is even worse, since
they then have to paw through that huge thumper (it's 230 pages of
assignment tables with no index) from end to end before they discover
that it's not in there.

	There is a very important section in the introduction that NEEDS
READING:

] The files in this directory document the currently assigned values for
] several series of numbers used in network protocol implementations.
] 
]         ftp://ftp.isi.edu/in-notes/iana/assignments
] 
] The Internet Assigned Numbers Authority (IANA) is the central
] coordinator for the assignment of unique parameter values for Internet
] protocols.  The IANA is chartered by the Internet Society (ISOC) and
] the Federal Network Council (FNC) to act as the clearinghouse to
] assign and coordinate the use of numerous Internet protocol
] parameters.

	Here is what IANA <http://www.iana.org> has to say about RFC 1700:

# IANA houses the many unique parameters and protocol values necessary
# for operation of the Internet and its future development.  Types of
# numbers range from unique port assignments to the registration of
# character sets.  In the past, these numbers were documented through
# the RFC document series, the last of these documents was RFC 1700,
# which is also now outdated.  Since that time, the assignments have
# been listed in this directory as living documents, constantly updated
# and revised when new information is available and new assignments are
# made. They are listed alphabetically. Please check back periodically
# if you need up to date information from these files.
# Thank you.

	Sooo...  RFC 1700 defers to IANA and IANA says RFC 1700 is outdated.
Nuff said...

	IAC...  Here is what it has to say about the "Classes":

] There are five classes of IP addresses: Class A through Class E.  Of
] these, Classes A, B, and C are used for unicast addresses, Class D is
] used for multicast addresses, and Class E addresses are reserved for
] future use.

] With the advent of classless addressing [CIDR1, CIDR2], the
] network-number part of an address may be of any length, and the whole
] notion of address classes becomes less important.

	Note that this last paragraph is HIGHLY relevant.  Over 6 years
ago they were already saying that with CIDR and "classless addressing"
"the whole notion of address classes becomes less important".

	IAC...  Nowhere in RFC 1700 could I find any restriction on the
use of addresses 128.0.*.*.  It's simply been a convention and the
network blocks in question have been taken out of circulation merely
by assigning them to IANA as reserved.

	If you do a "whois 128.0@arin.net" you find that it is a network
address reserved to IANA.  It's a usable address, but its use is governed
by who it is assigned to (like any other address block).  Since IANA
controls that address block, it's up to them to determine how it gets
used.

	Also...  "Assigned Numbers" didn't list network addresses, but
"Internet Numbers" did.  The last "Internet Numbers" was RFC 1166 which
included definitions for all five classes (A B C D and E).  D was the
multicast block and E was reserved.  This seems to be the last RFC
defining these ranges and it places no restrictions on things like
128.0 or 191.255.  There are some comments in both RFC 1700 and RFC 1166
about "Special Addresses" such as 0.0.0.37 where the network field is
all zeros.  That is defined as a host on the local network, but that's
not relevant to this either.

	I have been unable to find any documentation in the RFCs
which lay claim to restricting 128.0.*.* or 191.255.*.*.  The fact
that I did find the restrictions and definitions on 0.* and 127.*
is telling me that the other restrictions probably were NOT codified
in the RFCs or they would have been included in those appropriate
sections of those RFCs.  Both RFC 1700 and RFC 1166 refer to the
special status of 0.* and 127.*.  RFC 1700 makes no mention of network
addresses 128.0 or 191.255.  RFC 1166 lists them both as "reserved".
They are restricted in use solely due to their assignment to IANA as
reserved.  I know of no reason why any software should take any special
note of those addresses or do anything any different with them.

	At one time, I was involved in some heated discussions over my
"Class B" (130.205/16) and whether the ".0" subnet (130.205.0/24) was
legal.  Answer is that under the "Class Subneting" scheme of things
(Network / Subnetwork / Host), it is not, because subnets of 0 and -1
(notation for all ones) are reserved for the network address and
broadcast.  Under CIDR, however, they are perfectly legal.  That may be
where the origin of some of this confusion lies if you extrapolate that
old "Class Subneting" restriction the other way into superneting
(the precursor to CIDR).  But the extrapolation is also wrong.

> ;o)


> ----------------------------------------------------------------------
>       Mike A. Harris  -  Linux advocate  -  Open source advocate
>           This message is copyright 2000, all rights reserved.
>   Views expressed are my own, not necessarily shared by my employer.
> ----------------------------------------------------------------------

> Looking for Linux software?   http://freshmeat.net  http://www.rpmfind.net
> http://filewatcher.org  http://www.coldstorage.org  http://sourceforge.net

	Mike
-- 
 Michael H. Warfield    |  (770) 985-6132   |  mhw@WittsEnd.com
  (The Mad Wizard)      |  (678) 463-0932   |  http://www.wittsend.com/mhw/
  NIC whois:  MHW9      |  An optimist believes we live in the best of all
 PGP Key: 0xDF1DD471    |  possible worlds.  A pessimist is sure of it!

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
