Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318778AbSHUTCo>; Wed, 21 Aug 2002 15:02:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318841AbSHUTCo>; Wed, 21 Aug 2002 15:02:44 -0400
Received: from chaos.analogic.com ([204.178.40.224]:13696 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S318778AbSHUTCn>; Wed, 21 Aug 2002 15:02:43 -0400
Date: Wed, 21 Aug 2002 15:07:00 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: Mukesh Rajan <mrajan@ics.uci.edu>
cc: Richard Zidlicky <rz@linux-m68k.org>, linux-kernel@vger.kernel.org
Subject: Re: detecting hard disk idleness
In-Reply-To: <Pine.SOL.4.20.0208211141210.21898-100000@hobbit.ics.uci.edu>
Message-ID: <Pine.LNX.3.95.1020821150119.4564A-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 21 Aug 2002, Mukesh Rajan wrote:

> this again would mean that i would have to poll the /proc/interrupt file.
> i want to avoid polling because of very small poll interval causing
> overhead. i am still wondering if this could be implemented with some sort
> of interrupt mechanism in linux (kernel interrupting user program or user
> program waiting on some signal)
> 
> - mukesh
> 

Hard disk 'idleness' is something you would check at a 1-second
interval. As such, its overhead is very small.

This is a sample at 1 second intervals during a kernel compile:

 11:       4667       4585   IO-APIC-level  BusLogic BT-958
 11:       4667       4585   IO-APIC-level  BusLogic BT-958
 11:       4667       4585   IO-APIC-level  BusLogic BT-958
 11:       4667       4585   IO-APIC-level  BusLogic BT-958
 11:       4667       4585   IO-APIC-level  BusLogic BT-958
 11:       4667       4585   IO-APIC-level  BusLogic BT-958
 11:       4667       4585   IO-APIC-level  BusLogic BT-958
 11:       4667       4585   IO-APIC-level  BusLogic BT-958
 11:       4670       4588   IO-APIC-level  BusLogic BT-958
 11:       4670       4588   IO-APIC-level  BusLogic BT-958
 11:       4670       4588   IO-APIC-level  BusLogic BT-958
 11:       4670       4588   IO-APIC-level  BusLogic BT-958
 11:       4670       4588   IO-APIC-level  BusLogic BT-958
 11:       4670       4588   IO-APIC-level  BusLogic BT-958
 11:       4670       4588   IO-APIC-level  BusLogic BT-958
 11:       4670       4588   IO-APIC-level  BusLogic BT-958


Cheers,
Dick Johnson
Penguin : Linux version 2.4.18 on an i686 machine (797.90 BogoMips).
The US military has given us many words, FUBAR, SNAFU, now ENRON.
Yes, top management were graduates of West Point and Annapolis.

