Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266054AbTGRNcR (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Jul 2003 09:32:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265955AbTGRNbO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Jul 2003 09:31:14 -0400
Received: from [193.137.96.140] ([193.137.96.140]:28397 "EHLO dwarf.utad.pt")
	by vger.kernel.org with ESMTP id S265922AbTGRNbF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Jul 2003 09:31:05 -0400
X-Spam-Filter: check_local@dwarf.utad.pt by digitalanswers.org
X-Spam-Header: 550.Reject.Received:count_Received
Message-ID: <3F17EB7E.3000306@alvie.com>
Date: Fri, 18 Jul 2003 13:43:42 +0100
From: Alvaro Lopes <alvieboy@alvie.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3.1) Gecko/20030527 Debian/1.3.1-2
X-Accept-Language: en
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
CC: "Grover, Andrew" <andrew.grover@intel.com>,
       Ralf Hildebrandt <Ralf.Hildebrandt@charite.de>
Subject: Re: 2.6.0-test1-ac2 issues / Toshiba Laptop keyboard
References: <F760B14C9561B941B89469F59BA3A847E9704D@orsmsx401.jf.intel.com>
In-Reply-To: <F760B14C9561B941B89469F59BA3A847E9704D@orsmsx401.jf.intel.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Grover, Andrew wrote:

>>From: Alvaro Lopes [mailto:alvieboy@alvie.com] 
>>I have the same problem here with a toshiba satellite (with 
>>2.6.0-test1).  It boots ok, then when I reboot it stops 
>>before loading 
>>lilo (pure blank screen with only cursor on it). If I switch 
>>off/on it 
>>goes OK.
>>
>>This wasn't happening in 2.5.66. ACPI S3 suspend/resume is 
>>working fine 
>>though. Could this be related to ACPI in any way?
>>    
>>
>
>ACPI S3 works???
>
>The screen and all devices work after resume?
>
>-- Andy
>  
>
Yes it does ;))  I mentioned it already in acpi-devel mailing list.
Only have problems with the nvidia drivers - I cannot suspend while X is 
displaying, but if I switch to console and enter S3, all works ok:

Jul 15 15:12:54 supernova kernel: agpgart: Found an AGP 2.0 compliant 
device at 0000:00:00.0.
Jul 15 15:12:54 supernova kernel: agpgart: Putting AGP V2 device at 
0000:00:00.0 into 4x mode
Jul 15 15:12:54 supernova kernel: agpgart: Putting AGP V2 device at 
0000:01:00.0 into 4x mode
Jul 15 15:14:03 supernova kernel: Stopping tasks: XFree86 entered 
refrigerator
Jul 15 15:14:03 supernova kernel: =gkrellm entered refrigerator
--- snip ---
Jul 15 15:14:03 supernova kernel: =tee entered refrigerator
Jul 15 15:14:03 supernova kernel: =|
Jul 15 15:14:03 supernova kernel: Suspending devices
Jul 15 15:14:03 supernova kernel: Suspending devices
Jul 15 15:14:03 supernova kernel: hdc: start_power_step(step: 0)
Jul 15 15:14:03 supernova kernel: hdc: completing PM request, suspend
Jul 15 15:14:03 supernova kernel: hda: start_power_step(step: 0)
Jul 15 15:14:03 supernova kernel: hda: start_power_step(step: 1)
Jul 15 15:14:03 supernova kernel: hda: complete_power_step(step: 1, 
stat: 50, err: 0)
Jul 15 15:14:03 supernova kernel: hda: completing PM request, suspend
Jul 15 15:14:03 supernova kernel: Suspending devices
Jul 15 15:14:03 supernova kernel:  hwsleep-0257 [38] 
acpi_enter_sleep_state: Entering sleep state [S3]

Jul 15 15:14:03 supernova kernel: Back to C!
Jul 15 15:14:03 supernova kernel: Devices Resumed
Jul 15 15:14:03 supernova kernel: hda: Wakeup request inited, waiting 
for !BSY...
Jul 15 15:14:03 supernova kernel: hda: start_power_step(step: 1000)
Jul 15 15:14:03 supernova kernel: hda: completing PM request, resume
Jul 15 15:14:03 supernova kernel: hdc: Wakeup request inited, waiting 
for !BSY...
Jul 15 15:14:03 supernova kernel: hdc: start_power_step(step: 1000)
Jul 15 15:14:03 supernova kernel: hdc: completing PM request, resume
Jul 15 15:14:03 supernova kernel: Devices Resumed
Jul 15 15:14:03 supernova kernel: Restarting tasks...XFree86 left 
refrigerator
--- snip ---

And it all goes smooth :)

Álvaro

