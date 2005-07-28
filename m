Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261353AbVG1KyU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261353AbVG1KyU (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Jul 2005 06:54:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261372AbVG1KyU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Jul 2005 06:54:20 -0400
Received: from pilet.ens-lyon.fr ([140.77.167.16]:3040 "EHLO
	relaissmtp.ens-lyon.fr") by vger.kernel.org with ESMTP
	id S261353AbVG1KyT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Jul 2005 06:54:19 -0400
Message-ID: <42E8AB44.1000007@ens-lyon.fr>
Date: Thu, 28 Jul 2005 11:54:12 +0200
From: Alexandre Buisse <alexandre.buisse@ens-lyon.fr>
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050623)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Sebastian Kaergel <kaese@pei.de>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.13-rc3-mm3
References: <s2e8d238.046@SV-CL-03.pei.de>
In-Reply-To: <s2e8d238.046@SV-CL-03.pei.de>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sebastian Kaergel wrote:

>  CC      arch/i386/kernel/cpu/mtrr/main.o
>arch/i386/kernel/cpu/mtrr/main.c: In Funktion »set_mtrr«:
>arch/i386/kernel/cpu/mtrr/main.c:225: error: `ipi_handler' undeclared (first use in this function)
>arch/i386/kernel/cpu/mtrr/main.c:225: error: (Each undeclared identifier is reported only once
>arch/i386/kernel/cpu/mtrr/main.c:225: error: for each function it appears in.)
>make[3]: *** [arch/i386/kernel/cpu/mtrr/main.o] Fehler 1
>make[2]: *** [arch/i386/kernel/cpu/mtrr] Fehler 2
>make[1]: *** [arch/i386/kernel/cpu] Fehler 2
>make: *** [arch/i386/kernel] Fehler 2
>
>I'm in a hurry, so I got no time to see what's causing this. Config is attached.
>  
>
I have the same error here (MTRR enabled and no SMP).
I solved it by adding #ifdef CONFIG_SMP around lines 224 to 226 in this
file, but I am not sure it is totally safe.
I don't see why smp specific operations are not protected this way in
this file.

Regards,
Alexandre
