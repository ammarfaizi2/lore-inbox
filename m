Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964786AbVITSEz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964786AbVITSEz (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Sep 2005 14:04:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964788AbVITSEz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Sep 2005 14:04:55 -0400
Received: from enterprise.francisscott.net ([64.235.237.105]:14091 "EHLO
	enterprise.francisscott.net") by vger.kernel.org with ESMTP
	id S964785AbVITSEy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Sep 2005 14:04:54 -0400
Message-ID: <43304F96.6000805@lampert.org>
Date: Tue, 20 Sep 2005 11:06:14 -0700
From: Scott Lampert <scott@lampert.org>
User-Agent: Mozilla Thunderbird 1.0.6 (Macintosh/20050716)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Frank van Maarseveen <frankvm@frankvm.com>
CC: Marc Perkel <marc@perkel.com>, linux-kernel@vger.kernel.org
Subject: Re: Lost Ticks
References: <432E3D4C.4070508@perkel.com> <20050920070214.GA4208@janus>
In-Reply-To: <20050920070214.GA4208@janus>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have the exact same problem on a ASUS A8N-SLI Premium board and 
Athlon64 4800+ X2 with every BIOS up to 1008-01.  Running with notsc is 
the only way to get it to work.

As an aside BIOS version 1008-003 is available for this board however 
this one seems to be WAY worse as the board won't even boot.  It gets 
panics before the boot messages unless you boot with noapic and after 
that it gets checksum errors on the RSDP.  I'm afraid to see what the 
next official BIOS version does. :/
    -Scott

Frank van Maarseveen wrote:

>On Sun, Sep 18, 2005 at 09:23:40PM -0700, Marc Perkel wrote:
>  
>
>>Got a dual core Athlon 64 X2 on an Asus board using NVidia chipset and 
>>getting lost ticks. The software clock of course is totally messed up. 
>>I've scanned google for a solution and see others complaining about bad 
>>code in the SMM BIOS. I have the latest bios and whatever they need to 
>>fix - isn't.
>>
>>So - what do I do to make it work?
>>    
>>
>
>See http://bugzilla.kernel.org/show_bug.cgi?id=5105
>
>On the kernel command-line:
>
>x86_64:	try "notsc"
>i386:	try "clock=pit"
>
>"nosmp" works but isn't fun.
>
>  
>
