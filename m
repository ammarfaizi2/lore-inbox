Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932316AbVLEKwh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932316AbVLEKwh (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Dec 2005 05:52:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932359AbVLEKwh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Dec 2005 05:52:37 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:8429 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S932316AbVLEKwh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Dec 2005 05:52:37 -0500
Subject: Linux in a binary world... a doomsday scenario
From: Arjan van de Ven <arjan@infradead.org>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Date: Mon, 05 Dec 2005 11:52:32 +0100
Message-Id: <1133779953.9356.9.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-Spam-Score: 1.8 (+)
X-Spam-Report: SpamAssassin version 3.0.4 on pentafluge.infradead.org summary:
	Content analysis details:   (1.8 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	0.1 RCVD_IN_SORBS_DUL      RBL: SORBS: sent directly from dynamic IP address
	[213.93.14.173 listed in dnsbl.sorbs.net]
	1.7 RCVD_IN_NJABL_DUL      RBL: NJABL: dialup sender did non-local SMTP
	[213.93.14.173 listed in combined.njabl.org]
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linux in a binary world


What if.. what if the linux kernel developers tomorrow accept that
binary modules are OK and are essential for the progress of linux. 

a hypothetical doomsday scenario by Arjan van de Ven

the primary assumption in this scenario is obviously not going to
happen, but all assumptions that follow are based things that are true
in some form or another, but of course the names of the "innocent" have
been omitted.




On December 6th, 2005 the kernel developers en mass decide that binary
modules are legally fine and also essential for the progress of linux,
and are as such a desirable thing. At first, the development process of
the linux kernel doesn't change much other than a bunch more symbols
getting exported, and EXPORT_SYMBOL_GPL removed.

Within 3 weeks, distributions like Red Hat Enterprise Linux and SuSE's
SLES distribution start to include a wide variety of binary modules on
their installation CDs. Debian renounces this and stays pure to the
cause, as do other open distributions like Fedora Core and openSuSE. 

The enterprise distros don't just NVidias and ATIs modules, but include
all the OEM vendor "fakeraid" modules and the various wireless,
winmodem, windsl and TCP-offloading modules as well,. However, unlike
NVidia and ATI, most of the binary driver vendors do not provide their
drivers in a "glue layer" source form, they provide only the final
binaries.

Several hardware vendors that have been friendly to open source so far,
see their competitors ship only binary drivers, and internally they
start to see pressure to also keep the IP private, and they know that
they haven't used some features of the hardware because their legal
department didn't want that IP in the public. As a result they perceive
their competitors binary drivers to be at a theoretical advantage, or at
least their own drivers could be at an advantage if they were also
closed, because they then can use those few extra features to be ahead
of the competition. By February 1st 2006, about half the hardware
vendors have refocused their internal linux driver efforts to create
value adds in the binary drivers they will release in addition to the
open drivers that already exist. Some vendors even openly stopped
supporting the open drivers because they don't have enough resources
to do both.

March 1st. All the new server lines from the top tier hardware vendors
come out with the next generation storage and network hardware. This
hardware comes with binary drivers for the last 2 versions of RHEL and
SLES distributions, and these drivers are already integrated into the
February refreshes of these distributions. One of the storage vendors
releases their driver in a .o + glue layer format, the others doesn't
bother and only releases binaries for these two distributions. Two of
the network card manufacturers release an update for their open source
driver to minimally support the new cards, the others don't. Consumer
hardware is largely unaffected; most consumer chipsets standardize on
AHCI for SATA storage and keep the existing feature sets in networking
chipsets.

April 1st. 2 of the consumer chipset makers have upgraded their chipsets
to include a new and exciting audio feature that enables enhanced DVD
playback, but unfortunately this caused them to deviate from the
'standard' i810 audio hardware interface. One of them releases a binary
driver for a handful of distributions, the other doesn't consider linux
relevant for the desktop and hasn't bothered to do a linux driver yet.

May 1st All of the server class hardware you can buy requires at least
one but usually 2 or 3 binary modules to operate. While some of these
modules are available in blob+glue form, several are only available for
RHEL3, RHEL4 and SLES9 and sometimes the newly released SLES10. Linux
users will have the choice of 4 kernels for these servers at this time,
but no hope to run a kernel.org kernel on these servers. The Ubuntu
people are very upset and are trying hard, with varying success, to get
drivers available for their distribution. Due to this lobby success,
about 50% of the servers can be used with the Ubuntu kernel as well.

June 1st. A huge flamewar, the fourth on this topic since January,
happens on the linux-kernel mailing list. Users and some developers are
demanding that the kernel.org kernel adopts either the existing RHEL or
the SLES module ABI. Investigation shows that this is not possible, and
the thread turns into a discussion on designing a new ABI versus
freezing the existing one. Many kernel developers feel that the existing
ad-hoc ABI is not suitable for freezing and that a new ABI and API,
designed such that it can be kept stable more easily is the way to go,
while others say that this takes too much time and then won't help for
the next 2 years until RHEL and SLES have adopted this ABI, and at least
demand an immediate freeze of the kernel.org ABI so that the upcoming
RHEL5 release maybe uses it, and thus gets drivers written for it. Users
generally use RHEL or SLES for production servers, and clones like
CENTOS which have released binary compatible kernels.

July 1st. It's increasingly hard to run linux without binary modules on
most new consumer PCs. While a year earlier people would have to give up
3D acceleration for this often, now even 2D doesn't work without binary
drivers, nor does networking (both fixed wire or wireless) or sound. For
half the machines there is not enough linux support available at all,
while 20% use ndiswrapper like translation layers to run the Windows
sound and networking drivers. The Debian project, unable to run on most
machines now, is losing massive amounts of users to Ubuntu and
Ubuntu-Debian hybrids. Debian-legal and various other project lists are
impossible to read by people not interested in this particular
flame-topic. Most of the vendors who kept their open source drivers at
least somewhat updated have basically stopped doing so.

July 14th. Linus declares the kernel ABI stable but also splits off a
2.7 kernel and declares that the 2.8 kernel will have a different ABI.
In practice, only people who held on to their old machines can assist in
the 2.7 development, since none of the vendor drivers, not even the ones
who still have a blob+glue construct care about the 'too rapid' moving
development tree. 

August 21st. A serious security flaw is found in the 2.6 series, which
turns out to be a design flaw in a key sysfs API. Fixing this flaw would
require to break the module ABI and practically all modules out there,
while not fixing this flaw leaves a potential roothole open. A quick fix
is made available under a CONFIG_ option, but users who need binary
drivers have no choice but leave their systems vulnerable. Flamewars on
lkml flare up again that say Linus made a mistake in freezing the
existing ABI rather than creating a new one designed to be frozen. 2.7
development has mostly stagnated and a patch is proposed to have 2.7
have the 2.6 ABI again, reverting several key VM subsystem improvements
and Ingo's realtime patches.

August 26th. A precooked exploit for the security hole hits bugtraq, and
has been sighted in the wild as used by various rootkits. A php exploit
uses it to go from the httpd user to root. Users are putting pressure on
module vendors to release modules for the new ABI, and several actually
do so in the next three weeks. Others, mostly in the consumer area, say
that the hardware in question is no longer sold and that they aren't
going to spend any time or effort on drivers for it.






Now this scenario may sound unlikely to you. And thankfully the main
assumption (the December 6th event) is extremely unlikely.  

However, and this unfortunately, several of the other "leaps" aren't
that unlikely. In fact, some of these results are likely to happen
regardless; witness the flamewars on lkml about breaking module API/ABI.
Witness the ndiswrapper effect of vendors now saying "we support linux
because ndiswrapper can use our windows driver". I hope they won't
happen. Some of that hope will be idle hope, but I believe that the
advantages of freedom in the end are strong enough to overcome the
counter forces. 


