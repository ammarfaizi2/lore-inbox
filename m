Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265841AbUGTNRu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265841AbUGTNRu (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Jul 2004 09:17:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265847AbUGTNRu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Jul 2004 09:17:50 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:14980 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S265841AbUGTNRs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Jul 2004 09:17:48 -0400
Date: Tue, 20 Jul 2004 15:17:48 +0200
From: Pavel Machek <pavel@ucw.cz>
To: =?iso-8859-2?Q?=C9ric?= Brunet <Eric.Brunet@lps.ens.fr>
Cc: Linux Kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: swsuspend not working
Message-ID: <20040720131748.GI27492@atrey.karlin.mff.cuni.cz>
References: <20040715121042.GB9873@lps.ens.fr> <20040715121825.GC22260@elf.ucw.cz> <20040715132348.GA9939@lps.ens.fr> <20040719191906.GA7053@lps.ens.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040719191906.GA7053@lps.ens.fr>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> Ok, it is not surprising that the fedora kernel does not suspend to disk;
> suspend to disk is not compiled in. What a weird decision from them.

Oops.

> If, instead of unloading/reloading the modules, I unplug and replug the
> radio emiter of the mouse, I get it back working. If I unplug the memory
> key, the device REMAINS as managed by the ehci controller. If I plug it
> back again, the memory key appears A SECOND TIME in the list of usb
> device, but as an uhci device, this time.

Ok, someone needs to fix usb.

> Another device is not working after resume: it is an old realtek 8029
> 100 Mb LAN pci card. If I try to ping something on the LAN, I get a
> ? Destination Host Unreachable ? and nothing more. The interrupt count of
> the card is increasing, however. Unloading and reloading ne2k_pci fixes
> that.

Teach ne2k_pci to do on suspend what it does on unload, and to do on
resume what it does on load. Should be easy.

Oh and maybe "noapic".
									Pavel
-- 
Horseback riding is like software...
...vgf orggre jura vgf serr.
