Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264251AbUEOS5E@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264251AbUEOS5E (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 15 May 2004 14:57:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264360AbUEOS5E
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 15 May 2004 14:57:04 -0400
Received: from dbl.q-ag.de ([213.172.117.3]:50404 "EHLO dbl.q-ag.de")
	by vger.kernel.org with ESMTP id S264251AbUEOS5B (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 15 May 2004 14:57:01 -0400
Message-ID: <40A667CF.4000908@colorfullife.com>
Date: Sat, 15 May 2004 20:56:15 +0200
From: Manfred Spraul <manfred@colorfullife.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; fr-FR; rv:1.4.1) Gecko/20031114
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: foner+x-forcedeth@media.mit.edu
CC: c-d.hailfinger.kernel.2004@gmx.net, XFree86@XFree86.Org,
       debian-user@lists.debian.org, linux-kernel@vger.kernel.org
Subject: Re: forcedeth breaks X in Debian-testing 2.4.25 on MSI K7N2 Delta-L
 mobo
References: <200405130619.CAA18064@out-of-band.media.mit.edu>
In-Reply-To: <200405130619.CAA18064@out-of-band.media.mit.edu>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

foner+x-forcedeth@media.mit.edu wrote:

>So do you (or anyone) have any suggestions for what to do?  This is a
>reasonably new motherboard (I don't think it has any new firmware
>versions out yet) and this leaves me dead in the water---all I can do
>at this point is to just try the nVidia drivers and hope they work
>better than forcedeth.
>
I would propose that as the first step: If this fails, then you can try 
to get support from NVidia.

 From you description it doesn't look like a bug directly in the 
forcedeth driver: Perhaps a problem with a shared interrupt, or the vesa 
bios uses an area for I/O and the ethernet registers are remapped on top 
of the vesa registers.

Could you post lspci -vxx from both before and after loading forcedeth. 
Or try bios settings that sound like Plug-N-Play aware OS. Or try ACPI 
instead of APM (I've seen a boot log that contains both acpi and apm - 
which one do you use? Try to boot with "acpi=off", "pci=noacpi", etc.)

--
    Manfred

