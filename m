Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262882AbSJ1KRF>; Mon, 28 Oct 2002 05:17:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262908AbSJ1KRF>; Mon, 28 Oct 2002 05:17:05 -0500
Received: from [213.196.40.44] ([213.196.40.44]:62175 "EHLO blackstar.nl")
	by vger.kernel.org with ESMTP id <S262882AbSJ1KRD>;
	Mon, 28 Oct 2002 05:17:03 -0500
Date: Mon, 28 Oct 2002 08:59:33 +0100 (CET)
From: Bas Vermeulen <bvermeul@blackstar.nl>
To: Bernd Petrovitsch <bernd@gams.at>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.20pre11aa1 freezes after inserting a PCMCIA ethernet card
In-Reply-To: <14349.1035762335@frodo.gams.co.at>
Message-ID: <Pine.LNX.4.33.0210280855550.8026-100000@devel.blackstar.nl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Bernd,

> I have a Toshiba Satellite 2540 CDT laptop. It works with a stock 
> Redat-6.2 2.2.14 kernel RPM (but not with the 2.2.19 Update RPM - 
> symptoms are similar to below). The system is basically a RedHat-7.3 
> with the 2.2.14 kernel from RedHat-6.2 and some newer RPMS from 
> RawHide.
> The Kernel (probably) freezes after inserting a Surecom PCMCIA 
> Ethernet Card (EP-427/EP-427-T) since it always fsck'es the
> filesystems during the next boot. If the laptop is booted without
> the card, everything is working properly (though I do not do much
> without the network card).
> This happens if the PCMCIA card already is inserted during startup or 
> if it is inserted later on (after a successful boot as described above).

You may want to try to cut back on io ports probed by cardmgr.
Almost the same happens on my box, when I don't cull some of the io ports
in /etc/pcmcia/config.opts. You can try commenting out some of the ports 
there (I believe 0x800 was the culprit on my laptop, ymmv).

Hope this helps,

Bas Vermeulen

-- 
"God, root, what is difference?" 
	-- Pitr, User Friendly

"God is more forgiving." 
	-- Dave Aronson

