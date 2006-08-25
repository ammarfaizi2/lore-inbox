Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030440AbWHYANw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030440AbWHYANw (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Aug 2006 20:13:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030290AbWHYANw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Aug 2006 20:13:52 -0400
Received: from shawidc-mo1.cg.shawcable.net ([24.71.223.10]:17125 "EHLO
	pd5mo2so.prod.shaw.ca") by vger.kernel.org with ESMTP
	id S1030440AbWHYANv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Aug 2006 20:13:51 -0400
Date: Thu, 24 Aug 2006 18:12:00 -0600
From: Robert Hancock <hancockr@shaw.ca>
Subject: Re: Generic Disk Driver in Linux
In-reply-to: <fa.RkJMFmeAVY9kZAODCPJ1Yc8Vtww@ifi.uio.no>
To: Daniel Rodrick <daniel.rodrick@gmail.com>
Cc: linux-kernel@vger.kernel.org, kernelnewbies <kernelnewbies@nl.linux.org>,
       linux-newbie@vget.kernel.org
Message-id: <44EE4050.7020608@shaw.ca>
MIME-version: 1.0
Content-type: text/plain; charset=ISO-8859-1; format=flowed
Content-transfer-encoding: 7bit
References: <fa.RkJMFmeAVY9kZAODCPJ1Yc8Vtww@ifi.uio.no>
User-Agent: Thunderbird 1.5.0.5 (Windows/20060719)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Daniel Rodrick wrote:
> Hi List,
> 
> I was curious that can we develop a generic disk driver that could
> handle all the kinds of hard drives - IDE, SCSI, RAID et al?
> 
> I thought we could use the BIOS interrupt 13H for this purpose, but
> ran into a LOT of real mode / protected mode issues.
> 
> Any other ideas?

Aside from the real/protected mode issues (which are pretty much a 
show-stopper right there), the performance would be horrible. Usually 
the Interrupt 13 code on especially the more advanced controllers like 
hardware RAID, etc. is designed solely to function, with little 
attention to speed, and the performance tends to be horrible - look at 
versions of Ghost that run into DOS and look how long it takes to image 
a drive connected to an IBM ServeRAID controller..

-- 
Robert Hancock      Saskatoon, SK, Canada
To email, remove "nospam" from hancockr@nospamshaw.ca
Home Page: http://www.roberthancock.com/

