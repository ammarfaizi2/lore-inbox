Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131708AbRC0XmX>; Tue, 27 Mar 2001 18:42:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131718AbRC0XmO>; Tue, 27 Mar 2001 18:42:14 -0500
Received: from isis.its.uow.edu.au ([130.130.68.21]:44730 "EHLO
	isis.its.uow.edu.au") by vger.kernel.org with ESMTP
	id <S131708AbRC0Xl4>; Tue, 27 Mar 2001 18:41:56 -0500
Message-ID: <3AC12580.F2F280C@uow.edu.au>
Date: Wed, 28 Mar 2001 09:42:56 +1000
From: Andrew Morton <andrewm@uow.edu.au>
X-Mailer: Mozilla 4.7 [en] (X11; I; Linux 2.4.3-pre3 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: Clem Taylor <ctaylor@chipwrights.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: 2.4.2 SMP + 3c905C-TX + NETDEV WATCHDOG
In-Reply-To: <3AC108AF.C5F4A862@chipwrights.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Clem Taylor wrote:
> 
> Every few weeks, since switching to 2.4.2, I get a series of 'NETDEV
> WATCHDOG' errors. When this happens the system becomes unusable (homes
> are NFS mounted) and does not recover. A small number of packets do get
> out when it's in this state, but not enough to be useful. I've tried an
> ifconfig up/down, all that seems to help is a reboot. The 3c905C driver
> is compiled into my kernel, so I can't reload it. The machine is a Dell
> Precision 220 (only one processor installed).

Irritating, isn't it?

> Has anyone else seen this problem. Is their a way to reset the interface
> without rebooting? Any ideas?

No.  A reboot is required.

It is due to a problem in the APIC handling.  There is a 
workaround in the 2.4.2-ac series which fixes it.  It
appears to not be in the 2.4.3 series.  So for the
while you'll have to either install a recent -ac kernel
or boot with the `noapic' LILO option.

-
