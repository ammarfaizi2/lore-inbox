Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281817AbRLHPTw>; Sat, 8 Dec 2001 10:19:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281820AbRLHPTc>; Sat, 8 Dec 2001 10:19:32 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:46598 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S281817AbRLHPTX>; Sat, 8 Dec 2001 10:19:23 -0500
Subject: Re: SMP 440GX+ hang on boot (2.4.16)
To: ncjeffgus@zimage.com
Date: Sat, 8 Dec 2001 15:28:29 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20011208122147.C62182F055@alpha.zimage.com> from "Jeff Gustafson" at Dec 08, 2001 04:21:47 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16CjOv-0001j9-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> AIC7xxx controller.  We also have a DAC960.  When the system tries to mount
> the drives on the DAC960 (nothing is connected to the AIC7xxx), the system
> hangs.  Supposedly the problem is only with UP kernels, but we get hangs 
> with a SMP compiled kernel!
> work.  Is there a possiblity that the fix could posted to linux-kernel?  

I have no idea why the -ac kernel happens to work in your case. The
following is the standard RH message on the subject. Since -ac works and
2.4.16/17 doesn't I'd be suspicious that you may be seeing a different
problem. 

---------------------

Most implementations using the 440GX chipset require the "apic"
option to function correctly.  When this is the case, providing
DMI information to Red Hat as documented below[1] may allow us to
automate that setting in the future.

On some systems, the "apic" boot flag may not work.  Unfortunately,
because of Intel Proprietary information, these platforms are not
supported at this time.

[1] wget http://people.redhat.com/arjanv/dmidecode.c
    gcc dmidecode.c -o dmidecode
    ./dmidecode | \
       mail -s 'requires apic option to install' hardwarebugs-list@redhat.com

---------------------


Intel to my knowledge are still failing to provide either BIOSes with
suitable $PIR IRQ routing table data or explanations of how to work around
the problems with the 440GX. You may wish to consult your supplier for
advice, especially if the machine was sold to you for the purpose of
running Linux.

Alan
