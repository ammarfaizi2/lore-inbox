Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261245AbTEKKju (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 May 2003 06:39:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261218AbTEKKjc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 May 2003 06:39:32 -0400
Received: from MailBox.iNES.RO ([80.86.96.21]:18329 "EHLO MailBox.iNES.RO")
	by vger.kernel.org with ESMTP id S261245AbTEKKig (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 May 2003 06:38:36 -0400
Subject: Re: 2.5.69 strange high tone on DELL Inspiron 8100
From: Dumitru Ciobarcianu <Dumitru.Ciobarcianu@iNES.RO>
To: Tuncer M zayamut Ayaz <tuncer.ayaz@gmx.de>
Cc: xavier.bestel@free.fr, linux-kernel@vger.kernel.org
In-Reply-To: <S264505AbTEJVD1/20030510210327Z+7123@vger.kernel.org>
References: <1405.1052575075@www9.gmx.net>
	 <1052575167.16165.0.camel@dhcp22.swansea.linux.org.uk>
	 <S264332AbTEJO5e/20030510145734Z+7011@vger.kernel.org>
	 <S264373AbTEJPSN/20030510151813Z+1648@vger.kernel.org>
	 <20030510162527.GD29271@mail.jlokier.co.uk>
	 <S264444AbTEJQk4/20030510164056Z+1652@vger.kernel.org>
	 <S264449AbTEJRZH/20030510172507Z+7050@vger.kernel.org>
	 <1052588866.1013.3.camel@bip.localdomain.fake>
	 <S264488AbTEJT4X/20030510195623Z+7092@vger.kernel.org>
	 <S264494AbTEJUMq/20030510201246Z+7104@vger.kernel.org>
	 <S264505AbTEJVD1/20030510210327Z+7123@vger.kernel.org>
Content-Type: text/plain
Organization: iNES Group SRL
Message-Id: <1052650249.6431.5.camel@LNX.iNES.RO>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.3.3 (1.3.3-2) (Preview Release)
Date: 11 May 2003 13:50:50 +0300
Content-Transfer-Encoding: 7bit
X-RAVMilter-Version: 8.4.1(snapshot 20020919) (MailBox.iNES.RO)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2003-05-11 at 00:13, Tuncer M zayamut Ayaz wrote:

> well, I actually saw PCMCIA functioning properly after
> make clean'ing, recompiling and rebooting.
> so no worries about that. now, off to find a replacement
> for "APM idle calls".

You can try cpufreqd (to set the cpu according to the usage).
http://sourceforge.net/projects/cpufreqd

I also use acpi performance states...

For instance on my laptop (Toshiba Satellite Pro 6100 , 2Ghz)
I have this on /proc/acpi/processor/CPU0/performance :

[cioby@LNX cioby]$ cat /proc/acpi/processor/CPU0/performance
state count:             2
active state:            P0
states:
   *P0:                  2000 MHz, 22000 mW, 250 uS
    P1:                  1200 MHz, 9800 mW, 250 uS

I often switch to performance state 1 even in if not running on battery.
If I keep it in my lap, and do an kernel compile, I don't want my balls
to get fryed :)

-- 
Cioby

