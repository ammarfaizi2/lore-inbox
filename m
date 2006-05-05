Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751768AbWEEUky@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751768AbWEEUky (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 May 2006 16:40:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751742AbWEEUkx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 May 2006 16:40:53 -0400
Received: from hermes.drzeus.cx ([193.12.253.7]:14006 "EHLO mail.drzeus.cx")
	by vger.kernel.org with ESMTP id S1751216AbWEEUkx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 May 2006 16:40:53 -0400
Message-ID: <445BB859.9030800@drzeus.cx>
Date: Fri, 05 May 2006 22:40:57 +0200
From: Pierre Ossman <drzeus-list@drzeus.cx>
User-Agent: Thunderbird 1.5 (X11/20060313)
MIME-Version: 1.0
To: "=?ISO-8859-1?Q?Jani-Matti_H=E4tinen?=" <jani-matti.hatinen@iki.fi>
CC: linux-kernel@vger.kernel.org
Subject: Re: Lock-up with modprobe sdhci after suspending to ram
References: <515ed10f0604240033i71781bfdp421ed244477fd200@mail.gmail.com> <200604251645.58421.jani-matti.hatinen@iki.fi> <44538581.50608@drzeus.cx> <200605040957.30758.jani-matti.hatinen@iki.fi>
In-Reply-To: <200605040957.30758.jani-matti.hatinen@iki.fi>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jani-Matti Hätinen wrote:
> I'm not sure if this has any effect on the sdhci issue, but during a normal 
> suspend&resume (i.e. when sdhci has been rmmoded earlier) I get the following 
> error about the PCMCIA CardBus slot, which is on the same PCI channel as the 
> card reader (01:03.0 and 01:03.2 respectively):
>
> May  4 09:37:38 leevi PCMCIA: socket c14d8828: *** DANGER *** unable to remove 
> socket power
>
> And the PCMCIA slot doesn't work either after a suspend&resume. I haven't 
> tested FireWire yet (which is also on the same PCI channel 01:03.1), but I 
> will shortly.
>
>   

Sounds like there is something fundamentally broken with your suspend.
It seems like we should hold off on the card reader until the more basic
stuff, like the cardbus slot, works properly after resume.

Rgds
Pierre

