Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261182AbVAAVWr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261182AbVAAVWr (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 1 Jan 2005 16:22:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261183AbVAAVWr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 1 Jan 2005 16:22:47 -0500
Received: from a26.t1.student.liu.se ([130.236.221.26]:20936 "EHLO
	mail.drzeus.cx") by vger.kernel.org with ESMTP id S261182AbVAAVWm
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 1 Jan 2005 16:22:42 -0500
Message-ID: <41D71496.2010904@drzeus.cx>
Date: Sat, 01 Jan 2005 22:22:30 +0100
From: Pierre Ossman <drzeus-list@drzeus.cx>
User-Agent: Mozilla Thunderbird 0.9 (X11/20041127)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Tim Hockin <thockin@hockin.org>
CC: LKML <linux-kernel@vger.kernel.org>
Subject: Re: APIC, changing level/edge interrupt
References: <41D1977D.2000600@drzeus.cx> <20050101054925.GA13925@hockin.org> <41D6C81F.1090106@drzeus.cx> <20050101202450.GA19360@hockin.org>
In-Reply-To: <20050101202450.GA19360@hockin.org>
X-Enigmail-Version: 0.89.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Tim Hockin wrote:

>Of course.  My point was that if it does not, it's a bug in the BIOS.  
>
>  
>
Something Windows doesn't seem to be affected by so I don't think we'll 
get much help fixing the bios.

>>But since BIOS can configure the APIC then the kernel should be able to 
>>    
>>
>
>Of course, but the kernel has no way to know whether a device should be
>edge or level triggered unless you have a driver for that device.  And
>even if you do, I don't know that there is an API in kernel to say
>set_irq_mode(IRQ_EDGE) (though there could be).
>
>  
>
There are some calls in the ACPI layer which plays with the level/edge 
stuff but they don't seem very generic. Besides, what I want right now 
is just some possibility of confirming that this level/edge business is 
the cause of all these problems.

>>What is the default mode and what does the XT-PIC expect? (it works fine 
>>with the apic disabled).
>>    
>>
>
>I think default is PIC-compatible which is edge by default.  I think.  I
>don;t have the book here.
>
>  
>
Ok. The default from the device is level mode which works fine on PIC 
systems. I'm not sure that the hardware actually respects this bit 
because level/pulse mode doesn't make any difference on either PIC or 
APIC systems.

Rgds
Pierre

