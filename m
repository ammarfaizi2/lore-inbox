Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266135AbRF2SCf>; Fri, 29 Jun 2001 14:02:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266151AbRF2SCM>; Fri, 29 Jun 2001 14:02:12 -0400
Received: from [194.213.32.142] ([194.213.32.142]:12804 "EHLO bug.ucw.cz")
	by vger.kernel.org with ESMTP id <S266146AbRF2SA4>;
	Fri, 29 Jun 2001 14:00:56 -0400
Message-ID: <20010629005730.I525@bug.ucw.cz>
Date: Fri, 29 Jun 2001 00:57:30 +0200
From: Pavel Machek <pavel@suse.cz>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Abramo Bagnara <abramo@alsa-project.org>
Cc: D.A.Fedorov@inp.nsk.su, Oliver Neukum <Oliver.Neukum@lrz.uni-muenchen.de>,
        Balbir Singh <balbir_soni@yahoo.com>, linux-kernel@vger.kernel.org
Subject: Re: Is it useful to support user level drivers
In-Reply-To: <3B322224.91E17820@alsa-project.org> <E15D8Ec-0001lL-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.93i
In-Reply-To: <E15D8Ec-0001lL-00@the-village.bc.nu>; from Alan Cox on Thu, Jun 21, 2001 at 06:27:14PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > (i.e. counted). An alternative to queuing (user selectable) is to block
> > interrupt generation at hardware level in kernel space immediately
> > before notification.
> > 
> > I'm missing something?
> 
> IRQ 9 shared between user space app and disk. IRQ arrives is disabled and
> reported, app wakes up, app wants to page in code, IRQ is disabled,
> box dies

Actually, what about specifying that your usermode app has to be
pagelocked?

Alternatively.... You *can* do disk I/O without interrupts. Just poll
your IDE controller. [I'm doing that on my velo.] Hopefully your timer
IRQ is not shared with usermode app, then :-( [but that's almost
impossible on PCs, right?].
								Pavel
-- 
I'm pavel@ucw.cz. "In my country we have almost anarchy and I don't care."
Panos Katsaloulis describing me w.r.t. patents at discuss@linmodems.org
