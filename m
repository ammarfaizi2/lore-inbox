Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270933AbRHNXRH>; Tue, 14 Aug 2001 19:17:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270931AbRHNXQ5>; Tue, 14 Aug 2001 19:16:57 -0400
Received: from anchor-post-32.mail.demon.net ([194.217.242.90]:4626 "EHLO
	anchor-post-32.mail.demon.net") by vger.kernel.org with ESMTP
	id <S270934AbRHNXQk>; Tue, 14 Aug 2001 19:16:40 -0400
Subject: Re: Report: Sony Handycam USB and Linux 2.4.9-pre2
From: Richard Russon <ldm@flatcap.org>
To: linux-usb-users@lists.sourceforge.net,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Klaus Mueller <klmuell@web.de>
In-Reply-To: <200108142242.AAA22621@mailb.telia.com>
In-Reply-To: <200108141108.f7EB8v612177@mailgate3.cinetic.de> 
	<200108142242.AAA22621@mailb.telia.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/0.12.99 (Preview Release)
Date: 15 Aug 2001 00:16:49 +0100
Message-Id: <997831010.26092.81.camel@home.flatcap.org>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Roger,

> 2.4.9-pre2
>  identifies the device correctly - no patch needed
>  (similar patch in unusual-devices)
>  but is not able to open it "unknown partition table" reported from
>  enabled LDM ... (I enabled it in an attempt to enable everything)

Afraid I can't help you, but I can probably rule out the LDM.
It's failing when it tries to read a 1KB block from the very
beginning of the device: "Unable to read partition table."

LDM complains because it's the first in line for checking
partitions.  If you were to disable it, then msdos would complain
(and give up), instead.

FlatCap (Rich)
ldm@flatcap.org



