Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281890AbSAARRN>; Tue, 1 Jan 2002 12:17:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281773AbSAARRB>; Tue, 1 Jan 2002 12:17:01 -0500
Received: from smtp02.web.de ([217.72.192.151]:6175 "EHLO smtp.web.de")
	by vger.kernel.org with ESMTP id <S280002AbSAARQs>;
	Tue, 1 Jan 2002 12:16:48 -0500
Message-ID: <3C31FCD4.8010904@web.de>
Date: Tue, 01 Jan 2002 18:15:48 +0000
From: Todor Todorov <ttodorov@web.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.7+) Gecko/20011230
X-Accept-Language: en-us
MIME-Version: 1.0
To: Robert Cope <robert@gonkgonk.com>
CC: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: APIC on laptop hangs the system @ powerstate change
In-Reply-To: <3C314F1A.2080002@web.de> <20020101060356.A11639@slave1.gonkgonk.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Robert Cope wrote:

>FWIW, I have the same APIC problem with my 8100.  To make things even
>more fun, if you have the GeForce2 video, APM support won't work -- the
>GeForce2 drivers from nVidia block all APM events.  The commends in
>their code imply that ACPI is the only system they support.  Hrm, the
>reason escapes me now, but ACPI was not much of an option for me,
>either.  Oh, right, I think with ACPI enabled my PCMCIA cards were not
>discovered.  Sigh
>
Hey Robert,

AFAIK, even in the newest release the nvidia closed driver doesn't 
support PM events - ACPI included, but eventually they will. Now for 
your cpmcia cards: You need the lates acpi patch form the intel's 
developers site - don't remember the www address though so you might 
want to go to acpi4linux.org and see it there. With it, the pcmcia 
discovery and irq assignment work properly, you have to compile pcmcia 
allways as modules though (I remember a message on their mailing lists 
stating that it wouldn't work if compiled if pcmcia stuf is compiled 
into the kernel). From the ACPI options xou have to check everything 
with <y> (nothing as module). The patch is called acpi-20011205.diff.gz 
and is made for the vanilla 2.4.16 source, but it applies cleanly to 
2.4.17 too. I use it now with 2.5.2-pre3 thoug I had problems with one 
file when applying - had to manually c'n'p a few lines of code. But it's 
easy and it works.
That's the onyl chance to make acpi work with a newer kernel and pcmcia 
- even on my *older* Inspiron 8000. And you will need the latest acpid 
daemon too.
What you will get is proper ACPI events and status reading for battery 
and ac power and stuff, and you can define/customize the actions which 
acpid will attend on any event you want. So you might want to give it a 
try.... The only thing is..... I still don't know how far the most 
drivers are in converting from APM to ACPI management scheme....

Regards,
Todor

