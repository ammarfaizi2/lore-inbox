Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263839AbUC3TQG (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Mar 2004 14:16:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263874AbUC3TP7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Mar 2004 14:15:59 -0500
Received: from smtp2.fuse.net ([216.68.8.172]:8640 "EHLO smtp2.fuse.net")
	by vger.kernel.org with ESMTP id S263860AbUC3TPG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Mar 2004 14:15:06 -0500
From: "Ivica Ico Bukvic" <ico@fuse.net>
To: "'Russell King'" <rmk+lkml@arm.linux.org.uk>
Cc: "'A list for linux audio users'" 
	<linux-audio-user@music.columbia.edu>,
       <alsa-devel@lists.sourceforge.net>, <linux-kernel@vger.kernel.org>,
       <linux-pcmcia@lists.infradead.org>
Subject: RE: [linux-audio-user] snd-hdsp+cardbus=distortion -- the sagacontinues (cardbus driver=culprit?) UPDATE: 99.9% sure it is the cardbus driver yenta_socket
Date: Tue, 30 Mar 2004 14:15:10 -0500
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook, Build 11.0.5510
In-Reply-To: <20040330090053.A3956@flint.arm.linux.org.uk>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1165
Thread-Index: AcQWLSJrWd4H2l+vT7KET0lXWqUIVgAXb5tQ
Message-Id: <20040330191504.WSHZ17964.smtp2.fuse.net@64BitBadass>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> -----Original Message-----
> From: Russell King [mailto:rmk@arm.linux.org.uk] On Behalf Of Russell King
> Sent: Tuesday, March 30, 2004 3:01 AM
> To: Ivica Ico Bukvic
> Cc: 'A list for linux audio users'; alsa-devel@lists.sourceforge.net;
> linux-kernel@vger.kernel.org; linux-pcmcia@lists.infradead.org
> Subject: Re: [linux-audio-user] snd-hdsp+cardbus=distortion -- the
> sagacontinues (cardbus driver=culprit?) UPDATE: 99.9% sure it is the
> cardbus driver yenta_socket
> 
> On Tue, Mar 30, 2004 at 12:52:11AM -0500, Ivica Ico Bukvic wrote:
> > 6) Pester alsa-dev, lau, and kernel/pcmcia people to death begging for
> help
> > :-)
> >
> > IN-PROGRESS :-)
> 
> What needs to happen is that the card driver author needs to investigate
> what is going on, and, if it seems related to the core PCMCIA core or
> the socket driver, we need to get involved.
> 
> IOW, linux-pcmcia people don't debug card drivers.
> 

To add to what Tim mentioned, I think that the driver is fine as it does
work on select notebooks and desktops (the card can be plugged into either
PCI card or PCMCIA cardbus). Yet, in these select instances it does not work
even though neither the cardbus driver nor the actual card driver do not
report any particular problems. Hence the only logical explanation is that
there is something wrong with the pcmcia controller driver.

This card does tax the throughput of the cardbus like no other card I can
think of, hence the problem may be more widespread, but exhibits itself just
in this case where the cardbus is being pushed to its limits. Yet, the
hardware is not the issue when the same notebook/soundcard combo works
flawlessly in WinXP.

Hope this helps!

Ico




