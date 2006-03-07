Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932587AbWCGBQs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932587AbWCGBQs (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Mar 2006 20:16:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932589AbWCGBQs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Mar 2006 20:16:48 -0500
Received: from shawidc-mo1.cg.shawcable.net ([24.71.223.10]:18623 "EHLO
	pd3mo2so.prod.shaw.ca") by vger.kernel.org with ESMTP
	id S932587AbWCGBQr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Mar 2006 20:16:47 -0500
Date: Mon, 06 Mar 2006 18:02:34 -0600
From: Robert Hancock <hancockr@shaw.ca>
Subject: Re: de2104x: interrupts before interrupt handler is registered
In-reply-to: <5NnDE-44v-11@gated-at.bofh.it>
To: linux-kernel <linux-kernel@vger.kernel.org>
Message-id: <440CCD9A.3070907@shaw.ca>
MIME-version: 1.0
Content-type: text/plain; charset=ISO-8859-1; format=flowed
Content-transfer-encoding: 7bit
References: <5N5Ql-30C-11@gated-at.bofh.it> <5NnDE-44v-11@gated-at.bofh.it>
User-Agent: Thunderbird 1.5 (Windows/20051201)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

linux-os (Dick Johnson) wrote:
> This started to happen in a lot of PCI drivers once it became
> necessary to call pci_enable_device() in order to make the
> returned IRQ values valid. This has been reported numerious
> times and has not been fixed. Basically, in order to get
> the correct value, one needs to disable the board in some
> unspecified way so it is not possible for it to generate
> an interrupt before enabling the board. With some devices
> this may not be possible!

What kind of board behaves that way? pci_enable_device just enables the 
device BARs and wakes it up if it was suspended, I should think that any 
device that starts generating interrupts from that must be quite broken..

-- 
Robert Hancock      Saskatoon, SK, Canada
To email, remove "nospam" from hancockr@nospamshaw.ca
Home Page: http://www.roberthancock.com/

