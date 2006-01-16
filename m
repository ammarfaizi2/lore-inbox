Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751121AbWAPLNb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751121AbWAPLNb (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Jan 2006 06:13:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751124AbWAPLNb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Jan 2006 06:13:31 -0500
Received: from ctb-mesg3.saix.net ([196.25.240.73]:699 "EHLO
	ctb-mesg3.saix.net") by vger.kernel.org with ESMTP id S1751121AbWAPLNa convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Jan 2006 06:13:30 -0500
Content-class: urn:content-classes:message
Subject: RE: Net: e1000 driver: TX Hang message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Date: Mon, 16 Jan 2006 13:08:11 +0200
X-MimeOLE: Produced By Microsoft Exchange V6.5.6944.0
Message-ID: <C086BA41F8EFC942B7BBBCF09CC95D2112DB82@svr.msc-africa.co.za>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Net: e1000 driver: TX Hang message
thread-index: AcYajAlXBSObNpHeThmQ9V1PcZt62wAACJ2g
From: "Gerrit Visser" <g.visser@msc-africa.co.za>
To: "Andrew Morton" <akpm@osdl.org>
Cc: <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I've sent an update about it a while ago. 

In short, when I tested them later, both the standard kernel driver and
the one on Intel's website worked without problems.

In between the point where they didn't work and then worked, I've
installed Windows XP 32-bit on it, and the standard driver on the
windows CD didn't work either. I've loaded an updated driver from Intel,
and then it worked on windows.

Thank you.

Best regards,
Gerrit

-----Original Message-----
From: Andrew Morton [mailto:akpm@osdl.org] 
Sent: 16 January 2006 01:00 PM
To: Gerrit Visser
Cc: linux-kernel@vger.kernel.org
Subject: Re: Net: e1000 driver: TX Hang message


If this bug is still present in 2.6.15 could you please create a report
(against 2.6.15) at bugzilla.kenrel.org?

Thanks.

"Gerrit Visser" <g.visser@msc-africa.co.za> wrote:
>
> Hi,
> 
> I've got a DELL precision 670 that has an Intel Gigabit Ethernet
onboard
> NIC (82545GM chipset). It receives packets but keeps on giving "Tx
hang"
> messages and doesn't send any packets.
> 
> Both standard Redhat WS4 (kernel 2.6.9) and kernel 2.6.13.2 did the
> same.
> 
> To fix it, I've changed the following in the file e1000_hw.c:
> 
>     case E1000_DEV_ID_82545GM_COPPER:
>     case E1000_DEV_ID_82545GM_FIBER:
>     case E1000_DEV_ID_82545GM_SERDES:
>         hw->mac_type = e1000_82545_rev_3;
>         break;
> 
> to
> 
>     case E1000_DEV_ID_82545GM_COPPER:
>     case E1000_DEV_ID_82545GM_FIBER:
>     case E1000_DEV_ID_82545GM_SERDES:
>         hw->mac_type = e1000_82545;
>         break;
> 
> (ie. removed the "_rev_3")
> 
> I'm not certain whether it's necessary to change this for copper,
fiber
> and serdes. Mine is a copper (pci id 1026).
> 
> This worked for the Linux e1000 driver from Intel's website, but
exactly
> the same piece of code is in the 2.6.13.2 kernel's e1000 driver.
> 
> Best regards,
> Gerrit
> 
> 
> -
> To unsubscribe from this list: send the line "unsubscribe
linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/






