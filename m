Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269369AbUI3RhG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269369AbUI3RhG (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Sep 2004 13:37:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269366AbUI3RhG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Sep 2004 13:37:06 -0400
Received: from [80.227.59.61] ([80.227.59.61]:8322 "EHLO HasBox.COM")
	by vger.kernel.org with ESMTP id S269369AbUI3RhB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Sep 2004 13:37:01 -0400
Message-ID: <415C44FF.4030603@0Bits.COM>
Date: Thu, 30 Sep 2004 21:40:15 +0400
From: Mitch <Mitch@0Bits.COM>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8a4) Gecko/20040928
X-Accept-Language: en-us, en, ar
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: 2.6.9-rc3 software suspend (pmdisk) stopped working
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Kevin Fenzi <kevin-linux-kernel () scrye ! com> wrote:
 >
 > /sys/power/disk is for deciding how to do suspend to disk.
 > shutdown = do it with the in kernel code
 > platform = do it with the BIOS code
 >
 > Mitch>  ~% cat /sys/power/disk
 > Mitch>  shutdown
 > Mitch>  ~% cat /sys/power/state
 > Mitch>  standby mem disk

Well i've not got 'platform' in my /sys/power/disk, so how do
i enable it ?

 > Mitch> Remember this worked fine in -rc2.
 >
 > Yes, but in rc3 the merge between pmdisk and swsusp1 happened.
 > It basically has totally changed between rc2 and rc3.
 >
 > So, looks like that setting is right.
 >
 > So if you wait until it's done writing out pages and hard power it
 > off, does it resume?

Well it just continues the script and reenables power to all devices,
and starts the network, spins up disk, etc, so i'm not sure it's wise
to hard power off. There's no pause inbetween.

 > Does it work if you boot with:
 > acpi=off

I don't use ACPI. My lappie only supports APM. The bios did power off
the laptop correctly in -rc2.

 > >> I wonder how many of Pavel's speed improvment patches went in with
 > >> the pmdisk/swsusp merge in rc3? I guess I can try it and see. :)
 >
 > Mitch> The speed improvement that made it stop working surely went in
 > Mitch> ;-)
 >
 > Well, thats not one we want. ;)
