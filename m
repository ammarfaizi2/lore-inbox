Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262846AbVAKVZX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262846AbVAKVZX (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Jan 2005 16:25:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262863AbVAKVYr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Jan 2005 16:24:47 -0500
Received: from mail.dif.dk ([193.138.115.101]:4064 "EHLO mail.dif.dk")
	by vger.kernel.org with ESMTP id S262846AbVAKVWt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Jan 2005 16:22:49 -0500
Date: Tue, 11 Jan 2005 22:25:18 +0100 (CET)
From: Jesper Juhl <juhl-lkml@dif.dk>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Jesper Juhl <juhl-lkml@dif.dk>, Chris Wright <chrisw@osdl.org>,
       Steve Bergman <steve@rueb.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Proper procedure for reporting possible security vulnerabilities?
In-Reply-To: <1105461562.16168.46.camel@localhost.localdomain>
Message-ID: <Pine.LNX.4.61.0501111854120.3368@dragon.hygekrogen.localhost>
References: <41E2B181.3060009@rueb.com> <87d5wdhsxo.fsf@deneb.enyo.de> 
 <41E2F6B3.9060008@rueb.com>  <Pine.LNX.4.61.0501102309270.2987@dragon.hygekrogen.localhost>
  <20050110164001.Q469@build.pdx.osdl.net>  <Pine.LNX.4.61.0501111758290.3368@dragon.hygekrogen.localhost>
 <1105461562.16168.46.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 11 Jan 2005, Alan Cox wrote:

> On Maw, 2005-01-11 at 17:05, Jesper Juhl wrote:
> > Problem is that the info can then get stuck at a vendor or maintainer 
> > outside of public view and risk being mothballed. It also limits the 
> > number of people who can work on a solution (including peole getting to 
> > work on auditing other code for similar issues). It also prevents admins 
> > from taking alternative precautions prior to availability of a fix (you 
> > have to assume the bad guys already know of the bug, not just the good 
> > guys).
> 
> The evidence is that for the most part the bad guys don't know about the
> bug and the majority of the bad guys are not skilled enough to write
> some of the complex exploits. They also automate extensively so given an
> exploit can make very fast very effective use of it. There is an entire
> field of economics and game theory tied up in this as well as papers by
> some in the field who look at computer security models this way.
> 
Of course there are downsides to full disclosure, but there are downsides 
to controlled disclosure as well. We could argue that for ages, but even 
if the arguments persuaded a few to move to a different 'camp' there's 
still going to be two "camps" out there and there always will be. 

This thread got started by a question about how to go about informing 
people about security vulnerabilities so I think we should erhaps try to 
provide some sensible information about how to go about that that can be 
useful to people no matter what "disclosure camp" the agree with. How 
about something like what I've written below as an addition to 
REPORTING-BUGS or as a seperate REPORTING-SECURITY-BUGS document ?

> If you are a member of the full disclosure camp then fine, but please cc
> vendor-sec when you publish the hole just in case Linus loses the email
> and so vendors know too and can plan appropriately.
> 
not informing vendors would be stupid, they should get told just as 
everyone else.


If we added something like the text below to REPORTING-BUGS or a sepperate 
document, then people would have an easier time finding out how to 
properly report security sensitive bugs, no matter what disclosure camp 
they belong to.
The text below is very much a draft, comments welcome.


*****
* REPORTING-BUGS
*****

The purpose of this text is to give information on how to report security 
vulnerabilities, submit example exploit code and similar about the Linux 
kernel.
For general bug reporting information, please see the REPORTING-BUGS 
document in the root of the kernel source.

It is generally recognized that there exists two main views on 
how security vulnerabilities should be reported - the "full disclosure" 
and "coordinated disclosure" schools of thought. 
This text gives advice on how to report the issue depending on what camp 
you belong to. 

Coordinated disclosure
-----
If you belong to the camp that believes that security vulnerabilities are 
best handled initially by maintainers, developers and vendors so that they 
get a chance to develop a fix before the public at large gets told about 
it then here's how you should probably report the issue.

Send your bugreport to the maintainer of the code affected. If there is no 
maintainer send it to the maintainer of the stable kernel series that it 
applies to. You may choose to send it to the kernel series maintainer as 
well in any case.
In most cases you want to also send the bugreport to the vendor-sec@lst.de 
mailing list. This is a cross-vendor security list, and by sending your 
mail there it should reach most of the security contacts at the major 
Linux vendors.
If you are using a kernel from a vendor (as opposed to a kernel from 
kernel.org) and the issue only applies to the vendor kernel, then you 
should also copy the email to the security coordinator at your vendor 
(usually security@vendorsdomain.tld or similar). You may want to do this 
in any case even if the bug is not secific to your vendors kernel.

To sum this up. 
Your primary recipients should be:
	- maintainer of code in question
	- maintainer of stable kernel series
Your CC list should most likely include:
	- vendor-sec@lst.de
	- security@vendor.tld (or equivalent)

If you choose this approach, then please allow some time to pass for the 
maintainer/vendor to develop a fix - depending on the nature of the 
vulnerability, 14-30 days seems adequate before you publish the 
information in a larger forum. Also, please do follow up on your 
submission, make sure it's recieved and acted upon.


Full disclosure
-----
If you belong to the camp that believes that information about security 
vulnerabilities should be made public broadly and with as many details as 
possible as fast as possible, then we request that you, in addition to 
whatever full disclosure mailing lists you are going to submit to, send a 
copy of your report to the maintainer of the code, the stable kernel 
series maintainer, vendor-sec@lst.de (so the vendors get a fair chance to 
react to the public information on an even footing with everyone else), 
linux-kernel@vger.kernel.org (so the kernel community at large gets a 
chance to respond) and also to any subsystem or special interrest mailing 
lists relevant to the code (if it's a net bug send a copy to netdev, if 
it's a scsi bug send a coy to linux-scsi etc).

So, to sum up the recipients:
Your primary recipients should be:
        - maintainer of code in question
        - maintainer of stable kernel series
	- the Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Your CC list should most likely include:
        - vendor-sec@lst.de
        - security@vendor.tld (or equivalent)
	- special interrest mailing lists relevant to the affected code.





-- 
Jesper Juhl



