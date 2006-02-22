Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750779AbWBVPZY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750779AbWBVPZY (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Feb 2006 10:25:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751308AbWBVPZY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Feb 2006 10:25:24 -0500
Received: from relay4.usu.ru ([194.226.235.39]:17309 "EHLO relay4.usu.ru")
	by vger.kernel.org with ESMTP id S1750779AbWBVPZY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Feb 2006 10:25:24 -0500
Message-ID: <43FC8290.8070408@ums.usu.ru>
Date: Wed, 22 Feb 2006 20:26:08 +0500
From: "Alexander E. Patrakov" <patrakov@ums.usu.ru>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; ru-RU; rv:1.8.0.1) Gecko/20060130 SeaMonkey/1.0
MIME-Version: 1.0
To: "Alexander E. Patrakov" <patrakov@ums.usu.ru>,
       LKML <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>
Subject: Re: 2.6.16-rc4-mm1
References: <20060220042615.5af1bddc.akpm@osdl.org> <43FC6B8F.4060601@ums.usu.ru>
In-Reply-To: <43FC6B8F.4060601@ums.usu.ru>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-AntiVirus: checked by AntiVir MailGate (version: 2.0.1.15; AVE: 6.33.1.0; VDF: 6.33.1.18; host: usu2.usu.ru)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I wrote:

> there will be probably another report of real issues.

It boots and doesn't oops. I have played with libata a bit (booted off 
ext3 on LVM2 on via pata, played some CD audio tracks, and a DVD intro - 
btw this also counts as snd-fm801 test). It is still slow because of 
improper MWDMA2 setting (libata still doesn't know that master and slave 
can use different DMA speeds on via pata).

ppracer works, so this counts as r200 DRM test.

I also hit the already-known psmouse resync issue:

psmouse.c: resync failed, issuing reconnect request
input: ImExPS/2 Logitech Wheel Mouse as /class/input/input2

And, because you can read this, the 8250 serial driver and the PPP 
protocol work.

Of course the above doesn't form good testing, so I will just use this 
kernel and report if I find more.

-- 
Alexander E. Patrakov
