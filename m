Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268059AbUIFOLv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268059AbUIFOLv (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Sep 2004 10:11:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268060AbUIFOLu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Sep 2004 10:11:50 -0400
Received: from rproxy.gmail.com ([64.233.170.195]:62854 "EHLO mproxy.gmail.com")
	by vger.kernel.org with ESMTP id S268059AbUIFOLr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Sep 2004 10:11:47 -0400
Message-ID: <9e47339104090607111e8a6f5d@mail.gmail.com>
Date: Mon, 6 Sep 2004 10:11:46 -0400
From: Jon Smirl <jonsmirl@gmail.com>
Reply-To: Jon Smirl <jonsmirl@gmail.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: Intel ICH - sound/pci/intel8x0.c
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <1094470037.3816.5.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <20040906083139.GA1188@linux.ensimag.fr>
	 <1094470037.3816.5.camel@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The hotplug event of interest is the insertion of the snd_intel8x0
chip, not the insertion of the LPC bridge. It's hooking to both
events, it only needs to hook to the snd_intel8x0 event and then
search for a bridge if there is one.

Takashi says the code is already gone in the alsa tree so we don't
know how they fixed it.


On Mon, 06 Sep 2004 12:27:19 +0100, Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:
> On Llu, 2004-09-06 at 09:31, Matthieu Castet wrote:
> > > None of them help because you need to deal with hotplug.
> > Heu, I don't understant why you need to deal with hotplug ?
> > PnP modules works like pci modules. You make a list of know id, and then
> 
> ISAPnP has no hotplug functionality. If I have an ICH or 440MX in laptop
> docking stations the ISAPnP world simply can't report it, while the PCI
> hotplug layer can.
> 
> 
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 



-- 
Jon Smirl
jonsmirl@gmail.com
