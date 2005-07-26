Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261761AbVGZNTN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261761AbVGZNTN (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Jul 2005 09:19:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261767AbVGZNTN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Jul 2005 09:19:13 -0400
Received: from prgy-npn1.prodigy.com ([207.115.54.37]:49412 "EHLO
	oddball.prodigy.com") by vger.kernel.org with ESMTP id S261761AbVGZNTM
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Jul 2005 09:19:12 -0400
Message-ID: <42E63946.3040305@tmr.com>
Date: Tue, 26 Jul 2005 09:23:18 -0400
From: Bill Davidsen <davidsen@tmr.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.8) Gecko/20050511
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Brown, Len" <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
CC: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: ACPI oddity
References: <F7DC2337C7631D4386A2DF6E8FB22B300424AE17@hdsmsx401.amr.corp.intel.com>
In-Reply-To: <F7DC2337C7631D4386A2DF6E8FB22B300424AE17@hdsmsx401.amr.corp.intel.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Brown, Len wrote:
>>On a HT system, why does ACPI recognize CPU0 and CPU1, refer 
>>to them as such in dmesg
> 
> 
> This is the Linux CPU number. ie the namespace where 0
> is the boot processor and the others are numbered in
> the order that they were started.
> 
> 
>>and then call them CPU1 and CPU2 in 
>>/proc/acpi/processor?
> 
> 
> These are arbitrary device identifiers written
> by the BIOS developer and foolishly advertised
> to the user by Linux.  The BIOS writer could have
> also called them ABC9 and XYZ4 and it would be
> equally valid.

Which explains why they are CPU1 and CPU2 on ASUS and CPU0 and CPU1 on 
another system. I was hoping I had found something for the person who 
was having problems with the P4P800 mobo, but looks like it's not here.
> 
> We're planning to get rid of all the ACPI stuff
> in /proc and move to sysfs.  At that time we'll
> use device identifies that are deterministic,
> like cpu%d that /sys/devices/system uses today.

Whatever, it's cosmetic and there seem to be more important problems 
with APIC than /proc vs. /sys.

Thanks for the clarification.


-- 
    -bill davidsen (davidsen@tmr.com)
"The secret to procrastination is to put things off until the
  last possible moment - but no longer"  -me
