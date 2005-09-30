Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964927AbVI3H2y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964927AbVI3H2y (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Sep 2005 03:28:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932573AbVI3H2y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Sep 2005 03:28:54 -0400
Received: from zorg.st.net.au ([203.16.233.9]:57216 "EHLO borg.st.net.au")
	by vger.kernel.org with ESMTP id S932572AbVI3H2x (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Sep 2005 03:28:53 -0400
Message-ID: <433CE961.3040504@torque.net>
Date: Fri, 30 Sep 2005 17:29:37 +1000
From: Douglas Gilbert <dougg@torque.net>
Reply-To: dougg@torque.net
User-Agent: Mozilla Thunderbird 1.0.6-1.1.fc4 (X11/20050720)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@osdl.org>
CC: Luben Tuikov <ltuikov@yahoo.com>,
       SCSI Mailing List <linux-scsi@vger.kernel.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: I request inclusion of SAS Transport Layer and AIC-94xx into
 the kernel
References: <20050929232013.95117.qmail@web31810.mail.mud.yahoo.com> <Pine.LNX.4.64.0509291730360.3378@g5.osdl.org>
In-Reply-To: <Pine.LNX.4.64.0509291730360.3378@g5.osdl.org>
X-Enigmail-Version: 0.92.0.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:
> 
> On Thu, 29 Sep 2005, Luben Tuikov wrote:
> 
>>>   It's like real science: if you have a theory that doesn't match 
>>>   experiments, it doesn't matter _how_ much you like that theory. It's
>>>   wrong. You can use it as an approximation, but you MUST keep in mind 
>>>   that it's an approximation.
>>
>>But this is _the_ definition of a theory.  No one is arguing that
>>a theory is not an approximation to observed behaviour.
> 
> 
> No.
> 
> A scientific theory is an approximation of observed behaviour WITH NO 
> KNOWN HOLES.
> 
> Once there are known holes in the theory, it's not a scientific theory. At 
> best it's an approximation, but quite possibly it's just plain wrong.
> 
> And that's my point. Specs are not only almost invariably badly written, 
> they also never actually match reality. 
> 
> At which point at _best_ it's just an approximation. At worst, it's much 
> worse. At worst, it causes people to ignore reality, and then it becomes 
> religion.
> 
> And that's way _way_ too common. People who ignore reality are sadly not 
> at all unusual.
> 
> "But the spec says ..." is pretty much always a sign of somebody who has 
> just blocked out the fact that some device doesn't.
> 
> So don't talk about specs.

Why not?

There are good, bad and ill-timed specs. The bad ones are
ignored. Ill-timed ones gather dust, for example the
SCSI Ultra 640 standard (SPI-5) since the industry has
bet on SAS; hope they weren't expecting timely driver
support from Linux.

As for a good spec how about the Multi Media Command (MMC)
set which allows us to read music and data CDs written
almost twenty years ago plus many different formats since
then. It is currently (in MMC-5) being enhanced to cope
with the next big bun fight in that space: Blue ray and
HD-DVD (and their various content protection systems).

In the t10.org hierarchy of specs, MMC is subservient to
the primary commands (SPC) and the general architecture
(SAM). The companies that work in the MMC space (and
tend to define that standard) have "bent the rules" over
the years. The response from the (different set of)
companies that are behind SPC and SAM was to make
allowance for MMC.
The process seems to work pretty well and I am unaware
of any proposed alternate interfaces. Transports have
come and gone but the logical interface has remained.

> Talk about working code that is _readable_ and _works_.

For SAS we have a well thought out definition for what the
interface should be to hardware specific drivers IMO. It is
called CSMI, rechristened SDI. The editor of SDI is also
the editor of SAS, SAS-1.1 and SAS-2. Judging from his work,
he knows his stuff. Unfortunately SDI uses ioctls to define
its interface, which is mainly between two kernel layers
(if one ignores pass throughs). Sorry, did I mention "ioctl",
oh that makes SDI unacceptable. Almost a year ago that is what
happened to the first proposed SAS driver for Linux. That
decision has pushed Luben (amongst others) into the position
he is in now: come up with a "better" design, produce code
and then watch it get rejected. So please cut Luben a bit
of slack.

Just in case people think that I agree with Luben on using
sysfs to represent the whole SAS topology and interesting
bits suspended in it (i.e. SAS expanders), then I don't.
I am, however, prepared to argue the detail. Since the
days of Eric Youngdale I have believed that SCSI Host Bus
Adapters (HBAs) should be addressable devices, just like
network interfaces. IMO it is the block layer and its
associated end devices that are the legacy thinking.

> There's an absolutely mindbogglingly huge difference between the two.

It is ironic that as the author of the SG_IO
passthrough ioctl the "specs" that I am
often asked to help circumvent are the "we
know better" variety built into various layers
of the linux kernel :-)

Doug Gilbert
