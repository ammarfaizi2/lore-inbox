Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264415AbTLaNAu (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 31 Dec 2003 08:00:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264476AbTLaNAu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 31 Dec 2003 08:00:50 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:63445 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S264415AbTLaNAr
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 31 Dec 2003 08:00:47 -0500
Message-ID: <3FF2C86C.1030906@pobox.com>
Date: Wed, 31 Dec 2003 08:00:28 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030703
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: =?ISO-8859-2?Q?Karel_Kulhav=FD?= <clock@twibright.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: Compatibility of Nvidia NVNET driver license with GPL
References: <20031231073101.A474@beton.cybernet.src> <3FF26E8A.5070806@pobox.com> <20031231114357.A318@beton.cybernet.src>
In-Reply-To: <20031231114357.A318@beton.cybernet.src>
Content-Type: text/plain; charset=ISO-8859-2; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Karel Kulhavý wrote:
> On Wed, Dec 31, 2003 at 01:36:58AM -0500, Jeff Garzik wrote:
> 
>>Karel Kulhavý wrote:
>>
>>>Hello
>>>
>>>I faintly remember reading some article on the Net from Linus Torvalds stating
>>>something like if a piece of code is written specifically for Linux kernel, it
>>>must be under GPL.
>>>
>>>I have got an nVidia NForce2 board and downloaded their Ethernet driver (nvnet)
>>>and they say in README: "the network driver provided by NVIDIA is subject to
>>>the NVIDIA software license". How is with compatibility of such a behaviour
>>>with GPL of the kernel sources?
>>
>>
>>Since I am not a lawyer, my engineering suggestion would be to sidestep 
>>legal issues by using "forcedeth" driver, to drive your nForce NIC. 
>>It's fully GPL'd, and full open source.
> 
> 
> Suppose we would like to overcome these perpetual problems with misbehaving
> manufacturers by designing a PCI network card from scratch in the soul of
> free source hardware.
> 
> What are the requirements of the kernel for such a card to be cool instead of
> piece of shit? How should such a card behave from PCI point of view, should it
> support scatter, gather, how should interrupts be handled, what should be
> programmable and what not? How should be busmastering implemented?
> 
> I am seriously thinking about designing something like that (tailored specially
> for Linux) because of developping Ronja - if I included native Ronja support in
> "my" network card, I could remove the superfluous circuits that implement
> "bureaucracy" linke autonegotiation, TP link integrity etc. and concentrate on
> raw performance. Also multiple ports could be on one card (say 4) which would
> make the whole thing more nifty.
> 
> I have made to work the whole design chain from schematic design to production
> of raw files for PCB manufacturers. Also seen a design of video capture
> board for IDE connector so I judge implementing something on a PCI should'n
> be a pain in the ass higher than moderate.

If you are serious about this, we have tons of good ideas, and tons of 
suggestions on how to avoid bad ideas :)

OpenCores (http://www.opencores.org/) might be a good place to start, as 
they already have a 10/100 ethernet MAC which is working, and has been 
silicon'd:  http://www.opencores.org/projects/ethmac/  Full "source" for 
the MAC is available, in VHDL I think.  OpenCores also has PCI VHDL and 
other glue you may need.

You'll definitely want to implement autonegotiation.  It's a showstopper 
without that.  And if it's not gigabit ethernet, it's already outdated. 
  So it's a tough challenge.

Once you have basic gigabit ethernet working with 10/100/1000 
autonegotiation, let us know, and we'll pelt you with good suggestions :)


> Is it possible to obtain some PCI specs without NDA's and such bullshit?
> Is here anyone who has taken the PCI specs and rewritten them in their
> own words?

You don't need an NDA, but you do need to pay US$50 or so for the specs. 
  Or a nice person might just send them to you :)

	Jeff




