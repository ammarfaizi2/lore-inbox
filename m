Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272885AbRIGWce>; Fri, 7 Sep 2001 18:32:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272877AbRIGWcY>; Fri, 7 Sep 2001 18:32:24 -0400
Received: from aslan.scsiguy.com ([63.229.232.106]:25863 "EHLO
	aslan.scsiguy.com") by vger.kernel.org with ESMTP
	id <S272876AbRIGWcQ>; Fri, 7 Sep 2001 18:32:16 -0400
Message-Id: <200109072232.f87MWWY92133@aslan.scsiguy.com>
To: Olaf Zaplinski <olaf.zaplinski@web.de>
cc: linux-kernel@vger.kernel.org
Subject: Re: AIC + RAID1 error? (was: Re: aic7xxx errors) 
In-Reply-To: Your message of "Fri, 07 Sep 2001 22:32:04 +0200."
             <3B992EC4.ED1F82CB@web.de> 
Date: Fri, 07 Sep 2001 16:32:32 -0600
From: "Justin T. Gibbs" <gibbs@scsiguy.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>Okay, I had it again today:

You need to be running with aic7xxx=verbose for these messages to be
useful.  In the 6.2.2 driver release I've turned these messages on
by default.

>Kernel was 2.4.9ac9 with (new) AIC driver 6.2.1, compiled with "Maximum
>Number of TCQ Commands per Device" set to 64.

This is 8 times the tag load the old driver defaults to.

>So I compiled the same kernel with the old AIC driver, and it works fine.

Which may be due to a lighter load on the drive.  Its hard to say without
the verbose messages and the full dmesg for the machine.  You're IBM drive
may be running the "if I miss a seek, I fall off the bus" firmware where
the bug is only triggered under high load.  Send the dmesg output and we'll
see.

>I just guess when
>saying that it seems to me that the driver developers were focused on
>up-to-date cards but not the older ones.

This isn't true.

--
Justin
