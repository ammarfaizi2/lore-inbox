Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318878AbSIIUcs>; Mon, 9 Sep 2002 16:32:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318891AbSIIUcs>; Mon, 9 Sep 2002 16:32:48 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:50182 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S318888AbSIIUcr>; Mon, 9 Sep 2002 16:32:47 -0400
Date: Mon, 9 Sep 2002 13:40:53 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Ingo Molnar <mingo@elte.hu>
cc: Daniel Jacobowitz <dan@debian.org>, <linux-kernel@vger.kernel.org>
Subject: Re: do_syslog/__down_trylock lockup in current BK
In-Reply-To: <Pine.LNX.4.44.0209092230550.16779-100000@localhost.localdomain>
Message-ID: <Pine.LNX.4.33.0209091338330.1747-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 9 Sep 2002, Ingo Molnar wrote:
>
> the lockup is likely in the while loop - ie. zap_thread() not actually
> reparenting a thread and thus causing an infinite loop - is that possible?

Hmm.. This patch changes the last argument of zap_thread() from a "1" to a
"0" for the ptrace_children list. Was that intentional or a cut-and-paste 
error? If it was intentional, please remove the argument altogether, since 
it's now always 0.

		Linus

