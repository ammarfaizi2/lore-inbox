Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269500AbTCDSKc>; Tue, 4 Mar 2003 13:10:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269501AbTCDSK2>; Tue, 4 Mar 2003 13:10:28 -0500
Received: from slip-12-65-97-224.mis.prserv.net ([12.65.97.224]:38515 "EHLO
	beohost.scyld.com") by vger.kernel.org with ESMTP
	id <S269500AbTCDSK1>; Tue, 4 Mar 2003 13:10:27 -0500
Date: Tue, 4 Mar 2003 13:16:22 -0500 (EST)
From: Donald Becker <becker@scyld.com>
To: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
cc: jamal <hadi@cyberus.ca>, Greg KH <greg@kroah.com>,
       Linus Torvalds <torvalds@transmeta.com>,
       Jeff Garzik <jgarzik@pobox.com>, <kuznet@ms2.inr.ac.ru>,
       <david.knierim@tekelec.com>, Robert Olsson <Robert.Olsson@data.slu.se>,
       <linux-kernel@vger.kernel.org>, <alexander@netintact.se>
Subject: Re: PCI init issues
In-Reply-To: <20030303151412.A15195@jurassic.park.msu.ru>
Message-ID: <Pine.LNX.4.44.0303041312230.974-100000@beohost.scyld.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 3 Mar 2003, Ivan Kokshaysky wrote:
> On Sun, Mar 02, 2003 at 12:44:06PM -0500, jamal wrote:
> > Interupt routing as can be seen above is really messed for that device.
> 
> Indeed. Quad tulip cards usually have irq pin A of each chip routed
> to pins A-D on the connector, so they cannot have the same irq unless

Incorrect.
Most quad Tulip boards have the bus bridge wired so that all interrupts
are sent on the INTA output of the board.

The tulip.c driver has worked around the BIOS bug on x86 machines for
years.  It should really be handled in the generic PCI quirks code, but
has not yet been correctly handled in the kernel's code.

-- 
Donald Becker				becker@scyld.com
Scyld Computing Corporation		http://www.scyld.com
410 Severn Ave. Suite 210		Scyld Beowulf cluster system
Annapolis MD 21403			410-990-9993

