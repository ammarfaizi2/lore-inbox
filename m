Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271498AbRHUDQ7>; Mon, 20 Aug 2001 23:16:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271507AbRHUDQt>; Mon, 20 Aug 2001 23:16:49 -0400
Received: from mail.webmaster.com ([216.152.64.131]:58267 "EHLO
	shell.webmaster.com") by vger.kernel.org with ESMTP
	id <S271498AbRHUDQg>; Mon, 20 Aug 2001 23:16:36 -0400
From: "David Schwartz" <davids@webmaster.com>
To: "Paul Jakma" <paul@clubi.ie>
Cc: <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] let Net Devices feed Entropy, updated (1/2)
Date: Mon, 20 Aug 2001 20:16:49 -0700
Message-ID: <NOEJJDACGOHCKNCOGFOMAEGBDFAA.davids@webmaster.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2911.0)
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2479.0006
In-Reply-To: <Pine.LNX.4.33.0108210353320.7402-100000@fogarty.jakma.org>
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> related: the i810 RNG has a driver, but it feeds data to /dev/random
> via a userspace daemon (rngd), so again entropy count is not changed.
>
> kind of shame on the only mass-market RNG hardware out there.

	Just tweak the daemon to update the entropy count correctly using the
appropriate ioctl function (RND_ADD_ENTROPY). Search drivers/chars/random.c
for random_ioctl. I've written several programs that acquire entropy from
various sources and exchange them with the kernel entropy pool. It's not
difficult at all.

	DS

