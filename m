Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264471AbTF3HjO (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Jun 2003 03:39:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263918AbTF3HjO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Jun 2003 03:39:14 -0400
Received: from mail.gmx.de ([213.165.64.20]:15281 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S265079AbTF3Hi6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Jun 2003 03:38:58 -0400
Message-Id: <5.2.0.9.2.20030630094946.00cfb000@pop.gmx.net>
X-Mailer: QUALCOMM Windows Eudora Version 5.2.0.9
Date: Mon, 30 Jun 2003 09:57:35 +0200
To: Con Kolivas <kernel@kolivas.org>
From: Mike Galbraith <efault@gmx.de>
Subject: Re: patch-O1int-0306281420 for 2.5.73 interactivity
Cc: linux-kernel@vger.kernel.org,
       Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>,
       Zwane Mwaikambo <zwane@linuxpower.ca>
In-Reply-To: <200306301535.49732.kernel@kolivas.org>
References: <200306291457.40524.kernel@kolivas.org>
 <200306281516.12975.kernel@kolivas.org>
 <200306291132.49068.kernel@kolivas.org>
 <200306291457.40524.kernel@kolivas.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greetings,

At 03:35 PM 6/30/2003 +1000, Con Kolivas wrote:
>Summary:
>A patch to reduce audio skipping and X jerking under load.

I took it out for a quick spin.  It kills thud graveyard dead.  That's the 
good news, now for the bad ;-)  With a make -j5 running, kasteroids 
stutters enough to be pretty annoying.  The patched kernel is making 
booboos wrt cc1's priority often enough to nail kasteroids pretty 
hard.  The mouse pointer also jerks around quite a bit,...

>It's looking seriously like I'm talking to myelf here, but just in case there
>are lurkers testing this patch, there's a big bug that made it think jiffy
>wraparound was occurring so interactive tasks weren't receiving the boost
>they deserved. Here is a patch with the fix in.
>
>How to use if you're still thinking of testing:
>Use with Hz 1000, and use the granularity patch I posted as well for 
>smoothing
>X off.

...but I'm not using that, because I wanted to see the pure effects of this 
patch.

         -Mike

