Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261400AbUDIP1f (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Apr 2004 11:27:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261410AbUDIP1f
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Apr 2004 11:27:35 -0400
Received: from pixpat.austin.ibm.com ([192.35.232.241]:30131 "EHLO
	zircon.austin.ibm.com") by vger.kernel.org with ESMTP
	id S261400AbUDIP1c (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Apr 2004 11:27:32 -0400
Message-ID: <4076C08D.1000408@us.ibm.com>
Date: Fri, 09 Apr 2004 10:26:05 -0500
From: Jon Grimm <jgrimm2@us.ibm.com>
Organization: IBM
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:1.7b) Gecko/20040316
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Philippe Elie <phil.el@wanadoo.fr>
CC: linux-kernel@vger.kernel.org, "Maciej @. Rozycki" <macro@ds2.pg.gda.pl>
Subject: Re: io_apic & timer_ack fix
References: <4076A7AE.8020101@us.ibm.com> <20040409163017.GA392@zaniah>
In-Reply-To: <20040409163017.GA392@zaniah>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Philippe Elie wrote:

>On Fri, 09 Apr 2004 at 08:39 +0000, Jon Grimm wrote:
>
>  
>
>>Hmmm....
>>
>>I see that the following patch got pulled in by Andrew:
>>http://linux.bkbits.net:8080/linux-2.5/diffs/arch/i386/kernel/io_apic.c@1.85?nav=index.html|src/|src/arch|src/arch/i386|src/arch/i386/kernel|hist/arch/i386/kernel/io_apic.c
>>
>>The patch had a couple bugs:
>>http://seclists.org/lists/linux-kernel/2004/Mar/4152.html
>>
>>But the patch was pulled out entirely by Linus:
>>http://linux.bkbits.net:8080/linux-2.5/diffs/arch/i386/kernel/io_apic.c@1.88?nav=index.html|src/|src/arch|src/arch/i386|src/arch/i386/kernel|hist/arch/i386/kernel/io_apic.c
>>
>>Was it determined that the fix was bogus? damaging?  fixable?
>>    
>>
>
>http://marc.theaimsgroup.com/?l=linux-kernel&m=107840458123059&w=2
>
>what's the right fix ? This patch fix timer_ack in three place, the
>two last look like typo (spurious ';' after if ()), the first chunk
>apparently cause higher temp on some mobo.
>
>  
>
I have the spurious ';' removed in my testing.

>>I ask as I see behavior identical for which this patch seems to have 
>>been originally carved up for (buggy SMM BIOS at fault, but this was a 
>>workaround in the OS). 
>>
>>http://marc.theaimsgroup.com/?l=linux-kernel&m=101604672921823&w=2
>>http://www.ussg.iu.edu/hypermail/linux/kernel/0203.2/0698.html
>>
>>Its a fair answer to force the BIOS vendor to fix, but in the meantime, 
>>I'm trying to figure out how safe/unsafe the workaround patch is ?   
>>I've ran on it overnight (with the semi-colon's fixed) and it hasn't 
>>exhibited the troubling behavior (where timer interrupts seem stuck or 
>>in some cases just extremely slow.... and the 8259 IMR is mucked up when 
>>Linux isn't even touching anymore).
>>    
>>
>
>I agree but actually it cause trouble for non bugged mobo, can this fixed ?
>
>  
>

I hope.  It looks like a real problem on a box I have.  

>regards,
>Philippe Elie
>  
>
