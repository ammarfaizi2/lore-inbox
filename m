Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261318AbTHXVZG (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 24 Aug 2003 17:25:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261319AbTHXVZG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 24 Aug 2003 17:25:06 -0400
Received: from mx1.redhat.com ([66.187.233.31]:32520 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261318AbTHXVZC (ORCPT
	<rfc822;linux-kernel@vger.redhat.com>);
	Sun, 24 Aug 2003 17:25:02 -0400
Message-ID: <3F492DC7.6040307@sbcglobal.net>
Date: Sun, 24 Aug 2003 16:27:35 -0500
From: Wes Janzen <superchkn@sbcglobal.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i586; en-US; rv:1.4) Gecko/20030624
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Tomasz Torcz <zdzichu@irc.pl>
CC: LKML <linux-kernel@vger.redhat.com>
Subject: Re: 2.6.0-test4 - lost ACPI
References: <20030823105243.GA1245@irc.pl> <20030823145545.2b7d6ec9.akpm@osdl.org> <20030823220438.GB1155@irc.pl>
In-Reply-To: <20030823220438.GB1155@irc.pl>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I don't recall seeing the ACPI disabled line, but mine had the same 
problem halting between PS/2 init and serio.  The change I noticed was 
that IRQ's were being allocated differently, and that is what I 
attributed this failure to.  My motherboard worked with 2.6.0-test3-mm2, 
but has not worked since 2.6.0-test3-mm3 (when the new ACPI code was 
added). 

I'll have to try this acpi=force and pci=noacpi, otherwise I have to 
disable USB and sound to get it to boot. 

Wes

Tomasz Torcz wrote:

>On Sat, Aug 23, 2003 at 02:55:45PM -0700, Andrew Morton wrote:
>  
>
>>Tomasz Torcz <zdzichu@irc.pl> wrote:
>>
>>    
>>
>>> ACPI disabled because your bios is from 00 and too old
>>> ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
>>>      
>>>
>>Add "acpi=force" to your kernel boot command line and everything should work
>>as before.
>>    
>>
>
>It does not work. It halts in beetween ps/2 mouse init and serio init.
>Adding "acpi=force pci=noacpi" solves that.
>
>  
>

