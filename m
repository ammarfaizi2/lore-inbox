Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270814AbRIARB0>; Sat, 1 Sep 2001 13:01:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270818AbRIARBP>; Sat, 1 Sep 2001 13:01:15 -0400
Received: from scispor.dolphinics.no ([193.71.152.117]:39184 "EHLO
	scispor.dolphinics.no") by vger.kernel.org with ESMTP
	id <S270814AbRIARBI> convert rfc822-to-8bit; Sat, 1 Sep 2001 13:01:08 -0400
Message-ID: <200109011905240984.24422290@scispor.dolphinics.no>
In-Reply-To: <200109011619480531.23AA844A@scispor.dolphinics.no>
In-Reply-To: <200109011619480531.23AA844A@scispor.dolphinics.no>
X-Mailer: Calypso Version 3.00.03.02 (1)
Date: Sat, 01 Sep 2001 19:05:24 +0200
From: "Simen Thoresen" <simen-tt@online.no>
To: "alan" <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Status of the VIA KT133a and 2.4.x debacle?
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>Alan, list, et all,
>
I've now realised that this discussion is ongoing, and would just like to chip in with my newer results.

<znip>

>I have not determined if it is static void fast_clear_page(void *page), or  static void fast_copy_page(void *to, void >*from) which is to blame here, but I will continue investigating.
>

I've determined that with the Athlon-optimized fast_copy_page, the machine is easy to push into oopsing. Just starting a dd with blocksize 128M (half available ram) provokes an oops. This is repeatable, consistent and almost fun.

With the Athlon-optimized fast_clear_page, tho, the machine seems stable. I can start the above dd, and two more like it (eating some 128MB into swap as well), and then start using the machine.

It's now been churning away like that for half an hour, and I've never had to wait that long for an oops.

How much is gained using the Athlon-optimized fast_copy_page over the normal fast_copy_page?

Yours,
-S
--
Simen Thoresen, Beowulf-cleaner and random artist - close and personal.

Er det ikke rart?
The gnu RART-project on http://valinor.dolphinics.no:1080/~simentt/rart


