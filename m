Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266983AbRGYP2y>; Wed, 25 Jul 2001 11:28:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266989AbRGYP2p>; Wed, 25 Jul 2001 11:28:45 -0400
Received: from mail.phpoint.net ([212.63.10.62]:59882 "EHLO smtp2.koti.soon.fi")
	by vger.kernel.org with ESMTP id <S266983AbRGYP2c>;
	Wed, 25 Jul 2001 11:28:32 -0400
From: "M. Tavasti" <tawz@nic.fi>
To: root@chaos.analogic.com
Cc: Ben Greear <greearb@candelatech.com>, linux-kernel@vger.kernel.org
Subject: Re: Select with device and stdin not working
In-Reply-To: <Pine.LNX.3.95.1010725110441.1108A-100000@chaos.analogic.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit
Date: 25 Jul 2001 18:27:14 +0300
In-Reply-To: "Richard B. Johnson"'s message of "Wed, 25 Jul 2001 11:07:04 -0400 (EDT)"
Message-ID: <m2g0blkp0t.fsf@akvavitix.vuovasti.com>
X-Mailer: Gnus v5.6.45/XEmacs 21.1 - "Capitol Reef"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

"Richard B. Johnson" <root@chaos.analogic.com> writes:

> Change: 
>                  } else if(FD_ISSET(fileno(stdin),&rfds) ) {
> To:
>                  } if(FD_ISSET(fileno(stdin),&rfds) ) {
> 
> Both of these bits can be (probably are) set.

You are third person to suggest that. Yes, it's good point, but
doesn't make any difference. Or it makes when both device and stdin
have something, stdin is read on second round. 

But now there is nothing coming from device, and typing + pressing
enter won't make select() return like it should. 

Same binary works fine with 2.0.X kernels, or if I'm having stdin
+ pipe (named or unnamed, doesn't matter). And when trying with 2.0
kernel, system was totally same except kernel version. 

Anybody, can you get select working *properly* with stdin+/dev/random?
If you can, then there must be some mistake on my code. 

-- 
M. Tavasti /  tavastixx@iki.fi  /   +358-40-5078254
 Poista sähköpostiosoitteesta molemmat x-kirjaimet 
     Remove x-letters from my e-mail address
