Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263936AbTKSQte (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Nov 2003 11:49:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263938AbTKSQte
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Nov 2003 11:49:34 -0500
Received: from spoetnik.kulnet.kuleuven.ac.be ([134.58.240.46]:48842 "EHLO
	spoetnik.kulnet.kuleuven.ac.be") by vger.kernel.org with ESMTP
	id S263936AbTKSQta (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Nov 2003 11:49:30 -0500
From: Frank Dekervel <kervel@drie.kotnet.org>
To: linux-kernel@vger.kernel.org
Subject: Re: 2.6.0-test9-mm4 (does not boot)
Date: Wed, 19 Nov 2003 17:49:28 +0100
User-Agent: KMail/1.5.93
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200311191749.28327.kervel@drie.kotnet.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hello,

2.6.0-test9-mm4 doesn't boot for me ... oops followed by 
kernel panic - attempted to kill init (2.6.0-test9 works fine). 
it crashes right after initialising PNP  bios. The (undecoded) oops doesn't 
seem to make a lot of  sense (i wrote the oops down and i typed it in), and 
ksymoops doesn't show a lot too. 

Someone has an idea what this could be, or a hint to improve oops 
output ? (i can reproduce it as much as i want to)

------------------- oops output
general protection fault: 0000 [#1]
PREEMPT SMP
CPU: 0
EIP: 0098:[<00002d6c>] Not tainted VLI
EFLAGS: 00010097
EIP is at 0x2d6c
eax: 00003410 ebx: 00000082  ecx: 00020000 edx: 00000002
esi: 00002630 edi: c1a4004d  ebp: c1a40000 esp: c1a47ee2
ds: 0060 es: 0060 ss:0068
Process swapper (PID:1 threadinfo=c1a46000 task=c1a5f980)
Stack: 00000410 341026de 00000000 836d004d 0004cfea 00020002 7f28830c cfeacff2
       64090909 01090109 007b6264 6000007b 00a00246 622000b0 00a861e6 00000086
       000b0000 00010090 00a80000 00b00000 00a00002 bee90000 0060c02b 00820000
Call Trace:

Code:
      bad EIP Value

------------------ ksymoops -V -K -L -o /lib/modules/2.6.0-test9-mm4/ -m /boot/System.map-2.6.0-test9-mm4 < /root/oops.txt

Warning (Oops_read): Code line not seen, dumping what data is available


>>EIP; 00002d6c Before first symbol   <=====

>>edi; c1a4004d <__crc_unregister_chrdev+112bbc/1668b5>
>>ebp; c1a40000 <__crc_unregister_chrdev+112b6f/1668b5>
>>esp; c1a47ee2 <__crc_unregister_chrdev+11aa51/1668b5>

----------------





op Wednesday 19 November 2003 07:52 , schreef Andrew Morton  in <20031118225120.1d213db2.akpm@osdl.org> :

> 
> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.0-test9/2.6.0-test9-mm4/
> 
> 
> . Several fixes against patches which are only in -mm at present.
> 
> . Minor fixes which we'll queue for post-2.6.0.
> 
> . The interactivity problems which the ACPI PM timer patch showed up
>   should be fixed here - please sing out if not.
-- 
Frank Dekervel - frank.dekervel@student.kuleuven.ac.be
Mechelsestraat 88
3000 Leuven (Belgium)
