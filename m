Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267630AbSLSWU0>; Thu, 19 Dec 2002 17:20:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267670AbSLSWPR>; Thu, 19 Dec 2002 17:15:17 -0500
Received: from pop015pub.verizon.net ([206.46.170.172]:26752 "EHLO
	pop015.verizon.net") by vger.kernel.org with ESMTP
	id <S267664AbSLSWOd>; Thu, 19 Dec 2002 17:14:33 -0500
Message-ID: <3E0246C7.3010503@verizon.net>
Date: Thu, 19 Dec 2002 17:23:03 -0500
From: Stephen Wille Padnos <stephen.willepadnos@verizon.net>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:1.2.1) Gecko/20021130
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: John Bradford <john@grabjohn.com>
CC: "Randy.Dunlap" <rddunlap@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: Dedicated kernel bug database
References: <200212192155.gBJLtV6k003254@darkstar.example.net>
In-Reply-To: <200212192155.gBJLtV6k003254@darkstar.example.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Authentication-Info: Submitted using SMTP AUTH PLAIN at pop015.verizon.net from [64.223.83.18] at Thu, 19 Dec 2002 16:22:27 -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hmmm.

It seems to me that a kernel bug tracking system has to have a pretty 
good knowledge (database) of  the kernel(s) it is meant to track. 
 Essentially, a user who has a problem can usually identify what the 
problem is ("my external firewire HD doesn't work"), but not where the 
cause may be (interrupts / filesystem drivers / mount tools / scsi 
generic / sbp2 / ieee1394 / pci / ACPI / APIC / VM / ...).

So, if a user could enter some keywords for their problem and get a list 
of possible subsystems that it depends on (along with maintainers for 
those subsystems), we'd be getting somewhere.

For the usb / apic / acpi / rtl8139 problem, I would enter something 
like USB keyboard, 8139too, local APIC, IO-APIC, VIA kt333, kernel 2.5.45-51

The wizardly database (knowing what each "leaf device" depends on), then 
finds the intersection of  subsystems that affect all (or some specified 
percentage) of the things the keywords match.

This requires a tree of dependencies (pretty much there - look at what 
headers are included in each source file) for each driver.

Of course, there are things that everything depends on (VM), which would 
probably want to be left out unless no higher level common ancestor of 
the problems can be found.

The trouble with searching a flat bug database is that you have to know 
what you're looking for.  If the bug tracker actually helped figure out 
the problem (where possible, of course), that would be a boon.

John Bradford wrote:

[snip snip]

>>| Overall, though, would you rather be presented with a list of
>>| categories, or a list of people and what parts of the code they
>>| maintain.  Personally, I think that a list of people is more
>>| intuitive, rather than an abstract list of categories, but I could be
>>| wrong.
>>
>>Do we have anyone targeted for interrupt routing problems (PIC, IO APIC,
>>ACPI, etc.)?
>>    
>>
>
>No.  I nominate Alan :-).
>
Agreed.  (can he be elected without knowing he's on the ballot? :)


