Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261243AbVGLHwg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261243AbVGLHwg (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Jul 2005 03:52:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261245AbVGLHwg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Jul 2005 03:52:36 -0400
Received: from totor.bouissou.net ([82.67.27.165]:49307 "EHLO
	totor.bouissou.net") by vger.kernel.org with ESMTP id S261243AbVGLHw3
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Jul 2005 03:52:29 -0400
From: Michel Bouissou <michel@bouissou.net>
Organization: Me, Myself and I
To: "Protasevich, Natalie" <Natalie.Protasevich@UNISYS.com>
Subject: Re: [NOT solved] Kernel 2.6.12 + IO-APIC + uhci_hcd = Trouble
Date: Tue, 12 Jul 2005 09:52:21 +0200
User-Agent: KMail/1.7.2
Cc: "Bjorn Helgaas" <bjorn.helgaas@hp.com>,
       "Alan Cox" <alan@lxorguk.ukuu.org.uk>,
       "Alan Stern" <stern@rowland.harvard.edu>, linux-kernel@vger.kernel.org
References: <19D0D50E9B1D0A40A9F0323DBFA04ACCE04C4E@USRV-EXCH4.na.uis.unisys.com>
In-Reply-To: <19D0D50E9B1D0A40A9F0323DBFA04ACCE04C4E@USRV-EXCH4.na.uis.unisys.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Message-Id: <200507120952.22283@totor.bouissou.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Le Mardi 12 Juillet 2005 01:41, Protasevich, Natalie a écrit :
>
> Another thing is that you are getting large number of
> interrupts on the VIA device, whereas there is no any on 2.4. Does the
> chipset get enabled differently?

I believe this interruption is for the sound module. The /proc/interrupts I 
sent you for the 2.6 kernel had been taken with a system that had been 
running X11 (with nice sounds ;-) for a while, where the /proc/interrupts I 
sent you for the 2.4 kernel had been taken just after having booted in 
runlevel 3 for a short while, without having produced any sound. This might 
explain this difference.

> > And what should be relevant to USB in the boot log...:
[...]
> Here I see that no fixups were applied to the chipset, and it seemed to
> work just fine without them.

I'm not sure that the 2.4 series kernel logged the IRQ fixups the same way 2.6 
does... I'm no kernel specialist.
But I remember that long ago (with early 2.4 kernels) I had had interrupts 
problems with the VIA chipset, until some specific VIA fixes were integrated 
into the 2.4 kernel, and since this day everything was OK -- until I tried 
2.6 kernels...

> I would experiment and turn fixups off, but 
> since this is a production system... Hmmm.

Yes, and I'm really afraid of breaking my storage, as the EVMS snapshots I use 
to perform backups seems to be severely broke with the 2.6 kernel and my 
system -- which means I don't have recent and reliable backups until this 
gets fixed, but this is another issue.

> Seeing actual IO-APIC setup in both cases would help, the ones you get
> with apic=verbose, and you might have to provide full traces (as
> attachment for example). It is somewhat comforting for me to know that
> my patch is not affecting the outcome. But it is important to crack this
> case of course. I think we need higher authority here, such as Bjorn, or
> Alan...

Please tell me how you would like me to boot ;-)

Another little issue is that, with kernel 2.4, the activation of EVMS and RAID 
sets from my initrd produces very verbose output, so verbose that the very 
beginning of the dmesg messages gets lost before true loggin is started and 
they have a chance to get copied to /var/log/messages... It has never been an 
issue to me as 2.4 is running fine... But if you want my 2.4 kernel to 
produce yet more verbose output, it might be difficult ;-)

I don't have this problem in 2.6 as the EVMS/RAID startup is far less verbose.

Cheers.

-- 
Michel Bouissou <michel@bouissou.net> OpenPGP ID 0xDDE8AC6E
