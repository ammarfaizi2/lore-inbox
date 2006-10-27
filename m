Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1946028AbWJ0GMF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946028AbWJ0GMF (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Oct 2006 02:12:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946045AbWJ0GMF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Oct 2006 02:12:05 -0400
Received: from ug-out-1314.google.com ([66.249.92.174]:52687 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1946028AbWJ0GMC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Oct 2006 02:12:02 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=YXKyg6SQYoTbRI0vUr9QGGClXC58DFgx7WdQ42dOMUzPC47l01bClYFxgPGbapooCPERXJmG2UHkQNhwchqQCmdw9ULrVR2t0tfSRORP4fJRRzj0udjxuD6UjkNlm1I6QeqQbx8pqQfQxdB17h7Lvbhn9viMkyIpJTtLpqQZ/X8=
Message-ID: <4541A325.6030102@gmail.com>
Date: Thu, 26 Oct 2006 23:11:49 -0700
From: Om Narasimhan <om.turyx@gmail.com>
User-Agent: Thunderbird 1.5.0.7 (X11/20060913)
MIME-Version: 1.0
To: Andi Kleen <ak@muc.de>
CC: "Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>,
       linux-kernel@vger.kernel.org, randy.dunlap@oracle.com,
       clemens@ladisch.de, vojtech@suse.cz, bob.picco@hp.com
Subject: Re: HPET : Legacy Routing Replacement Enable - 3rd try.
References: <EB12A50964762B4D8111D55B764A8454C9608C@scsmsx413.amr.corp.intel.com> <6b4e42d10610251420x4365b840sa3232010e7bd7f73@mail.gmail.com> <20061027024238.GC58088@muc.de>
In-Reply-To: <20061027024238.GC58088@muc.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen wrote:
>> 1. HW is LRR capable, HPET ACPI it is 1, timer interrupt is on INT2.
>> Before the fix: Linux cannot get timer interrupts on INT0, goes for ACPI 
>> timer.
> 
> What ACPI timer?  I don't think we have any fallback for int 0.
Sorry, Mea Culpa, I should have written APIC timer.
> 
> Not sure what you mean with INT2. Pin2 on ioapic 0 perhaps?
Yes. PIN2 on IOAPIC #0.
> 
>> After the fix : Works fine. This is according to hpet spec.
> 
> On what exact motherboard was that?
SunFire X4600
> 
>> To handle case 3, I removed all references to acpi_hpet_lrr, explained
>> this case in the code and decided to solely rely on the command line
>> parameter for LRR capability. Rational for this approach is ,
> 
> This means the systems which you said fixes this would need the command
> line parameter to work? 
I feel I do not make things clear enough.
The command line parameter can be avoided entirely if majority of the BIOSes implement LRR routing correctly. I would rewrite the patch to avoid cmdline parameter and according to Andrew Morton's suggestions.

Thanks,
Om.
