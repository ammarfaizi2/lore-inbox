Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266897AbTGHGwV (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Jul 2003 02:52:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266899AbTGHGwV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Jul 2003 02:52:21 -0400
Received: from routeree.utt.ro ([193.226.8.102]:37326 "EHLO klesk.etc.utt.ro")
	by vger.kernel.org with ESMTP id S266897AbTGHGvx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Jul 2003 02:51:53 -0400
Message-ID: <26071.194.138.39.55.1057648284.squirrel@webmail.etc.utt.ro>
Date: Tue, 8 Jul 2003 10:11:24 +0300 (EEST)
Subject: Re: [PATCH] O3int interactivity for 2.5.74-mm2
From: "Szonyi Calin" <sony@etc.utt.ro>
To: <kernel@kolivas.org>
In-Reply-To: <200307071319.57511.kernel@kolivas.org>
References: <200307070317.11246.kernel@kolivas.org>
        <1057516609.818.4.camel@teapot.felipe-alfaro.com>
        <200307071319.57511.kernel@kolivas.org>
X-Priority: 3
Importance: Normal
Cc: <linux-kernel@vger.kernel.org>, <akpm@osdl.org>
X-Mailer: SquirrelMail (version 1.2.8)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-MailScanner: Not scanned: please contact your Internet E-Mail Service Provider for details
X-MailScanner-Information: Please contact the ISP for more information
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Con Kolivas said:
>
> Thanks to Felipe who picked this up I was able to find the one bug
> causing me  grief. The idle detection code was allowing the sleep_avg to
> get to  ridiculously high levels. This is corrected in the following
> replacement  O3int patch. Note this fixes the mozilla issue too. Kick
> arse!!
>
> Con

Not really.
No change on my system.
No fancy gui (just fvwm). Testing is very simple:
In one xterm window make bzImage
in other mplayer /some/movie.avi
... and the movie is jerky :-(

In the weekend i did some experiments with the defines in kernel/sched.c
It seems that changing in MAX_TIMESLICE the "200" to "100" or even "50"
helps a little bit. (i was able to do a make bzImage and watch a movie
without noticing that is a kernel compile in background)

system is AMD DURON chipset via KT/KM 133, Ati Radeon VE.

I remeber with nostalgicaly about the times when i could (with a 2.5
kernel) do a make -j 5 bzImage AND watch a movie in the same time

-- 
# fortune
fortune: write error on /dev/null -- please empty the bit bucket


-----------------------------------------
This email was sent using SquirrelMail.
   "Webmail for nuts!"
http://squirrelmail.org/


