Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262185AbVBQOjr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262185AbVBQOjr (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Feb 2005 09:39:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262187AbVBQOjr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Feb 2005 09:39:47 -0500
Received: from fsmlabs.com ([168.103.115.128]:60344 "EHLO fsmlabs.com")
	by vger.kernel.org with ESMTP id S262193AbVBQOjn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Feb 2005 09:39:43 -0500
Date: Thu, 17 Feb 2005 07:40:41 -0700 (MST)
From: Zwane Mwaikambo <zwane@arm.linux.org.uk>
To: Joshua Kwan <joshk@triplehelix.org>
cc: Linux Kernel <linux-kernel@vger.kernel.org>, hostap@shmoo.com
Subject: Re: 2.6.10: irq 12 nobody cared!
In-Reply-To: <4214450B.6090006@triplehelix.org>
Message-ID: <Pine.LNX.4.61.0502170713110.26742@montezuma.fsmlabs.com>
References: <4214450B.6090006@triplehelix.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 16 Feb 2005, Joshua Kwan wrote:

>            CPU0
>   0:    1073809          XT-PIC  timer
>   1:       1291          XT-PIC  i8042
>   2:          0          XT-PIC  cascade
>   4:          7          XT-PIC  serial
>   5:       4366          XT-PIC  eth0
>   7:         12          XT-PIC  parport0
>   8:          1          XT-PIC  rtc
>  10:       7698          XT-PIC  uhci_hcd, uhci_hcd, eth1
>  11:      58320          XT-PIC  ide2, ide3
>  12:     306731          XT-PIC  wifi0
>  14:      24446          XT-PIC  ide0
>  15:         13          XT-PIC  ide1
> NMI:          0
> ERR:          0
> 
> that IRQ 12 is a wireless device:
> 
> 0000:00:09.0 Network controller: Intersil Corporation Prism 2.5 Wavelan
> chipset (rev 01)
> 
> that gets handled by HostAP. The device is operating correctly.
> 
> What's to blame here?

Check that the hostap interrupt handler is 2.6 aware (IRQ_HANDLED etc)
