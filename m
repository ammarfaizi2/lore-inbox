Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751267AbWEWGod@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751267AbWEWGod (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 May 2006 02:44:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751215AbWEWGod
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 May 2006 02:44:33 -0400
Received: from euklides.vdsoft.org ([82.208.56.17]:56798 "EHLO
	euklides.vdsoft.org") by vger.kernel.org with ESMTP
	id S1751101AbWEWGoc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 May 2006 02:44:32 -0400
Message-ID: <4472AF4E.7010206@vdsoft.org>
Date: Tue, 23 May 2006 08:44:30 +0200
From: Vladimir Dvorak <dvorakv@vdsoft.org>
User-Agent: Debian Thunderbird 1.0.7 (X11/20051017)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Brown, Len" <len.brown@intel.com>
CC: Jan Engelhardt <jengelh@linux01.gwdg.de>, Andi Kleen <ak@suse.de>,
       linux-kernel@vger.kernel.org
Subject: Re: APIC error on CPUx
References: <CFF307C98FEABE47A452B27C06B85BB681D44D@hdsmsx411.amr.corp.intel.com>
In-Reply-To: <CFF307C98FEABE47A452B27C06B85BB681D44D@hdsmsx411.amr.corp.intel.com>
X-Enigmail-Version: 0.93.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Brown, Len wrote:

> 
>  
>
>>The problem goes away with noapic or acpi=off, but of course that also 
>>means you don't have IRQs > 15.
>>    
>>
>
>"acpi=off" is a superset of "noapic" here, presumably because the
>board doesn't have MPS  tables that describe the IOAPIC when ACPI is
>off.
>
>"noapic" is a perfectly reasonable thing to use if you don't
>have a lot of interrupt sources and there is no more sharing
>in PIC mode than IOAPIC mode.
>
>The advantage of using IOAPIC mode is that the system has more interrupt
>pins
>availalble and this allows sharing to be avoided.  It also allows
>the system to target the interrupts to any processor when you
>have more than one.
>
>cheers,
>-Len
>
>  
>
My experience yesterday:

Server with  'noapic' cannot boot, kernel reports something like "Lost
interrupt: hde"  ( it was said by my college, server is not in my
physical control ) . With 'acpi=off' it boots, but errors appear again.

Brief datasheet about the board is here:
http://www.abclinuxu.cz/images/hosting/sr1200.pdf

Vladimir
