Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263388AbUAGGGo (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Jan 2004 01:06:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264898AbUAGGGn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Jan 2004 01:06:43 -0500
Received: from fw.osdl.org ([65.172.181.6]:56240 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263388AbUAGGGm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Jan 2004 01:06:42 -0500
Date: Tue, 6 Jan 2004 22:06:24 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Dave Jones <davej@redhat.com>
cc: Andi Kleen <ak@colin2.muc.de>, Adam Belay <ambx1@neo.rr.com>,
       Mika Penttil? <mika.penttila@kolumbus.fi>, Andi Kleen <ak@muc.de>,
       David Hinds <dhinds@sonic.net>, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>,
       "Grover, Andrew" <andrew.grover@intel.com>
Subject: Re: PCI memory allocation bug with CONFIG_HIGHMEM
In-Reply-To: <20040107055557.GA13812@redhat.com>
Message-ID: <Pine.LNX.4.58.0401062203040.12602@home.osdl.org>
References: <Pine.LNX.4.58.0401052100380.2653@home.osdl.org>
 <20040106081203.GA44540@colin2.muc.de> <3FFA7BB9.1030803@kolumbus.fi>
 <20040106094442.GB44540@colin2.muc.de> <Pine.LNX.4.58.0401060726450.2653@home.osdl.org>
 <20040106153706.GA63471@colin2.muc.de> <Pine.LNX.4.58.0401060744240.2653@home.osdl.org>
 <20040106222959.GA3188@neo.rr.com> <Pine.LNX.4.58.0401062000490.12602@home.osdl.org>
 <20040107050256.GA4351@colin2.muc.de> <20040107055557.GA13812@redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 7 Jan 2004, Dave Jones wrote:
> 
> Why on earth would you want to call PNPBIOS on AMD64 anyway ?

For the same reason normal PC's still like to: no technical reason, except
for the fact that system vendors like to hide bugs and quirks by having
magic stuff in ACPI or PnPBIOS to tell the OS "hands off" or "this is how
to route this strange irq".

It's like ACPI: it would be a whole lot better if the hardware was just
standard and documented and didn't need any magic configuration tables and
strange code snippets to do magic acts of perversion. But sadly, it ain't 
so, and PnP and ACPI are there as imperfect ways of doing what needs to be 
done.

Of course, as with most system vendor crud, some BIOSes are more imperfect 
than others. 

			Linus
