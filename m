Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131691AbRDJM5C>; Tue, 10 Apr 2001 08:57:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131806AbRDJM4x>; Tue, 10 Apr 2001 08:56:53 -0400
Received: from d12lmsgate.de.ibm.com ([195.212.91.199]:56483 "EHLO
	d12lmsgate.de.ibm.com") by vger.kernel.org with ESMTP
	id <S131691AbRDJM4h> convert rfc822-to-8bit; Tue, 10 Apr 2001 08:56:37 -0400
From: schwidefsky@de.ibm.com
X-Lotus-FromDomain: IBMDE
To: Andi Kleen <ak@suse.de>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Andi Kleen <ak@suse.de>,
        Mark Salisbury <mbs@mc.com>, Jeff Dike <jdike@karaya.com>,
        linux-kernel@vger.kernel.org
Message-ID: <C1256A2A.0046E317.00@d12mta07.de.ibm.com>
Date: Tue, 10 Apr 2001 14:54:31 +0200
Subject: Re: No 100 HZ timer !
Mime-Version: 1.0
Content-type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-transfer-encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



>Does not sound very attractive all at all on non virtual machines (I see
the point on
>UML/VM):
>making system entry/context switch/interrupts slower, making add_timer
slower, just to
>process a few less timer interrupts. That's like robbing the fast paths
for a slow path.
The system entry/exit/context switch is slower. The add_timer/mod_timer is
only
a little bit slower in the case a new soonest timer event has been created.
 I
think you can forget the additional overhead for add_timer/mod_timer, its
the
additional path length on the system entry/exit that might be problematic.

blue skies,
   Martin

Linux/390 Design & Development, IBM Deutschland Entwicklung GmbH
Schönaicherstr. 220, D-71032 Böblingen, Telefon: 49 - (0)7031 - 16-2247
E-Mail: schwidefsky@de.ibm.com


