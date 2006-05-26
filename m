Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751211AbWEZBwd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751211AbWEZBwd (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 May 2006 21:52:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751253AbWEZBwd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 May 2006 21:52:33 -0400
Received: from shawidc-mo1.cg.shawcable.net ([24.71.223.10]:19775 "EHLO
	pd3mo1so.prod.shaw.ca") by vger.kernel.org with ESMTP
	id S1751211AbWEZBwc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 May 2006 21:52:32 -0400
Date: Thu, 25 May 2006 19:52:23 -0600
From: Robert Hancock <hancockr@shaw.ca>
Subject: Re: PCI reset using x86 or x86-64 BIOS calls?
In-reply-to: <6gr2t-1Pp-9@gated-at.bofh.it>
To: Linas Vepstas <linas@austin.ibm.com>,
       linux-kernel <linux-kernel@vger.kernel.org>
Message-id: <44765F57.90703@shaw.ca>
MIME-version: 1.0
Content-type: text/plain; charset=ISO-8859-1; format=flowed
Content-transfer-encoding: 7bit
References: <6gr2t-1Pp-9@gated-at.bofh.it>
User-Agent: Thunderbird 1.5.0.2 (Windows/20060308)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linas Vepstas wrote:
> I've go a newbie x86 BIOS question:  is there a BIOS function that 
> can be called to reset a PCI device? (By "reset a device" I mean
> raise the #RST PCI signal line to electrical high for 1.5 seconds).
> I know that BIOS does this during a soft reboot, but I was wondering
> if there's a stand-alone function for doing this while the system is up
> and running.

Unlikely - if you mean just resetting one PCI device, it's likely 
electrically impossible on many, if not most machines as the RST lines 
will be tied together on all slots.

The BIOS might possibly have the ability to issue a PCI bus reset 
independent of resetting the CPU, chipset, etc. but I don't think 
there's any standardized way to trigger this, even so.

In any case, I don't think - or at least would hope - that a PCI device 
going so far into the weeds that it can't be recovered without a RST 
would be a rare situation.

-- 
Robert Hancock      Saskatoon, SK, Canada
To email, remove "nospam" from hancockr@nospamshaw.ca
Home Page: http://www.roberthancock.com/

