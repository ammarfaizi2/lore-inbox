Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276387AbRI2Akm>; Fri, 28 Sep 2001 20:40:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276388AbRI2Akb>; Fri, 28 Sep 2001 20:40:31 -0400
Received: from jalon.able.es ([212.97.163.2]:57001 "EHLO jalon.able.es")
	by vger.kernel.org with ESMTP id <S276387AbRI2AkM>;
	Fri, 28 Sep 2001 20:40:12 -0400
Date: Sat, 29 Sep 2001 02:40:28 +0200
From: "J . A . Magallon" <jamagallon@able.es>
To: mingo@elte.hu
Cc: Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>,
        Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org,
        Alan Cox <alan@lxorguk.ukuu.org.uk>, bcrl@redhat.com,
        Andrea Arcangeli <andrea@suse.de>
Subject: Re: [patch] softirq-2.4.10-B3
Message-ID: <20010929024028.A2903@werewolf.able.es>
In-Reply-To: <200109281618.UAA04122@ms2.inr.ac.ru> <Pine.LNX.4.33.0109281833040.8840-200000@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
In-Reply-To: <Pine.LNX.4.33.0109281833040.8840-200000@localhost.localdomain>; from mingo@elte.hu on Fri, Sep 28, 2001 at 18:35:05 +0200
X-Mailer: Balsa 1.2.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 20010928 Ingo Molnar wrote:
>
>On Fri, 28 Sep 2001 kuznet@ms2.inr.ac.ru wrote:
>
>> >  - '[ksoftirqd_CPU0]' is confusing on UP systems, changed it to
>> >    '[ksoftirqd]' instead.
>>
>> It is useless to argue about preferences, but universal naming scheme
>> looks as less confusing yet. :-)
>
>since you are the second one to complain, i'm convinced :) reverted.
>
>i've also added back the BUG() check for smp_processor_id() == cpu.
>
>-B3 attached.
>

Beware: netconsole slipped into the patch, and makes 'make xconfig' fail:

...
./tkparse < ../arch/i386/config.in >> kconfig.tk
drivers/net/Config.in: 251: can't handle dep_bool/dep_mbool/dep_tristate condition
make[1]: *** [kconfig.tk] Error 1
make[1]: Leaving directory `/usr/src/linux-2.4.10-bw/scripts'
make: *** [xconfig] Error 2

-- 
J.A. Magallon                           #  Let the source be with you...        
mailto:jamagallon@able.es
Mandrake Linux release 8.2 (Cooker) for i586
Linux werewolf 2.4.10-bw #1 SMP Thu Sep 27 00:32:53 CEST 2001 i686
