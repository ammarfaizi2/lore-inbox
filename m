Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312134AbSCTUYr>; Wed, 20 Mar 2002 15:24:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312136AbSCTUYi>; Wed, 20 Mar 2002 15:24:38 -0500
Received: from holomorphy.com ([66.224.33.161]:37514 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S312134AbSCTUYV>;
	Wed, 20 Mar 2002 15:24:21 -0500
Date: Wed, 20 Mar 2002 12:24:01 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
Cc: Martin Wilck <Martin.Wilck@fujitsu-siemens.com>,
        Ingo Molnar <mingo@elte.hu>,
        Linux Kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: Severe IRQ problems on Foster (P4 Xeon) system
Message-ID: <20020320202401.GA785@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	"Maciej W. Rozycki" <macro@ds2.pg.gda.pl>,
	Martin Wilck <Martin.Wilck@fujitsu-siemens.com>,
	Ingo Molnar <mingo@elte.hu>,
	Linux Kernel mailing list <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.33.0203131912140.1477-100000@biker.pdb.fsc.net> <Pine.GSO.3.96.1020319145208.12399I-100000@delta.ds2.pg.gda.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Description: brief message
Content-Disposition: inline
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 19, 2002 at 03:32:22PM +0100, Maciej W. Rozycki wrote:
>  The value is correct as after issuing the poll i8259 command the next
> read cycle to the PIC returns an IRQ level (0x07 = no IRQ active; it
> shouldn't happen here -- 0x80 is expected for active IRQ 0). 

On Wed, 13 Mar 2002, Martin Wilck wrote:
>> inb(0x20) call is not captured in our protocol, it must occur long after
>> the error. (We saw normal execution of the above code fragment where
>> there is ~1us between the outb and inb, where it is >120us here).


There is/was at least one simulator that shoots the kernel (and
everything else) dead in response to frobbing the PIC while the local
APIC timer etc. are going, and I wouldn't be surprised if there were
some real hardware that did so as well.

(this is the code under if (timer_ack) in do_timer_interrupt())


Cheers,
Bill
