Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932229AbVLNJvn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932229AbVLNJvn (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Dec 2005 04:51:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932242AbVLNJvn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Dec 2005 04:51:43 -0500
Received: from mailgate-out2.mysql.com ([213.136.52.68]:28066 "EHLO
	mailgate.mysql.com") by vger.kernel.org with ESMTP id S932229AbVLNJvn
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Dec 2005 04:51:43 -0500
Message-ID: <439FEBC3.4030206@mysql.com>
Date: Wed, 14 Dec 2005 10:54:11 +0100
From: Jonas Oreland <jonas@mysql.com>
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.7.11) Gecko/20050915
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Adrian Yee <brewt-linux-kernel@brewt.org>
CC: john stultz <johnstul@us.ibm.com>, linux-kernel@vger.kernel.org
Subject: Re: tsc clock issues with dual core and question about irq	balancing
References: <GMail.1134458797.49013860.4106109506@brewt.org> <1134522289.3897.21.camel@leatherman> <GMail.1134551267.12292355.45625751005@brewt.org>
In-Reply-To: <GMail.1134551267.12292355.45625751005@brewt.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Adrian Yee wrote:
> Hi John,
> 
> 
>>>I'm currently testing the system with "nosmp noapic acpi=off
>>>clock=tsc" (it was losing interrupts and wouldn't boot properly
>>>with apic/acpi on) and so far everything seems to work (this
>>>includes ssh and desktop usage is better).
>>
>>So keeping the above settings, does removing just the "clock=tsc"
>>cause the sluggishness to appear?
> 
> 
> I just tried booting with the pmtmr enabled and incoming ssh is bad
> (I had an ls pause for over 20 seconds, while another connection was
> somewhat fine).  I wish I had more concrete tests since the problems
> I'm seeing are so subjective.  I guess I'll have to ignore this
> problem until I get a better test.
>  
> 
>>Also would you open a bugzilla bug on this and attach your .config
>>and dmesg?
> 
> 
> Done: http://bugzilla.kernel.org/show_bug.cgi?id=5740
> 
> Thanks.
> 
> Adrian
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

Hi 

Dono if this helps, but

I also had problems with tsc, and ACPI timer wasnt properly detected

http://bugzilla.kernel.org/show_bug.cgi?id=5283 fixed the ACPI problem.

(idle=poll should fix it aswell, i think)

/Jonas
