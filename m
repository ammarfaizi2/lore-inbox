Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423055AbWJGCU5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423055AbWJGCU5 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Oct 2006 22:20:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423057AbWJGCU5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Oct 2006 22:20:57 -0400
Received: from smtp.osdl.org ([65.172.181.4]:59066 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1423055AbWJGCU4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Oct 2006 22:20:56 -0400
Date: Fri, 6 Oct 2006 19:20:29 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: "Duran, Leo" <leo.duran@amd.com>
cc: "Rafael J. Wysocki" <rjw@sisk.pl>, Arjan van de Ven <arjan@infradead.org>,
       Jeff Garzik <jeff@garzik.org>, Andi Kleen <ak@suse.de>,
       discuss@x86-64.org, linux-kernel@vger.kernel.org
Subject: RE: [discuss] Re: Please pull x86-64 bug fixes
In-Reply-To: <1449F58C868D8D4E9C72945771150BDF46F8FD@SAUSEXMB1.amd.com>
Message-ID: <Pine.LNX.4.64.0610061912460.3952@g5.osdl.org>
References: <1449F58C868D8D4E9C72945771150BDF46F8FD@SAUSEXMB1.amd.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 6 Oct 2006, Duran, Leo wrote:
> 
> So, one can argue that there's merit on having ACPI

Not really.

The thing is, you have two choices:
 - define interfaces in hardware
 - not doing so, and then trying to paper it over with idiotic tables.

Sadly, Intel decided that they should do the latter, and invented ACPI.

If instead they had decided to just let the hardware describe itself, we 
wouldn't need ACPI. 

There are two kinds of interfaces: the simple ones, and the broken ones. 

The simple ones are better defined by the hardware people, and they work. 
They are of the kind:

 "The pointer to the MMIO config area is readable from IO port at offset 
  cf4h"

The broken ones are the ones where hardware people know what they want to 
do, but they think the interface is sucky and complicated, so they make it 
_doubly_ sucky by then saying "we'll describe it in the BIOS tables", so 
that now there is another (incompetent) group that can _also_ screw things 
up. Yeehaa!

The thing is, Intel did really well for _years_ with just defining 
hardware interfaces. The PIIX IDE controller interfaces were a great 
success, and worked for over a decade. So here's a question for you:

  "After having done something successfully for a decade, what do you do?
   Do you
    (a) Try to emulate a known successful strategy?
    (b) Put a committee together to try to come up with a new and more 
        'generic' solution, since you were only successful for closer to 
        fifteen years."

Guess which one is ACPI.

		Linus
