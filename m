Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932471AbWGMMT3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932471AbWGMMT3 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Jul 2006 08:19:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932507AbWGMMT3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Jul 2006 08:19:29 -0400
Received: from aun.it.uu.se ([130.238.12.36]:25035 "EHLO aun.it.uu.se")
	by vger.kernel.org with ESMTP id S932471AbWGMMT2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Jul 2006 08:19:28 -0400
Date: Thu, 13 Jul 2006 14:19:05 +0200 (MEST)
Message-Id: <200607131219.k6DCJ5tK025788@harpo.it.uu.se>
From: Mikael Pettersson <mikpe@it.uu.se>
To: johnstul@us.ibm.com, linux-kernel@vger.kernel.org
Subject: Re: [RFC][PATCH] Kill i386 references to xtime
Cc: mikpe@it.uu.se, mingo@elte.hu, tglx@linutronix.de, zippel@linux-m68k.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 12 Jul 2006 17:29:57 -0700, john stultz wrote:
>This patch kills all xtime references in i386 and replaces them with
>proper settimeofday()/gettimeofday() calls.
>
>I'm not sure the APM changes are 100% right, as that code is very
>muddled (take the i8253_lock before calling reinit_timer, which would
>take the i8253_lock again and hang if it weren't ifdef'ed out!).
>
>Anyway, testing, feedback or comments would be appreciated!

Tested full APM suspend/resume cycle on my Latitude,
with no observable ill effects.

Acked-by: Mikael Pettersson <mikpe@it.uu.se>
