Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269345AbRGaQKN>; Tue, 31 Jul 2001 12:10:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269346AbRGaQKC>; Tue, 31 Jul 2001 12:10:02 -0400
Received: from atlrel1.hp.com ([156.153.255.210]:712 "HELO atlrel1.hp.com")
	by vger.kernel.org with SMTP id <S269345AbRGaQJ6>;
	Tue, 31 Jul 2001 12:09:58 -0400
Message-ID: <3B66D873.FA2385FC@fc.hp.com>
Date: Tue, 31 Jul 2001 10:10:28 -0600
From: Khalid Aziz <khalid@fc.hp.com>
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.4.5 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Stuart MacDonald <stuartm@connecttech.com>
Cc: Linux kernel development list <linux-kernel@vger.kernel.org>
Subject: Re: Support for serial console on legacy free machines
In-Reply-To: <200107302332.f6UNWbxg001791@webber.adilger.int> <3B65F1A2.30708CC1@fc.hp.com> <000701c119cd$ebf0c720$294b82ce@connecttech.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

Stuart MacDonald wrote:
> 
> It seems like pci consoles won't work, now that I think about it. The
> console driver gets an index, which I'm going to assume works thusly:
> lilo console=ttyS1 ends up passing 1 as the index. That index is used
> to pick a serial port out of the array of serial ports that the driver
> knows about. If console init happens early, and serial driver init happens
> late (it would be dependent on pci init) then only hard coded ports
> would work. Those are defined in asm/serial.h, and for i386 include the
> standard ports, and a number of isa ports from various board manufacturers.
> 
> Using one of our pci ports would require knowledge of its io address,
> which wouldn't be available until the pci subsystem had inited. Perhaps
> that could be changed to allow pci based consoles?
> 

That is precisely the problem with trying to use a PCI serial port as
console. It is not trivial to move the PCI initialization earlier in the
boot sequence.

-- 
Khalid

====================================================================
Khalid Aziz                              Linux Systems Operation R&D
(970)898-9214                                        Hewlett-Packard
khalid@fc.hp.com                                    Fort Collins, CO
