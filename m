Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317892AbSHHTRF>; Thu, 8 Aug 2002 15:17:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317904AbSHHTRF>; Thu, 8 Aug 2002 15:17:05 -0400
Received: from zeus.kernel.org ([204.152.189.113]:60618 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id <S317892AbSHHTRE>;
	Thu, 8 Aug 2002 15:17:04 -0400
Date: Thu, 8 Aug 2002 16:15:31 -0300 (BRT)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: riel@duckman.distro.conectiva
To: Hubertus Franke <frankeh@us.ibm.com>
Cc: Andries Brouwer <aebr@win.tue.nl>, Andrew Morton <akpm@zip.com.au>,
       <andrea@suse.de>, <davej@suse.de>, lkml <linux-kernel@vger.kernel.org>,
       Paul Larson <plars@austin.ibm.com>,
       Linus Torvalds <torvalds@transmeta.com>
Subject: Re: [PATCH] Linux-2.5 fix/improve get_pid()
In-Reply-To: <OF107F9BDE.0B57DFBC-ON85256C0F.00669FD0-85256C0F.00681292@us.ibm.com>
Message-ID: <Pine.LNX.4.44L.0208081613430.2589-100000@duckman.distro.conectiva>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 8 Aug 2002, Hubertus Franke wrote:

> Which one sounds like the best one ?
>
> Assuming that for now we have to stick to 16-bit pid_t ....

That assumption is pretty central to the debate.

I don't see the standard get_pid nor the bitmap based
get_pid scale to something larger than a 16-bit pid_t.

If we're not sure yet whether we want to keep pid_t 16
bits it might be worth putting in an algorithm that does
scale to larger numbers, if only so the switch to a larger
pid_t will be more straightforward.

kind regards,

Rik
-- 
	http://www.linuxsymposium.org/2002/
"You're one of those condescending OLS attendants"
"Here's a nickle kid.  Go buy yourself a real t-shirt"

http://www.surriel.com/		http://distro.conectiva.com/

