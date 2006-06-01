Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751685AbWFAD2u@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751685AbWFAD2u (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 31 May 2006 23:28:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751695AbWFAD2t
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 31 May 2006 23:28:49 -0400
Received: from shawidc-mo1.cg.shawcable.net ([24.71.223.10]:25475 "EHLO
	pd5mo2so.prod.shaw.ca") by vger.kernel.org with ESMTP
	id S1751684AbWFAD2t (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 31 May 2006 23:28:49 -0400
Date: Wed, 31 May 2006 21:27:41 -0600
From: Robert Hancock <hancockr@shaw.ca>
Subject: Re: [git patch] libata resume fix
In-reply-to: <6iH3h-2xw-59@gated-at.bofh.it>
To: Bill Davidsen <davidsen@tmr.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Message-id: <447E5EAD.5070808@shaw.ca>
MIME-version: 1.0
Content-type: text/plain; charset=ISO-8859-1; format=flowed
Content-transfer-encoding: 7bit
References: <6hAdo-5CV-5@gated-at.bofh.it> <6hXD0-6Y9-1@gated-at.bofh.it>
 <6icsx-4vp-33@gated-at.bofh.it> <6ih8Y-3ba-15@gated-at.bofh.it>
 <6iH3h-2xw-59@gated-at.bofh.it>
User-Agent: Thunderbird 1.5.0.2 (Windows/20060308)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bill Davidsen wrote:
> The trade-off is that if I have a 15k rpm SCSI drive, it would take a 
> lot of design changes to make it spin up quickly, and improve a function 
> which is usually done on a server once every MTBF when replacing the 
> failed unit.
> 
> I think the majority of very large or very fast drives are in systems 
> which don't (deliberately) power cycles often, in rooms where heat is an 
> issue. And to spin up quickly take a larger power supply... 30 sec is 
> fine with most users.
> 
> Couldn't find a spin-up time for the new Seagate 750GB drive, but the 
> seek sure is fast!

I wouldn't guess that even a 15K drive would take nearly that long. For 
boot time on servers it doesn't matter much though, disk spinup time is 
in the noise compared to the insane BIOS delays on most of them during 
bootup. Like on some servers (ahem.. IBM) which have about a 15 second 
delay on the main BIOS screen, 10 second delays on every network boot 
ROM, a 1 minute delay on the SCSI controller before it even starts 
scanning the bus, then another good 10 seconds before it starts booting. 
Gets annoying after a few reboots..

-- 
Robert Hancock      Saskatoon, SK, Canada
To email, remove "nospam" from hancockr@nospamshaw.ca
Home Page: http://www.roberthancock.com/

