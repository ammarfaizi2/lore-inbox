Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129285AbRBGAAF>; Tue, 6 Feb 2001 19:00:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129686AbRBFX7t>; Tue, 6 Feb 2001 18:59:49 -0500
Received: from jalon.able.es ([212.97.163.2]:15017 "EHLO jalon.able.es")
	by vger.kernel.org with ESMTP id <S129285AbRBFX72>;
	Tue, 6 Feb 2001 18:59:28 -0500
Date: Wed, 7 Feb 2001 00:59:20 +0100
From: "J . A . Magallon" <jamagallon@able.es>
To: Juraj Bednar <juraj@bednar.sk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: smp_num_cpus redefined? (compiling 2.2.18 for non-SMP?)
Message-ID: <20010207005920.C949@werewolf.able.es>
In-Reply-To: <20010207005203.A19812@rak.isternet.sk>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
In-Reply-To: <20010207005203.A19812@rak.isternet.sk>; from juraj@bednar.sk on Wed, Feb 07, 2001 at 00:52:04 +0100
X-Mailer: Balsa 1.1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 02.07 Juraj Bednar wrote:
> Hello,
> 
> 
>   the same for vanilla 2.4.1 and 2.4.1ac3. Everything works ok until I turn
> off SMP
> support (which is required to make it possible to turn off the machine using
> APM, since
> ACPI is completely broken in 2.4.1 for me).
> 

You do not need to do that. Enable both SMP and APM (just APM support, no
ACPI nor any other apm option). And add to your lilo.conf file a line:
append="apm=power-off".

At boot you will see a log message like:

apm: BIOS version 1.2 Flags 0x03 (Driver version 1.14)
apm: disabled - APM is not SMP safe (power off active).

So kernel diables APM but lets the power-off feature active.

-- 
J.A. Magallon                                                      $> cd pub
mailto:jamagallon@able.es                                          $> more beer

Linux werewolf 2.4.1-ac4 #1 SMP Tue Feb 6 22:06:38 CET 2001 i686

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
