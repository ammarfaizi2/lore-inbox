Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269089AbRG3Xpb>; Mon, 30 Jul 2001 19:45:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269090AbRG3XpV>; Mon, 30 Jul 2001 19:45:21 -0400
Received: from atlrel2.hp.com ([156.153.255.202]:43740 "HELO atlrel2.hp.com")
	by vger.kernel.org with SMTP id <S269093AbRG3XpJ>;
	Mon, 30 Jul 2001 19:45:09 -0400
Message-ID: <3B65F1A2.30708CC1@fc.hp.com>
Date: Mon, 30 Jul 2001 17:45:38 -0600
From: Khalid Aziz <khalid@fc.hp.com>
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.4.5 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Andreas Dilger <adilger@turbolinux.com>
Cc: Linux kernel development list <linux-kernel@vger.kernel.org>
Subject: Re: Support for serial console on legacy free machines
In-Reply-To: <200107302332.f6UNWbxg001791@webber.adilger.int>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

Andreas Dilger wrote:
> 
> OK, maybe I'm misunderstanding here, but even if I put in a PCI serial
> card in such a machine, can I get serial console support without ACPI?
> Not that it matters in my case, because there are no PCI slots on the
> motherboard either.
> 

AFAIK, you can not have console on a PCI serial port at this time. I
looked at it few months back and found out that PCI initialization
happens much too late for a serial console. It would take quite a bit of
work to get serial console working on PCI cards. PA-Linux faced the same
problem but they were able to get around it by using the firmware calls
to do console I/O. If serial console were working on PCI serial cards,
you wouldn't need ACPI to use it.

-- 
Khalid

====================================================================
Khalid Aziz                              Linux Systems Operation R&D
(970)898-9214                                        Hewlett-Packard
khalid@fc.hp.com                                    Fort Collins, CO
