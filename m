Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261907AbTCDWhF>; Tue, 4 Mar 2003 17:37:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261908AbTCDWhF>; Tue, 4 Mar 2003 17:37:05 -0500
Received: from [195.208.223.248] ([195.208.223.248]:21888 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id <S261907AbTCDWhE>; Tue, 4 Mar 2003 17:37:04 -0500
Date: Wed, 5 Mar 2003 01:46:56 +0300
From: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Ivan Kokshaysky <ink@jurassic.park.msu.ru>, raarts@office.netland.nl,
       david.knierim@tekelec.com, alexander@netintact.se,
       Donald Becker <becker@scyld.com>, Greg KH <greg@kroah.com>,
       jamal <hadi@cyberus.ca>, Jeff Garzik <jgarzik@pobox.com>,
       kuznet@ms2.inr.ac.ru, linux-kernel@vger.kernel.org,
       Robert Olsson <Robert.Olsson@data.slu.se>
Subject: Re: PCI init issues
Message-ID: <20030305014656.B678@localhost.park.msu.ru>
References: <20030304212648.A6455@jurassic.park.msu.ru> <Pine.LNX.4.44.0303041046370.1426-100000@home.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.44.0303041046370.1426-100000@home.transmeta.com>; from torvalds@transmeta.com on Tue, Mar 04, 2003 at 10:54:21AM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 04, 2003 at 10:54:21AM -0800, Linus Torvalds wrote:
> Well, I'd say it looks like the MP table _claims_ that only pin0 is 
> connected. Remember: the claim was that this machine worked on WinXP.

It seems that "IRQ redirection table" is gathered directly from
IO_APIC hardware (I may be wrong though), and it conforms to other
data...

> So there are at least two potential reasons for that:
> 
>  - The MP table is simply wrong, and WinXP gets the routing information 
>    from somewhere else (ie most likely ACPI)
> 
>  - The MP table is right, and only pin0 is connected, and WinXP only uses 
>    pin0 (ie it puts the card in some state where all irqs are shared 
>    across all of the four tulip chips).
> 
> Maybe somebody can come up with other schenarios.

  - XP is able to reprogramm the IO_APIC so that all four pins are
    routed properly.

Sounds a bit heretical, I know. :-)

Ivan.
