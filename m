Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932319AbWA3PZc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932319AbWA3PZc (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Jan 2006 10:25:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932320AbWA3PZc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Jan 2006 10:25:32 -0500
Received: from mailhub.fokus.fraunhofer.de ([193.174.154.14]:5103 "EHLO
	mailhub.fokus.fraunhofer.de") by vger.kernel.org with ESMTP
	id S932319AbWA3PZb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Jan 2006 10:25:31 -0500
From: Joerg Schilling <schilling@fokus.fraunhofer.de>
Date: Mon, 30 Jan 2006 16:24:24 +0100
To: schilling@fokus.fraunhofer.de, jengelh@linux01.gwdg.de
Cc: mrmacman_g4@mac.com, matthias.andree@gmx.de, linux-kernel@vger.kernel.org,
       bzolnier@gmail.com, acahalan@gmail.com
Subject: Re: CD writing in future Linux try #2 [ was: Re: CD writing in future Linux (stirring up a hornets' nest) ]
Message-ID: <43DE2FA8.nail16ZB1XOPF@burner>
References: <58cb370e0601270837h61ac2b03uee84c0fa9a92bc28@mail.gmail.com>
 <43DCA097.nailGPD11GI11@burner>
 <Pine.LNX.4.61.0601291212360.18492@yvahk01.tjqt.qr>
In-Reply-To: <Pine.LNX.4.61.0601291212360.18492@yvahk01.tjqt.qr>
User-Agent: nail 11.2 8/15/04
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jan Engelhardt <jengelh@linux01.gwdg.de> wrote:

> >Testing could be done the following way:
> >
> >-	insert a blank CD into your writer and do an initial test burn.
> >
> >	sdd -inull bs=2352 of= test.raw count=75x60x74
> >	cdrecord dev=ATA:b,t,0 -audio -sao -v test.raw
> >
> >	Remember the speed that should be > 40x
>
> Does speed==40 also suffice?

NO, speed==40 may be too slow as I cannot grant that it will
always fail with PIO and speed <=40.

In case that the clock rate of your CPU just fits nicely, it
may be that it by accident works.

> How about a DVD at 8x speed? (Even faster than CD at 40x)

This problem is not present with DVDs as they only support
virtual sector size == 2048.

Jörg

-- 
 EMail:joerg@schily.isdn.cs.tu-berlin.de (home) Jörg Schilling D-13353 Berlin
       js@cs.tu-berlin.de                (uni)  
       schilling@fokus.fraunhofer.de     (work) Blog: http://schily.blogspot.com/
 URL:  http://cdrecord.berlios.de/old/private/ ftp://ftp.berlios.de/pub/schily
