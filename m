Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262273AbVAUGPW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262273AbVAUGPW (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Jan 2005 01:15:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262274AbVAUGPW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Jan 2005 01:15:22 -0500
Received: from chewbacca.hagos.de ([213.217.124.234]:17360 "EHLO mail.hagos.de")
	by vger.kernel.org with ESMTP id S262273AbVAUGPF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Jan 2005 01:15:05 -0500
From: Klaus Muth <muth@hagos.de>
Organization: HAGOS eG
To: linux-kernel@vger.kernel.org
Subject: kernel panic with 2.4.26
Date: Fri, 21 Jan 2005 07:15:03 +0100
User-Agent: KMail/1.5.4
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200501210715.03716.muth@hagos.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.
Every now and then (maybe twice a week) my server panics. This
is a dual Xeon system with 5Gb memory. I did my best to get the
full oops from the screen and doublechecked. Sorry, but I don't
understand anything from the ksymoops output.
Any help will be appreciated.

ksymoops 2.4.5 on i686 2.4.26-msi1.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.26-msi1/ (default)
     -m System.map-2.4.26-msi1.nogood (specified)

f893281d
*pde = 00000000
Oops: 0002
CPU:    0
EIP:    0010:[<f893281d>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010256
eax: fffc43fc   ebx: 00000002   ecx: f703b000   edx: 0000000d
esi: f187d000   edi: 00000000   ebp: f7005c1c   esp: c0353ed4
ds: 0018   es: 0018   ss: 0018
Process swapper (pid: 0, stackpage=c0353000)
Stack: 00000000 f7040d00 00000000 f778a480 00000040 f7005c00 00000000 f703b000
       00040d00 f7007e80 f8921982 f7040d00 f7030b08 f778a480 00000002 00000000
       00000000 00000000 f703b200 00000000 f8921a9c f778a480 f7040d08 f77dc680
Call Trace:    [<f8921982>] [<f8921a9c>] [<c010a041>] [<c010a236>] [<c0106d60>]
  [<c0106d60>] [<c0106d60>] [<c0106d60>] [<c0106d89>] [<c0106df2>] [<c0105000>]
  [<c010504f>]
Code: 88 08 8b 86 58 01 00 00 ff 86 5c 01 00 00 88 10 ff 86 58 01


>>EIP; f893281d <_end+3851dc61/385fa444>   <=====

>>eax; fffc43fc <END_OF_CODE+74ee74d/????>
>>ecx; f703b000 <_end+36c26444/385fa444>
>>esi; f187d000 <_end+31468444/385fa444>
>>ebp; f7005c1c <_end+36bf1060/385fa444>
>>esp; c0353ed4 <init_task_union+1ed4/2000>

Trace; f8921982 <_end+3850cdc6/385fa444>
Trace; f8921a9c <_end+3850cee0/385fa444>
Trace; c010a041 <handle_IRQ_event+5d/88>
Trace; c010a236 <do_IRQ+a6/ec>
Trace; c0106d60 <default_idle+0/34>
Trace; c0106d60 <default_idle+0/34>
Trace; c0106d60 <default_idle+0/34>
Trace; c0106d60 <default_idle+0/34>
Trace; c0106d89 <default_idle+29/34>
Trace; c0106df2 <cpu_idle+3e/54>
Trace; c0105000 <_stext+0/0>
Trace; c010504f <rest_init+4f/50>

Code;  f893281d <_end+3851dc61/385fa444>
00000000 <_EIP>:
Code;  f893281d <_end+3851dc61/385fa444>   <=====
   0:   88 08                     mov    %cl,(%eax)   <=====
Code;  f893281f <_end+3851dc63/385fa444>
   2:   8b 86 58 01 00 00         mov    0x158(%esi),%eax
Code;  f8932825 <_end+3851dc69/385fa444>
   8:   ff 86 5c 01 00 00         incl   0x15c(%esi)
Code;  f893282b <_end+3851dc6f/385fa444>
   e:   88 10                     mov    %dl,(%eax)
Code;  f893282d <_end+3851dc71/385fa444>
  10:   ff 86 58 01 00 00         incl   0x158(%esi)

 <0>Kernel panic: Aiee, killing interrupt handler!

Could you please help me out?

klaus

