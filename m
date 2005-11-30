Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751141AbVK3I4Z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751141AbVK3I4Z (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Nov 2005 03:56:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751149AbVK3I4Z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Nov 2005 03:56:25 -0500
Received: from embla.aitel.hist.no ([158.38.50.22]:53697 "HELO
	embla.aitel.hist.no") by vger.kernel.org with SMTP id S1751141AbVK3I4Z
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Nov 2005 03:56:25 -0500
Message-ID: <438D69FF.2090002@aitel.hist.no>
Date: Wed, 30 Nov 2005 09:59:43 +0100
From: Helge Hafting <helge.hafting@aitel.hist.no>
User-Agent: Debian Thunderbird 1.0.7 (X11/20051017)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@osdl.org>
CC: Helge Hafting <helgehaf@aitel.hist.no>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Tejun Heo <htejun@gmail.com>, Jeff Garzik <jgarzik@pobox.com>
Subject: Re: Linux 2.6.15-rc3
References: <Pine.LNX.4.64.0511282006370.3177@g5.osdl.org> <20051129213656.GA8706@aitel.hist.no> <Pine.LNX.4.64.0511291340340.3029@g5.osdl.org>
In-Reply-To: <Pine.LNX.4.64.0511291340340.3029@g5.osdl.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:

>On Tue, 29 Nov 2005, Helge Hafting wrote:
>  
>
>>Can't open root dev "831" or unknown block(8,49)
>>Please append a correct root= boot option
>>unable to mount root fs from block(8,49)
>>    
>>
>
>Sounds like your SATA drive wasn't detected.
>
>Please double-check that your config changes didn't disable it, but 
>otherwise:
>
>  
>
>>Now 2.6.14 works with exactly the same lilo.con,
>>where I have root=/dev/sdd1  (SATA drive)
>>    
>>
>
>please specify _which_ SATA driver you are using so that Jeff & co can try 
>to figure out what broke since 2.6.14.
>
>  
>
lspci says:
0000:00:0f.0 RAID bus controller: VIA Technologies, Inc. VIA VT6420 SATA 
RAID Controller (rev 80)

My .config has "VIA SATA support" selected under "SCSI low-level drivers"

>Also, if you can pinpoint where it broke better, that probably helps 
>(most sata changes were in -rc1, but there were some sata_mv and sata_sil4 
>changes in in -rc2 too, so even just poinpointing it to either of those 
>will help, although the daily builds might be even better).
>  
>
I tried compiling and booting rc1.  The machine is remote, and did not
come up.  So I don't know why it didn't come up, but it is likely
that it is the same problem.

Helge Hafting



