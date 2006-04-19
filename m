Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750715AbWDSCoO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750715AbWDSCoO (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Apr 2006 22:44:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750722AbWDSCoO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Apr 2006 22:44:14 -0400
Received: from shawidc-mo1.cg.shawcable.net ([24.71.223.10]:4958 "EHLO
	pd2mo1so.prod.shaw.ca") by vger.kernel.org with ESMTP
	id S1750715AbWDSCoN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Apr 2006 22:44:13 -0400
Date: Tue, 18 Apr 2006 20:44:03 -0600
From: Robert Hancock <hancockr@shaw.ca>
Subject: Re: [PATCH 1/1] ide: Allow disabling of UDMA for Compact Flash devices
In-reply-to: <631pe-5Gt-7@gated-at.bofh.it>
To: linux-kernel <linux-kernel@vger.kernel.org>
Cc: James Ausmus <james.ausmus@gmail.com>
Message-id: <4445A3F3.6050907@shaw.ca>
MIME-version: 1.0
Content-type: text/plain; charset=ISO-8859-1; format=flowed
Content-transfer-encoding: 7bit
References: <62LaJ-6vK-5@gated-at.bofh.it> <62Wg0-6f8-29@gated-at.bofh.it>
 <62WJ1-6Od-31@gated-at.bofh.it> <62WSE-70D-21@gated-at.bofh.it>
 <631pe-5Gt-7@gated-at.bofh.it>
User-Agent: Thunderbird 1.5 (Windows/20051201)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

James Ausmus wrote:
> This is exactly the situation that I have with 2 separate "dumb" (just
> physical interfaces, essentially - not at all detectable) IDE->CF
> adapters - both the IDE controller and the CF media support several
> UDMA modes, so the IDE driver throws the CF device into UDMA mode on
> bootup. However, as the physical interface between the IDE cable and
> the CF socket is poorly engineered, it cannot handle the higher
> speeds, causing the timeout errors. For some people, this can just be
> fixed with an ide=nodma boot option, but as I also have a (quite
> large) rotating media device on the controller, this is not an option,
> as, if a fsck is performed on a boot, the boot-up time is upwards of
> 30 minutes.

If it's like some of the CF-IDE adapters I've seen, the DMA request/ack 
lines likely aren't even wired up between the card and the cable. 
There's no way the kernel can detect that DMA is not actually possible 
on such a card without trying and waiting for it to timeout. (I've seen 
a few which have jumpers which select whether to connect these or not - 
haven't a clue why you wouldn't want to hook those up unconditionally..)

Isn't there an option to disable DMA for a specific IDE channel 
(ide2=nodma or something like that)?

-- 
Robert Hancock      Saskatoon, SK, Canada
To email, remove "nospam" from hancockr@nospamshaw.ca
Home Page: http://www.roberthancock.com/

