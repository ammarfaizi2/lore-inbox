Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275261AbRIZPcb>; Wed, 26 Sep 2001 11:32:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275262AbRIZPcV>; Wed, 26 Sep 2001 11:32:21 -0400
Received: from hermes.csd.unb.ca ([131.202.3.20]:23441 "EHLO hermes.csd.unb.ca")
	by vger.kernel.org with ESMTP id <S275261AbRIZPcA>;
	Wed, 26 Sep 2001 11:32:00 -0400
X-WebMail-UserID: newton
Date: Wed, 26 Sep 2001 12:41:53 -0300
From: Chris Newton <newton@unb.ca>
To: Tim Moore <timothymoore@bigfoot.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
X-EXP32-SerialNo: 00003025, 00003442
Subject: RE: FWD: RE: excessive interrupts on network cards
Message-ID: <3BB21EAF@webmail1>
Mime-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Mailer: WebMail (Hydra) SMTP v3.61.08
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Tim sent me this... and, yes, the count is much lower...  looking around, I 
found 'mpstat', which returns processor statistics.

  From this output, I would say that procinfo has a bug in the -d and -D 
options, or in the man page.

  Thanks, for all the help guys, but this seems to be right, according to 
mpstat anyways.

  Thanks a BUNCH.

Chris

[root@phantom /root]# mpstat 1
Linux 2.4.10 (phantom.csd.unb.ca)       09/26/2001

12:29:48 PM  CPU   %user   %nice %system   %idle    intr/s
12:29:49 PM  all    3.00    0.00    9.50   87.50   5711.00
12:29:50 PM  all    5.50    0.00    8.00   86.50   6139.00
12:29:51 PM  all    2.00    0.00   11.00   87.00   5976.00
12:29:52 PM  all    3.50    0.00   10.00   86.50   5744.00
12:29:53 PM  all    5.50    0.00    9.00   85.50   5986.00
12:29:54 PM  all    7.00    0.00   10.00   83.00   5904.00
12:29:55 PM  all    5.00    0.00    6.50   88.50   5771.00



>===== Original Message From Tim Moore <timothymoore@bigfoot.com> =====
>Just for grins what does 'procinfo -DSn2' say?
>
>Chris Newton wrote:
>> ...
>> uptime:       0:07:54.17         context :    43253
>>
>> irq  0:       500 timer                 irq 16:       131 eth2
>> irq  1:         0 keyboard              irq 20:     22266 eth0
>> irq  2:         0 cascade [4]           irq 21:         0 eth1
>> irq  6:         0                       irq 30:         0 aic7xxx
>> irq 12:         0                       irq 31:       121 aic7xxx
>> irq 14:         0 ide0
>--

