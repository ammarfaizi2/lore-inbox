Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750795AbVLGKa7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750795AbVLGKa7 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Dec 2005 05:30:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750806AbVLGKa7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Dec 2005 05:30:59 -0500
Received: from hobbit.corpit.ru ([81.13.94.6]:16984 "EHLO hobbit.corpit.ru")
	by vger.kernel.org with ESMTP id S1750795AbVLGKa6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Dec 2005 05:30:58 -0500
Message-ID: <4396B9DE.40908@tls.msk.ru>
Date: Wed, 07 Dec 2005 13:30:54 +0300
From: Michael Tokarev <mjt@tls.msk.ru>
User-Agent: Debian Thunderbird 1.0.2 (X11/20051002)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Pavel Machek <pavel@ucw.cz>
CC: Linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Could not suspend device [VIA UHCI USB controller]: error -22
References: <43923479.3020305@tls.msk.ru> <20051205132143.GC7478@elf.ucw.cz>
In-Reply-To: <20051205132143.GC7478@elf.ucw.cz>
X-Enigmail-Version: 0.91.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pavel Machek wrote:
> Hi!
> 
>>Also, "suspend to mem" does just nothing, -- the same as "suspend to disk"
>>(but for disk, it never worked at all as stated above).
> 
> 
> Can you quote exact messages? Suspend to mem should not have problems
> without 4MB pages, as it does not do any pagetables related magic. If
> it does include same check, it is bug and should be easy to fix.

Hmm.. There's no messages, no at all.

 echo mem > /sys/power/state

does exactly nothing.  When writing 'suspend' to that file, the system
at least tries to do something (now with 2.6.15-rc4 it completes the
syspend procedure; but it wakes up again in a secound or two), with all
the messages et al, but not 'mem' or 'disk' - no messages at all.

/mjt
