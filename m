Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261179AbTIOK6e (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Sep 2003 06:58:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261245AbTIOK6e
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Sep 2003 06:58:34 -0400
Received: from shark.pro-futura.com ([161.58.178.219]:54196 "EHLO
	shark.pro-futura.com") by vger.kernel.org with ESMTP
	id S261179AbTIOK6c (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Sep 2003 06:58:32 -0400
From: "Tvrtko A. =?utf-8?q?Ur=C5=A1ulin?=" <tvrtko@croadria.com>
To: Rusty Lynch <rusty@linux.co.intel.com>
Subject: Re: [RFC] Enabling other oom schemes
Date: Mon, 15 Sep 2003 12:59:52 +0200
User-Agent: KMail/1.5.1
Cc: linux-kernel@vger.kernel.org
References: <200309120219.h8C2JANc004514@penguin.co.intel.com> <200309121058.54691.tvrtko@croadria.com> <1063419669.9766.2.camel@vmhack>
In-Reply-To: <1063419669.9766.2.camel@vmhack>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200309151259.52778.tvrtko@croadria.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hello Rusty,

> I went ahead and added a new oom handler that is a combination of
> the original oom_kill.c combined with the changes from Tvrtko's patch
> (originally written for 2.4.20) that kills off parents that keep producing
> bad children.  It sounds a little right wing, but it works :->

Wow, great! I will try this as soon as I setup one extra machine for 2.6.0 
testing.

Regarding "right wing", well... you could say that. But it was usefull for one 
situation where one version of mysql (don't remeber which) used to go crazy. 
It was creating many childs what caused to load to go 250+ . Just to log in 
to that machine with ssh took more than 15minutes, and what then? Restart 
mysql. And the idea for this kind of oom killer was born. :) In more abstract 
words; we had a situation where user space app was causing server downtime 
(in a way). We have corrected it with an oom killer algorithm which reduces 
that downtime. 

I even posted it to LKML some time ago but received no comments.

I think that users should have choices, that is why your approach is so nice. 
Following those same lines, I don't understand why we should remove those 
choices from them/ourselves (like removing oom killer from 2.4 - why not make 
it a kconfig option instead?).

I really hope your modular approach gets into Linus tree!

Best regards,
Tvrtko A. Ursulin

