Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129602AbQKHTxR>; Wed, 8 Nov 2000 14:53:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129601AbQKHTxI>; Wed, 8 Nov 2000 14:53:08 -0500
Received: from asterix.hrz.tu-chemnitz.de ([134.109.132.84]:18858 "EHLO
	asterix.hrz.tu-chemnitz.de") by vger.kernel.org with ESMTP
	id <S129582AbQKHTw6>; Wed, 8 Nov 2000 14:52:58 -0500
Date: Wed, 8 Nov 2000 21:52:38 +0100
From: Ingo Oeser <ingo.oeser@informatik.tu-chemnitz.de>
To: Mikulas Patocka <mikulas@artax.karlin.mff.cuni.cz>
Cc: Rik van Riel <riel@conectiva.com.br>,
        Szabolcs Szakacsits <szaka@f-secure.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Linus Torvalds <torvalds@transmeta.com>,
        Ingo Molnar <mingo@elte.hu>
Subject: Re: Looking for better VM
Message-ID: <20001108215238.C947@nightmaster.csn.tu-chemnitz.de>
In-Reply-To: <Pine.LNX.4.05.10011081450320.3666-100000@humbolt.nl.linux.org> <Pine.LNX.3.96.1001108172338.7153A-100000@artax.karlin.mff.cuni.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2i
In-Reply-To: <Pine.LNX.3.96.1001108172338.7153A-100000@artax.karlin.mff.cuni.cz>; from mikulas@artax.karlin.mff.cuni.cz on Wed, Nov 08, 2000 at 05:36:40PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 08, 2000 at 05:36:40PM +0100, Mikulas Patocka wrote:
> BTW. Why does your OOM killer in 2.4 try to kill process that mmaped most
> memory? mmap is hamrless. mmap on files can't eat memory and swap.

Don't complain, build your own and test it ;-)

Apply my patch

http://www.tu-chemnitz.de/~ioe/oom_kill_api.patch

and install your own OOM handler using install_oom_killer() 
from <linux/swap.h>. It has all the needed documentation inline
that will be build along the kernel-api-book.

Have fun researching in this area.

PS: Applies cleanly since oom_kill.c exists and also against
   2.4.0-test11-pre1.

Regards

Ingo Oeser
-- 
To the systems programmer, users and applications
serve only to provide a test load.
<esc>:x
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
