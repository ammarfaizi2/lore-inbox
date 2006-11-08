Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030205AbWKHP4J@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030205AbWKHP4J (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Nov 2006 10:56:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030210AbWKHP4J
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Nov 2006 10:56:09 -0500
Received: from smtpout07-01.prod.mesa1.secureserver.net ([64.202.165.230]:64467
	"HELO smtpout07-04.prod.mesa1.secureserver.net") by vger.kernel.org
	with SMTP id S1030205AbWKHP4G (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Nov 2006 10:56:06 -0500
Message-ID: <4551FE14.7010801@seclark.us>
Date: Wed, 08 Nov 2006 10:56:04 -0500
From: Stephen Clark <Stephen.Clark@seclark.us>
Reply-To: Stephen.Clark@seclark.us
User-Agent: Mozilla/5.0 (X11; U; Linux 2.2.16-22smp i686; en-US; m18) Gecko/20010110 Netscape6/6.5
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Luming Yu <luming.yu@gmail.com>
CC: linux-kernel <linux-kernel@vger.kernel.org>, Dave Jones <davej@redhat.com>
Subject: Re: New laptop - problems with linux
References: <4551EC86.5010600@seclark.us> <3877989d0611080704j30b88bd4o4558e606fd6ffc11@mail.gmail.com>
In-Reply-To: <3877989d0611080704j30b88bd4o4558e606fd6ffc11@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Luming Yu wrote:

>On 11/8/06, Stephen Clark <Stephen.Clark@seclark.us> wrote:
>  
>
>>Hi list,
>>
>>I just purchased a VBI-Asus S96F laptop Intel 945GM &  ICH7, with a Core
>>2 Duo T560,0 2gb pc5400 memory.
>> From checking around it appeared all the
>>hardware was well supported by linux - but I am having major problems.
>>
>>
>>1. neither the wireless lan Intel pro 3945ABG or built in ethernet
>>RTL-8169C are detected and configured
>>2. the disk which is a 7200rpm Hitachi travelmate transfers data at 1.xx
>>mb/sec
>>   according to hdparm. This same drive in my old laptop an HP n5430 with a
>>   850 duron the rate was 12-14 mb/sec.
>>
>>Attached are the output of lspci -vvv, dmesg and hdparm
>>Any insight would be greatly appreciated.
>>
>>    
>>
>
>Sounds like interrupt problem. Could you post /proc/interrupts?
>It is worthy to try pci=noacpi.
>
>  
>

           CPU0       CPU1
  0:     902788     893290    IO-APIC-edge  timer
  1:       1444       1393    IO-APIC-edge  i8042
  8:          1          0    IO-APIC-edge  rtc
  9:      16443      16618   IO-APIC-level  acpi
 12:      13089      14223    IO-APIC-edge  i8042
 14:          0          0    IO-APIC-edge  libata
 15:     223418     202091    IO-APIC-edge  ide1
169:     129430     129240   IO-APIC-level  uhci_hcd:usb4, ohci1394, HDA 
Intel, i915@pci:0000:00:02.0
177:          0          0   IO-APIC-level  sdhci:slot0
185:          0          0   IO-APIC-level  uhci_hcd:usb3
225:        527        660   IO-APIC-level  uhci_hcd:usb1, ehci_hcd:usb5
233:        629        145   IO-APIC-level  uhci_hcd:usb2
NMI:          0          0
LOC:    1793413    1794404
ERR:          0
MIS:          0

tried pci=noacpi
only minor difference in interrupt assignments.

Steve

-- 

"They that give up essential liberty to obtain temporary safety, 
deserve neither liberty nor safety."  (Ben Franklin)

"The course of history shows that as a government grows, liberty 
decreases."  (Thomas Jefferson)



