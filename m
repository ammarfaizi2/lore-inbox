Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264935AbTLFCtf (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Dec 2003 21:49:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264938AbTLFCtf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Dec 2003 21:49:35 -0500
Received: from mail-01.iinet.net.au ([203.59.3.33]:5254 "HELO
	mail.iinet.net.au") by vger.kernel.org with SMTP id S264935AbTLFCtc
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Dec 2003 21:49:32 -0500
Message-ID: <3FD14396.5070205@cyberone.com.au>
Date: Sat, 06 Dec 2003 13:48:54 +1100
From: Nick Piggin <piggin@cyberone.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030827 Debian/1.4-3
X-Accept-Language: en
MIME-Version: 1.0
To: William Lee Irwin III <wli@holomorphy.com>
CC: Colin Coe <colin@coesta.com>, linux-kernel@vger.kernel.org
Subject: Re: SMP broken on Dell PowerEdge 4100/200 under 2.6.0-testxx?
References: <3350.192.168.1.3.1070677965.squirrel@www.coesta.com> <20031206024251.GG8039@holomorphy.com>
In-Reply-To: <20031206024251.GG8039@holomorphy.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



William Lee Irwin III wrote:

>On Sat, Dec 06, 2003 at 10:32:45AM +0800, Colin Coe wrote:
>
>>This indicates to me that the processing load is being evenly distributed
>>accross the two processes.  Under v2.6.0-testxx however, 'cat
>>/proc/interrupts' shows this:
>>[root@host root]# cat /proc/interrupts
>>           CPU0       CPU1
>>  0:     633122         30    IO-APIC-edge  timer
>>  1:        207              IO-APIC-edge  i8042
>>  2:                              XT-PIC  cascade
>>  4:         48          1    IO-APIC-edge  serial
>>  5:        449          1   IO-APIC-level  eth1
>> 10:        135          1   IO-APIC-level  aic7xxx
>> 11:       1447          1   IO-APIC-level  eth0
>> 12:         61              IO-APIC-edge  i8042
>> 14:                       IO-APIC-level  CS46XX
>> 15:      14982          1   IO-APIC-level  megaraid
>>
>
>2.6 does balancing across packages, not logical cpus, so this will
>happen and it will be largely harmless, except for what appears to
>be some kind of bug where it's stealing the timer from logical cpu 1.
>
>

Although in this case Colin has 2 PPro 200s.

Colin - process load should be evenly distributed between CPUs, and this
is generally the most important thing. Big networking loads (most commonly)
can put a lot of time into processing interrupts though.


