Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314369AbSDRPCb>; Thu, 18 Apr 2002 11:02:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314370AbSDRPCa>; Thu, 18 Apr 2002 11:02:30 -0400
Received: from web9208.mail.yahoo.com ([216.136.129.41]:42254 "HELO
	web9208.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S314369AbSDRPCa>; Thu, 18 Apr 2002 11:02:30 -0400
Message-ID: <20020418150229.65663.qmail@web9208.mail.yahoo.com>
Date: Thu, 18 Apr 2002 08:02:29 -0700 (PDT)
From: Alex Davis <alex14641@yahoo.com>
To: linux-kernel@vger.kernel.org
Cc: karlran1234@yahoo.com
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>Hello,
>I've a big problem with my SCSI/PCI setup:

>When doing a:
>>/sbin/modprobe aic7xxx

>Apr 14 09:13:04 test  kernel: SCSI subsystem driver Revision: 1.00
.
>Has anyone seen this before?

>The problem ONLY appears when I run my PC with a Davicom 100MBPS NIC.
>The Davicom runs fine without the 29160!

>scanpci  -v

Please run 'lspci -v' instead of 'scanpci -v'. 

>I already tried shuffeling the boards & IRQs - no luck :-((

Please try shuffling the cards again, and run 'lspci -v' on each reshuffle.
It appears from the 'scanpci' output that some card is using the same IRQ
as the SCSI card. I don't think all drivers handle IRQ sharing gracefully.


__________________________________________________
Do You Yahoo!?
Yahoo! Tax Center - online filing with TurboTax
http://taxes.yahoo.com/
