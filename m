Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266793AbUJNSkT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266793AbUJNSkT (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Oct 2004 14:40:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267263AbUJNSai
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Oct 2004 14:30:38 -0400
Received: from uucp.cistron.nl ([62.216.30.38]:51604 "EHLO ncc1701.cistron.net")
	by vger.kernel.org with ESMTP id S266878AbUJNRno (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Oct 2004 13:43:44 -0400
From: "Miquel van Smoorenburg" <miquels@cistron.nl>
Subject: Re: [patch] Real-Time Preemption, -VP-2.6.9-rc4-mm1-U0
Date: Thu, 14 Oct 2004 17:43:43 +0000 (UTC)
Organization: Cistron Group
Message-ID: <ckmdsf$j3f$1@news.cistron.nl>
References: <OF29AF5CB7.227D041F-ON86256F2A.0062D210@raytheon.com> <20041014002433.GA19399@elte.hu> <20041014105711.654efc56@mango.fruits.de> <20041014091953.GA21635@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Trace: ncc1701.cistron.net 1097775823 19567 62.216.29.200 (14 Oct 2004 17:43:43 GMT)
X-Complaints-To: abuse@cistron.nl
X-Newsreader: trn 4.0-test76 (Apr 2, 2001)
Originator: miquels@cistron-office.nl (Miquel van Smoorenburg)
To: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <20041014091953.GA21635@elte.hu>,
Ingo Molnar  <mingo@elte.hu> wrote:
>In -U0 this is not possible because 'ps -C' does not handle kernel
>threads with a space in their name. So there you'd need some wacky thing
>like:
>
>   chrt -f 60 -p `ps ax -o pid= -o comm= | grep "IRQ 1$" | cut -dI -f1`
>   chrt -f 60 -p `ps ax -o pid= -o comm= | grep "IRQ 8$" | cut -dI -f1`
>
>(someone should fix procps - or does it intentionally break with
>whitespace command-strings?)

Why not use ` pgrep -x 'IRQ 1' `. It's part of procps (at least
the version debian, even woody, is using), some kind of standard
(solaris has it too), and works.

Mike.
-- 
"In times of universal deceit, telling the truth becomes
 a revolutionary act." -- George Orwell.

