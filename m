Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289372AbSAOCyk>; Mon, 14 Jan 2002 21:54:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289371AbSAOCyV>; Mon, 14 Jan 2002 21:54:21 -0500
Received: from noodles.codemonkey.org.uk ([62.49.180.5]:62185 "EHLO
	noodles.codemonkey.org.uk") by vger.kernel.org with ESMTP
	id <S289370AbSAOCyO>; Mon, 14 Jan 2002 21:54:14 -0500
Date: Tue, 15 Jan 2002 02:55:30 +0000
From: Dave Jones <davej@suse.de>
To: Patrick Mochel <mochel@osdl.org>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: Defining new section for bus driver init
Message-ID: <20020115025530.A11314@suse.de>
Mail-Followup-To: Dave Jones <davej@suse.de>,
	Patrick Mochel <mochel@osdl.org>,
	Linux Kernel <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.22.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Attached is a patch that creates a new section for device subsystem init
> calls. With it, the root bus init calls are handled just like init calls
> - the section consists of a table of function pointers.
> device_driver_init() iterates over that table and calls each one.
> (device_driver_init() currently happens just before that pci_init() call
> above).
> What do people think about the concept? 

Well, it chops out a load of ugly ifdefs, and makes adding support
for a new bus less intrusive than it currently is. I quite like it.

> I will warn that the name is kinda clumsy, but it's the best that I could
> come up with (I wasted my creativity for the day on thinking about
> Penelope). I used "subsystem" because I have alterior motives.

I think you hit the nail on the head with the subject line.
struct BusDriver also conjures up amusing[*] imagery.

One thing I'm wondering about though. Is it possible for a new
bus to be added after boot ? Docking stations etc show up as
children on the root PCI bus, so that shouldn't be an issue.

Ah! hotplug PCI USB controller ?

Dave.

[*] I'm easily amused.

-- 
Dave Jones.                    http://www.codemonkey.org.uk
SuSE Labs.
