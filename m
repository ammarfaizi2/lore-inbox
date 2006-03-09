Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932108AbWCIACd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932108AbWCIACd (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Mar 2006 19:02:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932616AbWCIACd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Mar 2006 19:02:33 -0500
Received: from shawidc-mo1.cg.shawcable.net ([24.71.223.10]:31039 "EHLO
	pd5mo3so.prod.shaw.ca") by vger.kernel.org with ESMTP
	id S932108AbWCIACc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Mar 2006 19:02:32 -0500
Date: Wed, 08 Mar 2006 18:02:07 -0600
From: Robert Hancock <hancockr@shaw.ca>
Subject: Re: de2104x: interrupts before interrupt handler is registered
In-reply-to: <5O23T-59S-15@gated-at.bofh.it>
To: Jesse Brandeburg <jesse.brandeburg@gmail.com>,
       linux-kernel <linux-kernel@vger.kernel.org>
Message-id: <440F707F.8010001@shaw.ca>
MIME-version: 1.0
Content-type: text/plain; charset=ISO-8859-1; format=flowed
Content-transfer-encoding: 7bit
References: <5Nz1Y-4hZ-25@gated-at.bofh.it> <5NKTG-4F7-21@gated-at.bofh.it>
 <5NLmp-5sk-5@gated-at.bofh.it> <5NODG-1RH-3@gated-at.bofh.it>
 <5O23T-59S-15@gated-at.bofh.it>
User-Agent: Thunderbird 1.5 (Windows/20051201)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jesse Brandeburg wrote:
> FWIW, I'd be interested in following up on something like this in
> another thread because e100 appears to have (at least in one
> reporter's dual e100 machine) a similar "hardware problem" where a
> shared interrupt line gets asserted too early and the kernel prints a
> Nobody Cared message.
> 
> So we have a new way of doing things that exposes more broken
> hardware, shouldn't we provide a way for that hardware to continue
> working?

I'm not sure this is at all related to the case we're talking about - it 
doesn't matter whether the request_irq or pci_enable_device comes first 
as the device is pulling on the interrupt line before the driver is even 
loaded. To fix that I'd think you'd need some kind of PCI quirk that 
would shut off the interrupt on the e100 card before any devices request 
the interrupt that it is sharing.

-- 
Robert Hancock      Saskatoon, SK, Canada
To email, remove "nospam" from hancockr@nospamshaw.ca

