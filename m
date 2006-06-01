Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750936AbWFAX3E@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750936AbWFAX3E (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Jun 2006 19:29:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750952AbWFAX3E
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Jun 2006 19:29:04 -0400
Received: from shawidc-mo1.cg.shawcable.net ([24.71.223.10]:32600 "EHLO
	pd4mo2so.prod.shaw.ca") by vger.kernel.org with ESMTP
	id S1750936AbWFAX3C (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Jun 2006 19:29:02 -0400
Date: Thu, 01 Jun 2006 17:28:52 -0600
From: Robert Hancock <hancockr@shaw.ca>
Subject: Re: io apic and shared irq questions
In-reply-to: <6iROY-2Dc-17@gated-at.bofh.it>
To: linux-kernel <linux-kernel@vger.kernel.org>, sancelot@free.fr
Message-id: <447F7834.50102@shaw.ca>
MIME-version: 1.0
Content-type: text/plain; charset=ISO-8859-1; format=flowed
Content-transfer-encoding: 7bit
References: <6iROY-2Dc-17@gated-at.bofh.it>
User-Agent: Thunderbird 1.5.0.2 (Windows/20060308)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

s.a. wrote:
> Hi,
> 
> Regarding an embedded realtime system, I have got a communication board
> on pci bus .
> 
> I would like it's interrupt not being shared (with usb) , because the
> component receives an it every 100us and is realtime determinist.
> I looked at how was routed IRQ's with the io apic , although it is able
> to use 24 irq's, linux always share my PCI boards IRQ with another
> component and do not use all the 24 irq's range capability of ioapic.
> 
> Do you think it is possible to program the ioapic in order to have a
> better irq mapping and avoid this problem and use all the range of
> availbale vectors ?
> 
> Best Regards
> Steph

This may depend on the hardware, but as far as I know, usually the 
IOAPIC interrupt mapping is the same as the physical wiring of the 
interrupt lines on the board. If the devices use the same physical 
interrupt line, there is no way to separate them.

-- 
Robert Hancock      Saskatoon, SK, Canada
To email, remove "nospam" from hancockr@nospamshaw.ca
Home Page: http://www.roberthancock.com/

