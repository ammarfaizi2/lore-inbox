Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262410AbVCSFz3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262410AbVCSFz3 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 19 Mar 2005 00:55:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262413AbVCSFz3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 19 Mar 2005 00:55:29 -0500
Received: from shawidc-mo1.cg.shawcable.net ([24.71.223.10]:14667 "EHLO
	pd3mo1so.prod.shaw.ca") by vger.kernel.org with ESMTP
	id S262410AbVCSFzV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 19 Mar 2005 00:55:21 -0500
Date: Fri, 18 Mar 2005 23:53:56 -0600
From: Robert Hancock <hancockr@shaw.ca>
Subject: Re: PROBLEM: Buffer I/O error on device hdg1, system freeze.
In-reply-to: <3JuoL-3Mm-3@gated-at.bofh.it>
To: linux-kernel <linux-kernel@vger.kernel.org>
Message-id: <423BBE74.1060902@shaw.ca>
MIME-version: 1.0
Content-type: text/plain; format=flowed; charset=ISO-8859-1
Content-transfer-encoding: 7bit
X-Accept-Language: en-us, en
References: <3JrTL-1C4-23@gated-at.bofh.it> <3JtCc-35h-21@gated-at.bofh.it>
 <3JuoL-3Mm-3@gated-at.bofh.it>
User-Agent: Mozilla Thunderbird 1.0 (Windows/20041206)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nils Radtke wrote:
> Error 14 occurred at disk power-on lifetime: 2249 hours (93 days + 17
> hours)
>   When the command that caused the error occurred, the device was doing
> SMART Offline or Self-test.
> 
>   After command completion occurred, registers were:
>   ER ST SC SN CL CH DH
>   -- -- -- -- -- -- --
>   40 51 f8 23 3e 56 e0  Error: UNC at LBA = 0x00563e23 = 5652003
> 
>   Commands leading to the command that caused the error were:
>   CR FR SC SN CL CH DH DC   Powered_Up_Time  Command/Feature_Name
>   -- -- -- -- -- -- -- --  ----------------  --------------------
>   24 00 f8 07 3e 56 10 00      00:36:28.850  READ SECTOR(S) EXT
>   25 00 00 ff 3d 56 10 00      00:36:28.850  READ DMA EXT
>   25 00 00 ff 3c 56 10 00      00:36:28.850  READ DMA EXT
>   25 00 00 ff 3b 56 10 00      00:36:28.850  READ DMA EXT
>   25 00 00 ff 3a 56 10 00      00:36:28.850  READ DMA EXT
> 
> 
> Could you please explain what these errors mean exactly and what may
> have caused them?
> 
> Might it be possible that these transmission/xxx errors be caused 
> by a bad card and/or driver?
> 
> I'm asking this as the disk never showed errors on onboard IDE ports.
> 
>         Nils
> 

This error is reported by the drive itself, indicating uncorrectable 
errors when attempting to read data from the media. It is quite unlikely 
that the controller or driver is responsible for this sort of error, as 
can occasionally be the case for DMA timeout errors. Almost certainly 
the hard drive is failing.

-- 
Robert Hancock      Saskatoon, SK, Canada
To email, remove "nospam" from hancockr@nospamshaw.ca
Home Page: http://www.roberthancock.com/

