Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751770AbWJVHKI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751770AbWJVHKI (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 Oct 2006 03:10:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750805AbWJVHKD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 Oct 2006 03:10:03 -0400
Received: from shawidc-mo1.cg.shawcable.net ([24.71.223.10]:43150 "EHLO
	pd3mo3so.prod.shaw.ca") by vger.kernel.org with ESMTP
	id S1750721AbWJVHKB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 Oct 2006 03:10:01 -0400
Date: Sun, 22 Oct 2006 01:09:58 -0600
From: Robert Hancock <hancockr@shaw.ca>
Subject: Re: [PATCH] sata_nv ADMA/NCQ support for nForce4 (updated) II
In-reply-to: <p73ejt1m5gj.fsf_-_@verdi.suse.de>
To: Andi Kleen <ak@suse.de>
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org
Message-id: <453B1946.3070201@shaw.ca>
MIME-version: 1.0
Content-type: text/plain; charset=ISO-8859-1; format=flowed
Content-transfer-encoding: 7bit
References: <45397D22.4030200@shaw.ca> <p73iridm5rk.fsf@verdi.suse.de>
 <p73ejt1m5gj.fsf_-_@verdi.suse.de>
User-Agent: Thunderbird 1.5.0.7 (Windows/20060909)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen wrote:
> Andi Kleen <ak@suse.de> writes:
> 
>> I tested it on a NF4-Professional system with 8GB RAM and a single 
>> SATA disk. It first did nicely in LTP and some other tests,
>> but during a bonnie++ run it eventually blocked with all
>> IO hanging forever. No output either. I did a full backtrace
>> and it just showed the processes waiting for a IO wakeup.
> 
> Hmm, to follow myself up: after a few more minutes the machine recovered
> and i could log in again (overall the stall was at least 5+ minutes
> though)
> 
> Not sure whom to blame, the IO driver might be actually innocent
> and it just be one of the usual known but unfixed IO starvation problems.
> 
> -Andi

Hmm.. The system hanging up for 5 minutes and then recovering seems 
rather odd, as far as I know the timeouts in libata are all quite a bit 
shorter than that. Was there anything unusual in dmesg? If the IO 
commands weren't completing at the driver level then I would expect the 
error handling to kick in in some fashion..

-- 
Robert Hancock      Saskatoon, SK, Canada
To email, remove "nospam" from hancockr@nospamshaw.ca
Home Page: http://www.roberthancock.com/
