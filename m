Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289536AbSAOMol>; Tue, 15 Jan 2002 07:44:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289545AbSAOMob>; Tue, 15 Jan 2002 07:44:31 -0500
Received: from xsmtp.ethz.ch ([129.132.97.6]:7853 "EHLO xfe3.d.ethz.ch")
	by vger.kernel.org with ESMTP id <S289536AbSAOMoP>;
	Tue, 15 Jan 2002 07:44:15 -0500
Message-ID: <3C442395.8010500@debian.org>
Date: Tue, 15 Jan 2002 13:41:57 +0100
From: Giacomo Catenazzi <cate@debian.org>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:0.9.4) Gecko/20011128 Netscape6/6.2.1
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Russell King <rmk@arm.linux.org.uk>
CC: Linux Kernel List <linux-kernel@vger.kernel.org>,
        "Eric S. Raymond" <esr@thyrsus.com>
Subject: Re: Autoconfiguration: Original design scenario
In-Reply-To: <3C4401CD.3040408@debian.org> <20020115105733.B994@flint.arm.linux.org.uk>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 15 Jan 2002 12:44:11.0336 (UTC) FILETIME=[54B3A480:01C19DC2]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Russell King wrote:

 
> I really don't see why hisax couldn't say "oh, you have an ISDN card with
> IDs xxxx:xxxx, that's hisax type nn" and be done with it, rather than
> needing to be told "pci id xxxx:xxxx type nn".  Have a look at
> drivers/isdn/hisax/config.c and wonder how the hell you take some random
> vendors PCI ISDN card and work out how to drive it under Linux.
> 
> (For the record, the card was:
>    1397:2bd0       - Cologne Chip Designs GmbH - HFC-PCI 2BD0 ISDN
>  and the driver requirements were:  hisax type 35 proto 2)
> 
> Realistically, I don't think any autoconfigurator will solve such cases
> until these areas can be fixed up reasonably.
 

Autoconfigure cannnot solve this.
The card is not in my database.
To help user, you should tell the driver maintainer to add our card
in the know pci devices. In this manner autoconfigure, hotplug and
modutils can take easy use your card.

This is also a problem of PCI design.
ISAPNP have the function type, USB have also the
function class, so that there exists few interfaces, and kernel
can ask only to specific interface and not to the specific card.
PCI also have the interface field, but not very used, and the
interfaces are also not so standardized.

	giacomo

 


