Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964812AbWCHAFJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964812AbWCHAFJ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Mar 2006 19:05:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964813AbWCHAFJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Mar 2006 19:05:09 -0500
Received: from shawidc-mo1.cg.shawcable.net ([24.71.223.10]:5424 "EHLO
	pd2mo1so.prod.shaw.ca") by vger.kernel.org with ESMTP
	id S964812AbWCHAFH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Mar 2006 19:05:07 -0500
Date: Tue, 07 Mar 2006 18:05:04 -0600
From: Robert Hancock <hancockr@shaw.ca>
Subject: Re: de2104x: interrupts before interrupt handler is registered
In-reply-to: <Pine.LNX.4.61.0603071306070.9728@chaos.analogic.com>
To: "linux-os (Dick Johnson)" <linux-os@analogic.com>
Cc: Bjorn Helgaas <bjorn.helgaas@hp.com>,
       linux-kernel <linux-kernel@vger.kernel.org>
Message-id: <440E1FB0.6030300@shaw.ca>
MIME-version: 1.0
Content-type: text/plain; charset=ISO-8859-1; format=flowed
Content-transfer-encoding: 7bit
References: <5N5Ql-30C-11@gated-at.bofh.it> <440D918D.2000502@shaw.ca>
 <Pine.LNX.4.61.0603070908460.9133@chaos.analogic.com>
 <200603071051.35791.bjorn.helgaas@hp.com>
 <Pine.LNX.4.61.0603071306070.9728@chaos.analogic.com>
User-Agent: Thunderbird 1.5 (Windows/20051201)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

linux-os (Dick Johnson) wrote:
> There are now other "standard" boards that seem to be experiencing
> the same problem. Maybe it is time to make a procedure that turns
> off interrupts for a specific device (not an unknown IRQ). Then
> a subsequent call turns them on after the handler is in place.
> This wouldn't affect current drivers. They would still turn on
> hot by default.

How do you propose to do this? There's no way to mask interrupts from 
just one device which is sharing an IRQ line, you have to mask 
interrupts from all of those devices. That would be quite ugly IMHO if 
one device could disable the interrupt used by another device for 
however long it felt like.

-- 
Robert Hancock      Saskatoon, SK, Canada
To email, remove "nospam" from hancockr@nospamshaw.ca
Home Page: http://www.roberthancock.com/

