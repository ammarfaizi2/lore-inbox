Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268328AbUINEXJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268328AbUINEXJ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Sep 2004 00:23:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268899AbUINEXJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Sep 2004 00:23:09 -0400
Received: from a26.t1.student.liu.se ([130.236.221.26]:38053 "EHLO
	mail.drzeus.cx") by vger.kernel.org with ESMTP id S268328AbUINEW6
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Sep 2004 00:22:58 -0400
Message-ID: <41467216.6070508@drzeus.cx>
Date: Tue, 14 Sep 2004 06:22:46 +0200
From: Pierre Ossman <drzeus-list@drzeus.cx>
User-Agent: Mozilla Thunderbird 0.7.1 (X11/20040704)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Pavel Machek <pavel@suse.cz>
CC: seife@suse.de, LKML <linux-kernel@vger.kernel.org>
Subject: Re: HP/Compaq (Winbond) SD/MMC reader supported
References: <41383D02.5060709@drzeus.cx> <20040913223827.GA28524@elf.ucw.cz>
In-Reply-To: <20040913223827.GA28524@elf.ucw.cz>
X-Enigmail-Version: 0.84.2.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pavel Machek wrote:

>
>
>Hmm, it does something here on my nx5000... It causes 2 "bad parity
>from KBD" errors and then freezes boot. But the chip is detected and I
>see 
>
>mmc0: W83L51xD id f00 at 0x248 irq 1 dma 0
>
>message. (How do I guess right values for irq? I thought that
>interference with keyboard means it uses irq 1, but it is probably not
>the case, and default values did not work, too).
>
>I'll try turning off ALSA because it actually freezes machine only
>after alsa is loaded.
>  
>
You seem to be running an old version of the driver. The ports for the 
driver are also often populated by SuperIO chip. The detection routine 
was a bit optimistic in the earlier versions so it started resetting the 
wrong hardware.

As of writing the latest version is 0.7 and a patch can be downloaded at:

http://projects.drzeus.cx/wbsd/download.php?get=files/wbsd-0.7.patch

Rgds
Pierre
