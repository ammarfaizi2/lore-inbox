Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272971AbTHKRqd (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Aug 2003 13:46:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272975AbTHKRqP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Aug 2003 13:46:15 -0400
Received: from 64-60-248-67.cust.telepacific.net ([64.60.248.67]:39629 "EHLO
	mx.rackable.com") by vger.kernel.org with ESMTP id S272971AbTHKRoi
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Aug 2003 13:44:38 -0400
Message-ID: <3F37D49B.6050409@rackable.com>
Date: Mon, 11 Aug 2003 10:38:35 -0700
From: Samuel Flory <sflory@rackable.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030529
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Brown, Len" <len.brown@intel.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: 2.4.22-pre10 ACPI kennel oops
References: <BF1FE1855350A0479097B3A0D2A80EE009FC12@hdsmsx402.hd.intel.com>
In-Reply-To: <BF1FE1855350A0479097B3A0D2A80EE009FC12@hdsmsx402.hd.intel.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 11 Aug 2003 17:44:34.0415 (UTC) FILETIME=[39FDFFF0:01C36030]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Brown, Len wrote:

>Was ACPI included in your 2.4.21 kernel?  If no, then 2.4.22-pre10 may
>be the 1st time that Linux ACPI has examined the tables on this system.
>
>I'm not familiar with "woodruf" -- do it have a part number?
>First thing to do is to locate the latest BIOS for the board, and see if
>this is something that has already been fixed there.
>
>If the latest BIOS doesn't do it, then filing a bug under componenet
>ACPI will be the best way to get it fixed w/o having it fall through the
>

  Still fails.  A bug with quad, or the ACPI project?

>cracks.
>
>Thanks,
>-Len
>
>
>
>  
>
>>-----Original Message-----
>>From: Samuel Flory [mailto:sflory@rackable.com] 
>>Sent: Tuesday, August 05, 2003 5:29 PM
>>To: linux-kernel@vger.kernel.org
>>Subject: 2.4.22-pre10 ACPI kennel oops
>>
>>
>>  I'm getting a kernel oops on the intel woodruf P4 motherboard under 
>>2.4.22pre10.  This config worked fine under 2.4.21.  The output of 
>>ksymoops is attached, and the raw oops is attached.
>>
>>ksymoops 2.4.4 on i686 2.4.20-8smp.  Options used
>>     -V (default)
>>     -K (specified)
>>     -L (specified)
>>     -O (specified)
>>     -m /boot/System.map-2.4.22-pre10 (specified)
>>
>>ACPI: LAPIC_NMI (acpi_id[0x01] polarity[0x0] trigger[0x0] lint[0x1])
>>ACPI: LAPIC_NMI (acpi_id[0x02] polarity[0x0] trigger[0x0] lint[0x1])
>>cpu: 0, clocks: 1328876, slice: 664438
>>Unable to handle kernel paging request at virtual address f8803000
>>c022d588
>>*pde = 00000000
>>Oops: 0000
>>CPU:    0
>>EIP:    0010:[<c022d588>]    Not tainted
>>Using defaults from ksymoops -t elf32-i386 -a i386
>>EFLAGS: 00010206
>>eax: 00000000   ebx: 00000000   ecx: 00000001   edx: c1c13ec0
>>esi: f8802ffd   edi: c1c13ee0   ebp: c1c13ec0   esp: c1c13e64
>>ds: 0018   es: 0018   ss: 0018
>>Process swapper (pid: 1, stackpage=c1c13000)
>>Stack: c1c13f1c c1c13f1c c1c13e84 c022d015 c1c13ec0 f8802fdd 00000024 
>>f8802fdd
>>       00000008 c0492d37 c0492d24 00200000 c1c13eb0 c1c13ec0 c1c13f2c 
>>c1c13eb0
>>       c022c984 c1c13f1c c1c13ec0 00000008 c0492cab c0492ca2 c1c13f0c 
>>54445353
>>Call Trace:    [<c022d015>] [<c022c984>] [<c022cb68>] [<c022cd89>] 
>>[<c022e124>]
>>  [<c022e1fa>] [<c0105000>] [<c010508b>] [<c0105000>] [<c01075ae>] 
>>[<c0105060>]
>>Code: f3 a5 e9 5c ff ff ff c1 e9 02 89 d7 f3 a5 a4 e9 4f ff ff ff
>>
>> >>EIP; c022d588 <__constant_memcpy+bd/f5>   <=====
>>Trace; c022d015 <acpi_tb_get_table_header+11a/12d>
>>Trace; c022c984 <acpi_tb_get_primary_table+64/d2>
>>Trace; c022cb68 <acpi_tb_get_required_tables+45/2b4>
>>Trace; c022cd89 <acpi_tb_get_required_tables+266/2b4>
>>Trace; c022e124 <acpi_load_tables+34/188>
>>Trace; c022e1fa <acpi_load_tables+10a/188>
>>Trace; c0105000 <_stext+0/0>
>>Trace; c010508b <init+2b/190>
>>Trace; c0105000 <_stext+0/0>
>>Trace; c01075ae <arch_kernel_thread+2e/40>
>>Trace; c0105060 <init+0/190>
>>Code;  c022d588 <__constant_memcpy+bd/f5>
>>00000000 <_EIP>:
>>Code;  c022d588 <__constant_memcpy+bd/f5>   <=====
>>   0:   f3 a5                     repz movsl 
>>%ds:(%esi),%es:(%edi)   <=====
>>Code;  c022d58a <__constant_memcpy+bf/f5>
>>   2:   e9 5c ff ff ff            jmp    ffffff63 <_EIP+0xffffff63>
>>Code;  c022d58f <__constant_memcpy+c4/f5>
>>   7:   c1 e9 02                  shr    $0x2,%ecx
>>Code;  c022d592 <__constant_memcpy+c7/f5>
>>   a:   89 d7                     mov    %edx,%edi
>>Code;  c022d594 <__constant_memcpy+c9/f5>
>>   c:   f3 a5                     repz movsl %ds:(%esi),%es:(%edi)
>>Code;  c022d596 <__constant_memcpy+cb/f5>
>>   e:   a4                        movsb  %ds:(%esi),%es:(%edi)
>>Code;  c022d597 <__constant_memcpy+cc/f5>
>>   f:   e9 4f ff ff ff            jmp    ffffff63 <_EIP+0xffffff63>
>>
>>
>>-- 
>>Once you have their hardware. Never give it back.
>>(The First Rule of Hardware Acquisition)
>>Sam Flory  <sflory@rackable.com>
>>
>>    
>>
>
>  
>


-- 
Once you have their hardware. Never give it back.
(The First Rule of Hardware Acquisition)
Sam Flory  <sflory@rackable.com>


