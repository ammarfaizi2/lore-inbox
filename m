Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264119AbUEHTas@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264119AbUEHTas (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 8 May 2004 15:30:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264117AbUEHTas
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 8 May 2004 15:30:48 -0400
Received: from smtp-roam.Stanford.EDU ([171.64.10.152]:920 "EHLO
	smtp-roam.Stanford.EDU") by vger.kernel.org with ESMTP
	id S264103AbUEHTaP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 8 May 2004 15:30:15 -0400
Message-ID: <409D3507.2030203@myrealbox.com>
Date: Sat, 08 May 2004 12:29:11 -0700
From: Andy Lutomirski <luto@myrealbox.com>
User-Agent: Mozilla Thunderbird 0.6 (Windows/20040502)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "R. J. Wysocki" <rjwysocki@sisk.pl>
CC: Andrew Morton <akpm@osdl.org>, rusty@rustcorp.com.au, ak@muc.de,
       linux-kernel@vger.kernel.org
Subject: Re: 2.6.6-rc3-mm2
References: <fa.gcf87gs.1sjkoj6@ifi.uio.no> <fa.freqmjk.11j6bhe@ifi.uio.no>
In-Reply-To: <fa.freqmjk.11j6bhe@ifi.uio.no>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

R. J. Wysocki wrote:
> On Saturday 08 of May 2004 13:31, Andrew Morton wrote:
> 
>>"R. J. Wysocki" <rjwysocki@sisk.pl> wrote:
>>
>>>Sute, it's like that:
>>>
>>> kernel /boot/vmlinuz-2.6.6-rc3-mm2 root=/dev/sdb3 vga=792 hdc=ide-scsi
>>> console=ttyS0,115200 console=tty0
>>
>>Please try `console=ttyS0'.
> 
> 
> I have.  It does not help. :-(
> 
> Still, reversing the Move-saved_command_line-to-init-mainc.patch _does_ help, 
> even with the above command line.  I guess it's an x86_64-specific issue.

I had the same problem (serial console was broken on -mm on x86_64).  I 
switched to i386, did 'make oldconfig', and rebuild, and it worked.  I 
think this was 2.6.5-mm1.

Sorry I can't test it now -- I plan on sticking with 32 bit for a while 
longer.

--Andy
