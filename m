Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271730AbRHQWFo>; Fri, 17 Aug 2001 18:05:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271728AbRHQWFj>; Fri, 17 Aug 2001 18:05:39 -0400
Received: from mail.webmaster.com ([216.152.64.131]:28883 "EHLO
	shell.webmaster.com") by vger.kernel.org with ESMTP
	id <S271733AbRHQWF1>; Fri, 17 Aug 2001 18:05:27 -0400
From: "David Schwartz" <davids@webmaster.com>
To: "Theodore Tso" <tytso@mit.edu>, "Andreas Dilger" <adilger@turbolinux.com>
Cc: <linux-kernel@vger.kernel.org>
Subject: RE: /dev/random in 2.4.6
Date: Fri, 17 Aug 2001 15:05:39 -0700
Message-ID: <NOEJJDACGOHCKNCOGFOMKEFFDEAA.davids@webmaster.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2911.0)
Importance: Normal
In-Reply-To: <20010817171834.A24850@thunk.org>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2479.0006
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> That's not the only attack, actually.  The much simpler attack pathis
> for an attack to **observe** the network traffic to such a precise
> extent as to be able to guess what the entropy numbers are that are
> going into the pool.  (Think: FBI's Carnivore).
>
> The one saving grace here is that in order to really do this well, the
> attacker would need to be sitting on the local area network to get the
> best and most precise timing numbers.  You can argue that this is
> still a theoretical attack; but it's not quite so difficult as saying
> that the attacker has to "control" the network traffic.
>
> 						- Ted

	This is a non-issue providing the entropy pool code correctly estimates the
amount of entropy. The Linux entropy code is written so that there is no
harm from putting fully known or partially known numbers into the pool
provided that the pool does not overestimate the amount of entropy in those
numbers.

	Even if you could perfectly time the packets on the LAN, you still could
not tell the clock skew between the clock on the LAN card and the TSC. There
would still be unknowns involving how long it would take for the interrupt
to be acknowledged and the entropy gathering code to get to the CPU. These
unknowns still contain real entropy that there is no known way an attacker
could know.

	DS

