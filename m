Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750871AbWCGN6j@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750871AbWCGN6j (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Mar 2006 08:58:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751200AbWCGN6j
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Mar 2006 08:58:39 -0500
Received: from shawidc-mo1.cg.shawcable.net ([24.71.223.10]:14659 "EHLO
	pd3mo3so.prod.shaw.ca") by vger.kernel.org with ESMTP
	id S1750871AbWCGN6j (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Mar 2006 08:58:39 -0500
Date: Tue, 07 Mar 2006 07:58:37 -0600
From: Robert Hancock <hancockr@shaw.ca>
Subject: Re: de2104x: interrupts before interrupt handler is registered
In-reply-to: <Pine.LNX.4.61.0603070705490.8536@chaos.analogic.com>
To: "linux-os (Dick Johnson)" <linux-os@analogic.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Message-id: <440D918D.2000502@shaw.ca>
MIME-version: 1.0
Content-type: text/plain; charset=ISO-8859-1; format=flowed
Content-transfer-encoding: 7bit
References: <5N5Ql-30C-11@gated-at.bofh.it> <5NnDE-44v-11@gated-at.bofh.it>
 <440CCD9A.3070907@shaw.ca>
 <Pine.LNX.4.61.0603070705490.8536@chaos.analogic.com>
User-Agent: Thunderbird 1.5 (Windows/20051201)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

linux-os (Dick Johnson) wrote:
> No. It would be good if that was true. Unfortunately, the IRQ
> returned before the pci_enable_device() is not correct. It
> gets re-written by pci_enable_device().

That wasn't what I meant, yes, that is true in the current kernel. 
However, any device which would start generating interrupts just because 
  its BARs got enabled by pci_enable_device seems broken.

The driver needs to request the interrupt after the device is enabled, 
and only after that can it enable the device to generate interrupts.

-- 
Robert Hancock      Saskatoon, SK, Canada
To email, remove "nospam" from hancockr@nospamshaw.ca
Home Page: http://www.roberthancock.com/

