Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269087AbRG3Xja>; Mon, 30 Jul 2001 19:39:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269089AbRG3XjU>; Mon, 30 Jul 2001 19:39:20 -0400
Received: from atlrel6.hp.com ([192.151.27.8]:62735 "HELO atlrel6.hp.com")
	by vger.kernel.org with SMTP id <S269087AbRG3Xi7>;
	Mon, 30 Jul 2001 19:38:59 -0400
Message-ID: <3B65F02B.53A8880D@fc.hp.com>
Date: Mon, 30 Jul 2001 17:39:23 -0600
From: Khalid Aziz <khalid@fc.hp.com>
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.4.5 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "Randy.Dunlap" <rddunlap@osdlab.org>
Cc: Andreas Dilger <adilger@turbolinux.com>,
        Linux kernel development list <linux-kernel@vger.kernel.org>
Subject: Re: Support for serial console on legacy free machines
In-Reply-To: <200107302240.f6UMeWg2001230@webber.adilger.int> <3B65E711.A3828E15@fc.hp.com> <3B65EB21.C1DD8624@osdlab.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

"Randy.Dunlap" wrote:
> 
> Khalid Aziz wrote:
> > I am puzzled. How would you get "serial console" support even with ACPI
> > unless there IS a serial port on the system????? All ACPI can do is tell
    ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> > you where the serial port is.
> 
> Wait a minute.  Aren't you the person who originally proposed this,
> and you don't know how it's used?
> 
> Here are 2 possibilities:
> 
> a.  Some pre-production motherboards are built with serial ports on
> them, only for debugging.  Never shipped to customers like this.
> The documented I/O resources for this serial port are in the
> special ACPI table that you referred to last Thursday.
> 

And that means system DOES have a serial port. All SPCR table does is
tell you where it is (in I/O, memory or PCI space). SPCR table does not
add a serial port. Some kind of serial port has to exist for SPCR table
to be meaningful. My understanding of Andreas' question was how to get
serial console support (or same kind of functionality) when the new
systems do not have a serial port. 

If a USB chipset could "emulate" a serial port by doing proper
translation from read/write into USB protocol transfers, system still
has a serial port from OS point of view and all ACPI tables will do is
tell me where to find it.

-- 
Khalid

====================================================================
Khalid Aziz                              Linux Systems Operation R&D
(970)898-9214                                        Hewlett-Packard
khalid@fc.hp.com                                    Fort Collins, CO
