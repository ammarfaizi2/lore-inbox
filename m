Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293680AbSGMNIA>; Sat, 13 Jul 2002 09:08:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311710AbSGMNH7>; Sat, 13 Jul 2002 09:07:59 -0400
Received: from as3-1-8.ras.s.bonet.se ([217.215.75.181]:20356 "EHLO
	garbo.kenjo.org") by vger.kernel.org with ESMTP id <S293680AbSGMNH6>;
	Sat, 13 Jul 2002 09:07:58 -0400
Subject: Re: PATCH: compile the kernel with -Werror
From: Kenneth Johansson <ken@kenjo.org>
To: Muli Ben-Yehuda <mulix@actcom.co.il>
Cc: Linus Torvalds <torvalds@transmeta.com>,
       William Lee Irwin III <wli@holomorphy.com>,
       linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <20020713102615.H739@alhambra.actcom.co.il>
References: <20020713102615.H739@alhambra.actcom.co.il>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.7 
Date: 13 Jul 2002 15:10:20 +0200
Message-Id: <1026565820.13069.5.camel@tiger>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2002-07-13 at 09:26, Muli Ben-Yehuda wrote:
> A full kernel compilation, especially when using the -j switch to
> make, can cause warnings to "fly off the screen" without the user
> noticing them. For example, wli's patch lazy_buddy.2.5.25-1 of today
> had a missing return statement in a function returning non void, which
> the compiler probably complained about but the warning got lost in the
> noise (a little birdie told me wli used -j64). 

use 

make -j64 KBUILD_VERBOSE=0

This is similar to what kbuils2.5 dose by default but since the in
kernel version do not have one single makefile the output gets a bit
reshuffled.

But -j64 dose seem a but hi I usually use the same as numbers of cpu.
over nfs I go a little higher.



