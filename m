Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264346AbUGIFah@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264346AbUGIFah (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Jul 2004 01:30:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264367AbUGIFag
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Jul 2004 01:30:36 -0400
Received: from host84.200-117-131.telecom.net.ar ([200.117.131.84]:30641 "EHLO
	smtp.bensa.ar") by vger.kernel.org with ESMTP id S264346AbUGIFae
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Jul 2004 01:30:34 -0400
From: Norberto Bensa <norberto+linux-kernel@bensa.ath.cx>
To: linux-kernel@vger.kernel.org
Subject: Re: raidstart used deprecated START_ARRAY ioctl
Date: Fri, 9 Jul 2004 02:30:24 -0300
User-Agent: KMail/1.6.2
Cc: Neil Brown <neilb@cse.unsw.edu.au>
References: <200407090135.12493.norberto+linux-kernel@bensa.ath.cx> <16622.11173.888745.161113@cse.unsw.edu.au>
In-Reply-To: <16622.11173.888745.161113@cse.unsw.edu.au>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200407090230.24696.norberto+linux-kernel@bensa.ath.cx>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Neil,

Neil Brown wrote:
> On Friday July 9, norberto+linux-kernel@bensa.ath.cx wrote:
> > Hello,
> >
> > What does this mean and how do I fix it?
>
> If you have a degraded array, there is at-least and even chance that
> raidstart will not successfully start it for you.

Aha. It didn't start the array when I compiled md and raid0 built-in; that's 
how I discovered this.

It works as modules (weird to me, but I'm not a kernel guru)

> So, you should stop using raidstart.

Ok.

> The options are:
>
>  1/ use "autodetect".  I'm not a big fan of this personally, but it is
>    much more reliable than START_ARRAY.

I already have. But Gentoo uses raidstart (This is pure guessing, I need to 
dig into the init scripts.

>    This is done by set the partition type of all partitions that
>    contain part of an MD array to "Linux Raid Autodetect" (0xFD).
>    Then all arrays are found and assembled at boot time.
>    This requires having all of md (that you need) compiled into the
>    kernel, not as modules.

Did I get that right? Can I get rid of raidstart and the array will be 
"assembled by the kernel"?

>  2/ use mdadm.  Read the man page about ASSEMBLE MODE.
>     You have  an /etc/mdadm.conf that lists
>       - devices (or partitions) to scan
>       - arrays to be started
>       -  UUID of each array
>
>     and mdadm will find and assemble the arrays.

I think I have read something about mdadm in Gentoo docs somewhere. I really 
need to check that out.

Thanks Neil.

Best regards,
Norberto
