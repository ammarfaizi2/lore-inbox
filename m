Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289494AbSAOK6G>; Tue, 15 Jan 2002 05:58:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289495AbSAOK5z>; Tue, 15 Jan 2002 05:57:55 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:39185 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id <S289494AbSAOK5q>; Tue, 15 Jan 2002 05:57:46 -0500
Date: Tue, 15 Jan 2002 10:57:33 +0000
From: Russell King <rmk@arm.linux.org.uk>
To: Giacomo Catenazzi <cate@debian.org>
Cc: Linux Kernel List <linux-kernel@vger.kernel.org>,
        "Eric S. Raymond" <esr@thyrsus.com>
Subject: Re: Autoconfiguration: Original design scenario
Message-ID: <20020115105733.B994@flint.arm.linux.org.uk>
In-Reply-To: <3C4401CD.3040408@debian.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3C4401CD.3040408@debian.org>; from cate@debian.org on Tue, Jan 15, 2002 at 11:17:49AM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 15, 2002 at 11:17:49AM +0100, Giacomo Catenazzi wrote:
> [ In Alan diary, I found that he tried some drivers
> before to find the driver for Telsa new tape.
> Autoconfigure will help also hackers.
> Hmm. Was the card ISA? so forget the above example
> ]

Not particularly wanting to add to the rediculously high level of noise
on this list, but yes, that's happened to be once before, but for a PCI
ISDN card.

There weren't many clues on the card packaging what it was, and couldn't
find anything on the net about the card, so resourted to the "insmod this
module, does it do anything" approach.  After many hours of prodding
around and reading source, turns out that it needed the hisax driver with
various random parameters.

I really don't see why hisax couldn't say "oh, you have an ISDN card with
IDs xxxx:xxxx, that's hisax type nn" and be done with it, rather than
needing to be told "pci id xxxx:xxxx type nn".  Have a look at
drivers/isdn/hisax/config.c and wonder how the hell you take some random
vendors PCI ISDN card and work out how to drive it under Linux.

(For the record, the card was:
   1397:2bd0       - Cologne Chip Designs GmbH - HFC-PCI 2BD0 ISDN
 and the driver requirements were:  hisax type 35 proto 2)

Realistically, I don't think any autoconfigurator will solve such cases
until these areas can be fixed up reasonably.

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

