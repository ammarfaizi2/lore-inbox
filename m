Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265254AbTLFWVm (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 6 Dec 2003 17:21:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265255AbTLFWVl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 6 Dec 2003 17:21:41 -0500
Received: from mx2.it.wmich.edu ([141.218.1.94]:5055 "EHLO mx2.it.wmich.edu")
	by vger.kernel.org with ESMTP id S265254AbTLFWVf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 6 Dec 2003 17:21:35 -0500
Message-ID: <3FD2566D.9020305@wmich.edu>
Date: Sat, 06 Dec 2003 17:21:33 -0500
From: Ed Sweetman <ed.sweetman@wmich.edu>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5) Gecko/20031107 Debian/1.5-3
X-Accept-Language: en
MIME-Version: 1.0
To: Zwane Mwaikambo <zwane@arm.linux.org.uk>
CC: Dmitry Torokhov <dtor_core@ameritech.net>,
       Markku Savela <msa@burp.tkv.asdf.org>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.0-test11, TSC cannot be used as a timesource.
References: <200312061603.hB6G3CrG012634@burp.tkv.asdf.org> <Pine.LNX.4.58.0312061253010.10548@montezuma.fsmlabs.com> <200312062056.hB6Kuh0D001004@burp.tkv.asdf.org> <200312061652.59880.dtor_core@ameritech.net> <Pine.LNX.4.58.0312061701260.1758@montezuma.fsmlabs.com>
In-Reply-To: <Pine.LNX.4.58.0312061701260.1758@montezuma.fsmlabs.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Zwane Mwaikambo wrote:
> On Sat, 6 Dec 2003, Dmitry Torokhov wrote:
> 
> 
>>On Saturday 06 December 2003 03:56 pm, Markku Savela wrote:
>>
>>>>From: Zwane Mwaikambo <zwane@arm.linux.org.uk>
>>>>
>>>>On Sat, 6 Dec 2003, Markku Savela wrote:
>>>>
>>>>>I've seen some references to above problem, but no clear answer.
>>>>>The 'ntpd' is complaining a lot...
>>>>>
>>>>>I have ASUS P4S800. Here is some extracts from dmesg (I can provide
>>>>>more complete dump, if anyone wants something specific.)
>>>>
>>>>Does this only happen when running X11?
>>>
>>>Hmm.. possibly. When I boot single user, it does not appear to happen.
>>>
>>
>>Do you have an ACPI battery stat or thermal monitor apps running (I see
>>that you have ACPI active). Does it help it you increase the polling
>>interval? Too many systems spend too much time in SCI handler...
> 
> 
> Yes cat /proc/interrupts might also give some sort of rough indication.


It took over 3 days to trigger it on my system, so booting to  single 
user mode and waiting 5 minutes is not a good marker of deciding if 
that's the case or not.  Also, i dont have SCSI compiled in my kernel at 
all yet this happens. So that idea is out.


Here is my /proc/interrupts
            CPU0
   0:  426319022          XT-PIC  timer
   1:     409358          XT-PIC  i8042
   2:          0          XT-PIC  cascade
   5:          0          XT-PIC  acpi
   8:  136058006          XT-PIC  rtc
  11:   23497500          XT-PIC  uhci_hcd, uhci_hcd, eth0, EMU10K1
  12:   25482865          XT-PIC  bttv0
  14:    1440279          XT-PIC  ide0
  15:     405600          XT-PIC  ide1
NMI:          0
LOC:  426178067
ERR:     554364
MIS:          0


