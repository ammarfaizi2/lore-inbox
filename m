Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261599AbSJYUff>; Fri, 25 Oct 2002 16:35:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261601AbSJYUff>; Fri, 25 Oct 2002 16:35:35 -0400
Received: from cpe-66-1-218-52.fl.sprintbbd.net ([66.1.218.52]:4875 "EHLO
	daytona.compro.net") by vger.kernel.org with ESMTP
	id <S261599AbSJYUfe>; Fri, 25 Oct 2002 16:35:34 -0400
Message-ID: <3DB9AD6D.C96A5398@compro.net>
Date: Fri, 25 Oct 2002 16:45:33 -0400
From: Mark Hounschell <markh@compro.net>
Reply-To: markh@compro.net
Organization: Compro Computer Svcs.
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.18-lcrs i686)
X-Accept-Language: en
MIME-Version: 1.0
To: root@chaos.analogic.com
CC: linux-kernel@vger.kernel.org
Subject: Re: [OT]AMD/Intel interrupt latency (jitter) differences?
References: <Pine.LNX.3.95.1021025155330.3856A-100000@chaos.analogic.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Richard B. Johnson" wrote:

> 
> [SNIPPED....]
> Please use the [Enter] key. Lines should have "\n" and not auto-wrap
> in your mailer.

Sorry...

> 
> If you are measuring the interrupt latency jitter, you
> must disconnect your Ethernet wire if you have a Bus Mastering
> (read PCI) Ethernet board. You also have to make sure that
> no other Bus Masters are able to run during the measurements.
> 
> This is because the Bus Masters will keep the CPU(s) off the bus
> for variable lengths of time as they transfer variable lengths
> of data. This gives you the jitter.
> 
> Even though  you may not have any connections to your machine,
> M$ on LANs generate much broadcast traffic that your network
> software has to read, then drop on the floor.
> 
> What this means, frankly, is that if interrupt latency is
> in your specification, you can't use any Bus Mastering devices.
> It's just that simple.
> 

That makes sense. But, both these Intel and AMD boxes have pretty much the same
config as far as pci cards and pci busses. They both have 1 or 2 66mhz and a 33
mhz bus. 
The Intel box used right now is a Super-micro p4dc6+ and only has our 2 33mhz
cards in it. It has on board UW-scsi-2 controller using a 66MHz bus where as the
AMD has no controllers on the 66mhz bus. It is using the onboard IDE controller.
The intel has built in network card that IS active when running the emulation
and the AMD has a 3c905 card that is also active. Other than that they are the
same. I thought all recent pci cards were bus mastering capable these days??

Regards
Mark
