Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265684AbUAMV3I (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Jan 2004 16:29:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265683AbUAMV3H
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Jan 2004 16:29:07 -0500
Received: from adsl-ull-213-87.42-151.net24.it ([151.42.87.213]:16910 "EHLO
	gateway.milesteg.arr") by vger.kernel.org with ESMTP
	id S265786AbUAMV2O (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Jan 2004 16:28:14 -0500
Date: Tue, 13 Jan 2004 22:28:11 +0100
From: Daniele Venzano <webvenza@libero.it>
To: Pavel Machek <pavel@ucw.cz>, m.andreolini@tiscali.it
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: problems with suspend-to-disk (ACPI), 2.6.1-rc2
Message-ID: <20040113212811.GA12144@gateway.milesteg.arr>
Mail-Followup-To: Pavel Machek <pavel@ucw.cz>,
	m.andreolini@tiscali.it,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <3FE5F1110001ED59@mail-4.tiscali.it> <20040113131806.GA343@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040113131806.GA343@elf.ucw.cz>
X-Operating-System: Debian GNU/Linux on kernel Linux 2.4.24-xfs-grsec
X-Copyright: Forwarding or publishing without permission is prohibited.
X-Truth: La vita e' una questione di culo, o ce l'hai o te lo fanno.
X-GPG-Fingerprint: 642A A345 1CEF B6E3 925C  23CE DAB9 8764 25B3 57ED
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 13, 2004 at 02:18:06PM +0100, Pavel Machek wrote:
> Hi!
> 
> > I encountered a problem while resuming from a suspend-to-disk. I'm using
> > the
> > 2.6.1-rc2 kernel, running on an Athlon XP 2000.
> > >From a bash shell, I type:
> 
> SiS900 driver needs to be fixed. Or perhaps... try following patch.

I added support for sis900 and the bash was being killed even before the
driver had any support for suspend/resume.
I reported that same problem (shell being killed) some time ago, there was 
some follow up, but if I remember right no solution was found at the
time.

> > bad: scheduling while atomic!
> > Call Trace:
> >  [<c0119d16>] schedule+0x586/0x590
> >  [<c0124f5c>] __mod_timer+0xfc/0x170
> >  [<c0125ab3>] schedule_timeout+0x63/0xc0
> >  [<c0125a40>] process_timeout+0x0/0x10
> >  [<c01da44b>] pci_set_power_state+0xeb/0x190
> >  [<ec947823>] sis900_resume+0x63/0x130 [sis900]
> >  [<c01dc9a6>] pci_device_resume+0x26/0x30

I'll check this, the card keeps working after resume or not ?

Thanks, bye.

--
-----------------------------
Daniele Venzano
Web: http://teg.homeunix.org

