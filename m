Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284603AbRLMSbk>; Thu, 13 Dec 2001 13:31:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284569AbRLMSba>; Thu, 13 Dec 2001 13:31:30 -0500
Received: from goliath.siemens.de ([194.138.37.131]:46279 "EHLO
	goliath.siemens.de") by vger.kernel.org with ESMTP
	id <S284557AbRLMSbX> convert rfc822-to-8bit; Thu, 13 Dec 2001 13:31:23 -0500
From: Borsenkow Andrej <Andrej.Borsenkow@mow.siemens.ru>
To: Andreas Steinmetz <ast@domdv.de>
Cc: linux-kernel@vger.kernel.org
Subject: RE: APM idle problems - how to check if BIOS halts CPU?
In-Reply-To: <XFMail.20011213123949.ast@domdv.de>
In-Reply-To: <XFMail.20011213123949.ast@domdv.de>
Content-Type: text/plain; charset=KOI8-R
Content-Transfer-Encoding: 8BIT
Message-Id: <1008267923.2263.3.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution/1.0 (Preview Release)
Date: 13 Dec 2001 21:31:09 +0300
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Oh, my! I am ashamed. I totally missed the fact that default idle task
alredy halts CPU. I must be getting old :(


On Чтв, 2001-12-13 at 14:39, Andreas Steinmetz wrote:
> I posted an apm patch and asked Marcelo to apply it. What you do see is
> kapm-idled and the idle task both racing for idle time. There's even more
> problems (search lkml for subject kapm-idled and have a look at the reply from
> Alan Cox on Dec 5 which does contain my original mail and the patch). With the
> patch e.g. the fan control of my laptop works properly which it never did
> before.


Unfortunately, this patch does not works as I'd expected. This patch
does hide systime, but it does not cool CPU. With this patch system runs
4C hotter than it run when I replaced apm_do_idle() with apm_cpu_idle()
in original apm.c

I'll try to get a closer look at weekend; any hints how to debug it are
welcome.

 If you really do have a broken bios there's no other way than to
> contact your system's vendor.
> 

Well, my vendor is ASUS and it is notorious for never answering bug
reports from mere mortals. I also do not know how important Linux market
is for them and Windows runs fine with ACPI (and Linux with ACPI does
not have this problem as well. But I run Mandrake and they currently do
not want to enable ACPI for different reasons). But I'll try anyway.

Thank you 

-andrej
