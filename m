Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270647AbTHJUWs (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 10 Aug 2003 16:22:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270650AbTHJUWr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Aug 2003 16:22:47 -0400
Received: from hera.cwi.nl ([192.16.191.8]:18637 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id S270647AbTHJUWp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Aug 2003 16:22:45 -0400
From: Andries.Brouwer@cwi.nl
Date: Sun, 10 Aug 2003 22:22:28 +0200 (MEST)
Message-Id: <UTC200308102022.h7AKMSI02375.aeb@smtp.cwi.nl>
To: Andries.Brouwer@cwi.nl, fgrum@free.fr
Subject: Re: Apacer SM/CF combo reader driver
Cc: linux-kernel@vger.kernel.org, linux-usb-devel@lists.sourceforge.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    I've got an Apacer SM/CF combo reader too. I found your email :
            
            I just got myself an Apacer SM/CF combo reader, USB 07c4:a109. 
            The CF part is supported in the stock kernel (by datafab.c), 
            the SM part is not. 
            This evening I wrote a read-only driver; hope to add the 
            writing part soon. 
            
            Andries

    Does your driver work well ?

Yes, it reads and writes without problems, both CF and SM,
assuming the surrounding kernel works.

    Is it in the stock kernel now ? If not, is it possible to get it?

Now the question arises what you mean by "stock kernel".

2.6.0-test3 is still in a sorry state.
I cannot insmod usb-storage.o for a vanilla 2.6.0-test3.
It hangs. (Have not checked yet whether this is a permanent hang
or one of these scsi_eh_X that spend hours resetting the bus and
trying again. I booted 33 min ago and it still hangs.)

I have not tried 2.4 recently, but that is supposedly stable.

If you need the CF half, you need no help from me, you must "just"
find some kernel where usb-storage and usb and scsi all work.
Maybe a recent 2.4 would do.

If you need the SM half, ask me again.


Andries



[Long ago I made some general common infrastructure for SM readers.
In May 2002 someone asked me for this stuff and I put something at
ftp://ftp.kernel.org/pub/linux/kernel/people/aeb/usb-storage.tar.gz
Don't recall precisely what this is, or to what kernel it belonged,
in view of the date it may have been 2.5.13 or 2.5.14. But I see
there is an apacer.c, and the source looks healthy at first sight.]
