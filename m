Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262442AbUDDPvq (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 4 Apr 2004 11:51:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262451AbUDDPvq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Apr 2004 11:51:46 -0400
Received: from postfix3-2.free.fr ([213.228.0.169]:19910 "EHLO
	postfix3-2.free.fr") by vger.kernel.org with ESMTP id S262442AbUDDPvo
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Apr 2004 11:51:44 -0400
To: linux-kernel@vger.kernel.org
Subject: Re: Drivers *dropped* between releases? (sis5513.c)
Mail-Copies-To: never
X-Face: ,MPrV]g0IX5D7rgJol{*%.pQltD?!TFg(`c8(2pkt-F0SLh(g3mIFYU1GYf]C/GuUTbr;cZ5y;3ALK%.OL8A.^.PW14e/,X-B?Nv}2a9\u-j0sSa
References: <1GOHw-6te-9@gated-at.bofh.it> <1GOHw-6te-11@gated-at.bofh.it>
	<1GOHw-6te-7@gated-at.bofh.it> <1GP0Q-6Fz-9@gated-at.bofh.it>
From: Roland Mas <roland.mas@free.fr>
Date: Sun, 04 Apr 2004 17:51:37 +0200
In-Reply-To: <1GP0Q-6Fz-9@gated-at.bofh.it> (Lionel Bouton's message of
 "Sat, 03 Apr 2004 10:50:08 +0200")
Message-ID: <871xn3hhbq.fsf@mirexpress.internal.placard.fr.eu.org>
User-Agent: Gnus/5.1006 (Gnus v5.10.6) Emacs/21.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Lionel Bouton, 2004-04-03 10:50:08 +0200 :

> Roland Mas wrote the following on 04/03/2004 10:19 AM :
>
>>[...]
>>  More relevant info (maybe): I got an old version of the Debian
>>installer, which uses an older kernel, and the process goes on
>>normally (well, it halts later because the built-in NIC has a stupid
>>MAC address, but that's another problem).
>
> If you can find the time, please check that this old installer
> doesn't use the sis5513 driver or DMA transfers. If it does both,
> I'd be really interested by the exact kernel version used. 

uname -a reports "2.4.22-1-386", although I suppose it's been patched
by the debian-installer team.  After hardware detection has run and
worked (as in, no hangs), sis5513 does indeed appear in lsmod, and
"dmesg | grep -i dma" tells me hda and hdc do use DMA.

> If it doesn't, you'd probably found yourself a workaround by
> disabling dma at boot time.

  I couldn't find out how to do that.  I tried booting with a long
"linux nodma hda=nodma hdc=nodma ide=nodma idebus=nodma" command-line,
but that didn't seem to change much.  I also tried disabling
everything that looked like DMA in the BIOS setup, to no avail.  dmesg
still tells me the kernel uses DMA (or maybe I don't understand what
dmesg tells me, which is of course entirely possible).

Roland.
-- 
Roland Mas

Late frost burns the bloom / Would a fool not let the belt / Restrain the body?
  -- in Good Omens (Terry Pratchett and Neil Gaiman)
