Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285166AbRLMUuO>; Thu, 13 Dec 2001 15:50:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285178AbRLMUuH>; Thu, 13 Dec 2001 15:50:07 -0500
Received: from hermes.domdv.de ([193.102.202.1]:11013 "EHLO zeus.domdv.de")
	by vger.kernel.org with ESMTP id <S285166AbRLMUtt>;
	Thu, 13 Dec 2001 15:49:49 -0500
Message-ID: <XFMail.20011213213815.ast@domdv.de>
X-Mailer: XFMail 1.5.1 on Linux
X-Priority: 3 (Normal)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
In-Reply-To: <1008267923.2263.3.camel@localhost.localdomain>
Date: Thu, 13 Dec 2001 21:38:15 +0100 (CET)
Organization: D.O.M. Datenverarbeitung GmbH
From: Andreas Steinmetz <ast@domdv.de>
To: Borsenkow Andrej <Andrej.Borsenkow@mow.siemens.ru>
Subject: RE: APM idle problems - how to check if BIOS halts CPU?
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 13-Dec-2001 Borsenkow Andrej wrote:
> Oh, my! I am ashamed. I totally missed the fact that default idle task
> alredy halts CPU. I must be getting old :(
> 
> 
> On Чтв, 2001-12-13 at 14:39, Andreas Steinmetz wrote:
>> I posted an apm patch and asked Marcelo to apply it. What you do see is
>> kapm-idled and the idle task both racing for idle time. There's even more
>> problems (search lkml for subject kapm-idled and have a look at the reply
>> from
>> Alan Cox on Dec 5 which does contain my original mail and the patch). With
>> the
>> patch e.g. the fan control of my laptop works properly which it never did
>> before.
> 
> 
> Unfortunately, this patch does not works as I'd expected. This patch
> does hide systime, but it does not cool CPU. With this patch system runs
> 4C hotter than it run when I replaced apm_do_idle() with apm_cpu_idle()
> in original apm.c
> 

In this case you may try to disable idle calls when idle in the kernel
configuration. This defaults then to the idle task which does halt the
cpu and should be a nice workaround for a buggy bios.

> I'll try to get a closer look at weekend; any hints how to debug it are
> welcome.
> 
>  If you really do have a broken bios there's no other way than to
>> contact your system's vendor.
>> 
> 
> Well, my vendor is ASUS and it is notorious for never answering bug
> reports from mere mortals. I also do not know how important Linux market
> is for them and Windows runs fine with ACPI (and Linux with ACPI does
> not have this problem as well. But I run Mandrake and they currently do
> not want to enable ACPI for different reasons). But I'll try anyway.
> 
> Thank you 
> 
> -andrej
> 

Andreas Steinmetz
D.O.M. Datenverarbeitung GmbH
