Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312885AbSDQUDL>; Wed, 17 Apr 2002 16:03:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313224AbSDQUDK>; Wed, 17 Apr 2002 16:03:10 -0400
Received: from harpo.it.uu.se ([130.238.12.34]:7932 "EHLO harpo.it.uu.se")
	by vger.kernel.org with ESMTP id <S312885AbSDQUDI>;
	Wed, 17 Apr 2002 16:03:08 -0400
Date: Wed, 17 Apr 2002 22:02:46 +0200 (MET DST)
From: Mikael Pettersson <mikpe@csd.uu.se>
Message-Id: <200204172002.WAA23916@harpo.it.uu.se>
To: axboe@suse.de
Subject: Re: 2.5.8 IDE oops (TCQ breakage?)
Cc: dalecki@evision-ventures.com, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 17 Apr 2002 14:25:02 +0200, Jens Axboe wrote:
>> > Mikael Pettersson wrote:
>> > >I have a 486 box which ran 2.5.7 fine, but 2.5.8 oopses during
>> > >boot at the BUG_ON() in drivers/ide/ide-disk.c, line 360:
...
>Should only be done if 'enable_tcq == 1' of course, and we also need to
>switch off tcq when dma is being disabled. 4th patch set against 2.5.8.

Thanks, this patch set cured the problem. 2.5.8-dj1 also worked.

/Mikael
