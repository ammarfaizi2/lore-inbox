Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264530AbUHJKkM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264530AbUHJKkM (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Aug 2004 06:40:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264561AbUHJKkA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Aug 2004 06:40:00 -0400
Received: from postfix3-2.free.fr ([213.228.0.169]:42711 "EHLO
	postfix3-2.free.fr") by vger.kernel.org with ESMTP id S264261AbUHJKfv
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Aug 2004 06:35:51 -0400
Message-ID: <4118A500.1080306@free.fr>
Date: Tue, 10 Aug 2004 12:35:44 +0200
From: Eric Valette <eric.valette@free.fr>
Reply-To: eric.valette@free.fr
Organization: HOME
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040808 Debian/1.7.2-1
X-Accept-Language: en
MIME-Version: 1.0
To: "Brown, Len" <len.brown@intel.com>
Cc: eric.valette@free.fr, Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Karol Kozimor <sziwan@hell.org.pl>
Subject: 2.6.8-rc4-mm1 : Hard freeze due to ACPI
References: <41189098.4000400@free.fr>
In-Reply-To: <41189098.4000400@free.fr>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Eric Valette wrote:
> I tried 2.6.8-rc4-mm1 on my ASUS L3800C laptop (radeon 7500), defined 
> CONFIG_FB_MODE_HELPERS and I have got a hard freeze when starting X and 
> framebuffer console with a lot of yellow dot on the bottom screen. 
> Suddently I hear the fan meaning the machine is dead

OK I've reverted the most suspect change 
(remove-unconditional-pci-acpi-irq-routing.patch) and it did not fix the 
problem. As Karol Kozimor suspected ACPI, I then tried with acpi=off and 
then it boot but I will burn my CPU as fans are ACPI controlled...

So it is probably due to the bk-acpi.patch and more precisely the 
difference between what was in 2.6.8-rc3-mm1 and 2.6.8-rc4-mm1.

Len, any proposal as candidate patches to revert?

-- eric

