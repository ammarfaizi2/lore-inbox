Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129853AbRCAUDO>; Thu, 1 Mar 2001 15:03:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129856AbRCAUDA>; Thu, 1 Mar 2001 15:03:00 -0500
Received: from m114-mp1-cvx1c.col.ntl.com ([213.104.76.114]:12804 "EHLO
	[213.104.76.114]") by vger.kernel.org with ESMTP id <S129848AbRCAUBb>;
	Thu, 1 Mar 2001 15:01:31 -0500
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: bradley mclain <bradley_kernel@yahoo.com>, <linux-kernel@vger.kernel.org>
Subject: Re: APM suspend system lockup under 2.4.2 and 2.4.2ac1
In-Reply-To: <E14Wi5n-0000AV-00@the-village.bc.nu>
From: John Fremlin <chief@bandits.org>
Date: 01 Mar 2001 20:00:47 +0000
In-Reply-To: Alan Cox's message of "Sat, 24 Feb 2001 17:02:45 +0000 (GMT)"
Message-ID: <m21yshtg28.fsf@boreas.yi.org.>
User-Agent: Gnus/5.0807 (Gnus v5.8.7) XEmacs/21.1 (GTK)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 Alan Cox <alan@lxorguk.ukuu.org.uk> writes:

> > the sound card is a yamaha YMF-744B.  i hadn't been
> > compiling with sound support (i dont care about sound
> > on my laptop), but when i got 2.4.2 i decided to try,
> > and now i'm pretty sure that was the problem.
> 
> The Yamaha sound driver doesnt handle the case where the bios fails
> to restore the chip status and expects a windows driver to do its
> dirty work. That requires on resume that the device is completely
> reloaded.
> 
> A workaround is to make it a module, unload it before suspend and
> reload it after resume but thats pretty umm uggly.

Why not use kernel/pm.c:pm_register? Then you can either refuse
suspend or have a proper workaround.

-- 

	http://www.penguinpowered.com/~vii
