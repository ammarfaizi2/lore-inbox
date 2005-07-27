Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261292AbVG0R7f@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261292AbVG0R7f (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Jul 2005 13:59:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261336AbVG0R7f
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Jul 2005 13:59:35 -0400
Received: from totor.bouissou.net ([82.67.27.165]:44476 "EHLO
	totor.bouissou.net") by vger.kernel.org with ESMTP id S261292AbVG0R7d
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Jul 2005 13:59:33 -0400
From: Michel Bouissou <michel@bouissou.net>
Organization: Me, Myself and I
To: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [SOLVED ?] VIA KT400 + Kernel 2.6.12 + IO-APIC + ehci_hcd = IRQ trouble
Date: Wed, 27 Jul 2005 19:59:30 +0200
User-Agent: KMail/1.7.2
Cc: "Protasevich, Natalie" <Natalie.Protasevich@UNISYS.com>,
       dbrownell@users.sourceforge.net, linux-kernel@vger.kernel.org
References: <Pine.LNX.4.44L0.0507261450160.4914-100000@iolanthe.rowland.org> <200507262139.27150@totor.bouissou.net> <200507262144.10865@totor.bouissou.net>
In-Reply-To: <200507262144.10865@totor.bouissou.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Message-Id: <200507271959.31302@totor.bouissou.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Le Mardi 26 Juillet 2005 21:44, Michel Bouissou a écrit :
>
> > Now I'm running with IO-APIC enabled, bus USB 2.0 and ehci completely
> > disabled (both in BIOS and modprobe.conf).
> >
> > The system hasn't hanged again, but I haven't tried to play with on-disk
> > ISO filesystems since...
>
> I just did the same as 1/ and 2/ again, with USB 2.0 disabled, to make my
> mind. It didn't hang (otherwise I would need to reboot before writing this
> message ;-)

Update: The system hasn't hanged anymore and has shown stable and fast since 
I've disabled USB 2.0.

Today I've stressed it quite a lot, played with ISOFS, loopback FS, performed 
disk-to-disk backups, burned CDs, used wine and dosemu etc. and it worked 
perfectly. None of the things that caused it to hang yesterday when USB 2.0 
was enabled caused any problem today.

So now it summarizes as :

- Old BIOS, kernel 2.4.x : System perfectly stable (with IO-APIC and USB 2.0)

- Old BIOS, kernel 2.6.12 : With IO-APIC and USB 2.0, "IRQ 21 - nobody cared" 
problems. Disabling either IO-APIC or USB 2.0 causes the problem to 
disappear.

- New BIOS, kernel 2.6.12 : With IO-APIC and USB 2.0, uhci and ehci are now on 
the same IRQ. System doesn't complain anymore about USB or IRQ lost, BUT it 
may completely *HANG* (is unstable) especially under high activity. Nothing 
gets logged or displayed as the system purely and simply hangs.
=> With USB 2.0 completely disabled, the problem seems to disappear and the 
system looks stable again.

Cheers.

-- 
Michel Bouissou <michel@bouissou.net> OpenPGP ID 0xDDE8AC6E
