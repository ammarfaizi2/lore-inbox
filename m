Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266952AbTCDXun>; Tue, 4 Mar 2003 18:50:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266961AbTCDXun>; Tue, 4 Mar 2003 18:50:43 -0500
Received: from modemcable092.130-200-24.mtl.mc.videotron.ca ([24.200.130.92]:34833
	"EHLO montezuma.mastecende.com") by vger.kernel.org with ESMTP
	id <S266952AbTCDXum>; Tue, 4 Mar 2003 18:50:42 -0500
Date: Tue, 4 Mar 2003 18:58:09 -0500 (EST)
From: Zwane Mwaikambo <zwane@linuxpower.ca>
X-X-Sender: zwane@montezuma.mastecende.com
To: raarts@office.netland.nl
cc: Linus Torvalds <torvalds@transmeta.com>,
       Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
       "" <david.knierim@tekelec.com>, "" <alexander@netintact.se>,
       Donald Becker <becker@scyld.com>, Greg KH <greg@kroah.com>,
       jamal <hadi@cyberus.ca>, Jeff Garzik <jgarzik@pobox.com>,
       "" <kuznet@ms2.inr.ac.ru>, Linux Kernel <linux-kernel@vger.kernel.org>,
       Robert Olsson <Robert.Olsson@data.slu.se>
Subject: Re: PCI init issues
In-Reply-To: <3E653519.2050000@netland.nl>
Message-ID: <Pine.LNX.4.50.0303041842440.5867-100000@montezuma.mastecende.com>
References: <Pine.LNX.4.44.0303041046370.1426-100000@home.transmeta.com>
 <3E650061.9050201@netland.nl> <Pine.LNX.4.50.0303041742420.5867-100000@montezuma.mastecende.com>
 <3E653519.2050000@netland.nl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 5 Mar 2003, Ron Arts wrote:

> I hope this adds anything.
> Attached is the output of `mptable -dmesg -extra`

I can't really help much but here is a quick interpretation, this is your 
card with all the irqs wired to PIN A which seems to correspond with what 
Donald Becker said.

 INT     active-lo       level        3   4:A          4    0
 INT     active-lo       level        3   5:A          4    0
 INT     active-lo       level        3   6:A          4    0
 INT     active-lo       level        3   7:A          4    0

IO-APIC (apicid-pin) 2-0,  <-- doesn't that actually mean pin0 on the 
ioapic servicing that card is not connected? (or due to mptables again)

	Zwane
-- 
function.linuxpower.ca
