Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267930AbRGRViB>; Wed, 18 Jul 2001 17:38:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267936AbRGRVhv>; Wed, 18 Jul 2001 17:37:51 -0400
Received: from garrincha.netbank.com.br ([200.203.199.88]:59408 "HELO
	netbank.com.br") by vger.kernel.org with SMTP id <S267930AbRGRVhh>;
	Wed, 18 Jul 2001 17:37:37 -0400
Date: Wed, 18 Jul 2001 18:37:35 -0300 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: <riel@imladris.rielhome.conectiva>
To: Marcelo Tosatti <marcelo@conectiva.com.br>
Cc: Linus Torvalds <torvalds@transmeta.com>,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: Inclusion of zoned inactive/free shortage patch 
In-Reply-To: <Pine.LNX.4.21.0107181648240.8651-100000@freak.distro.conectiva>
Message-ID: <Pine.LNX.4.33L.0107181830260.20071-100000@imladris.rielhome.conectiva>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 18 Jul 2001, Marcelo Tosatti wrote:

> Even if I did not had the stats, its senseless to free/deactivate pages
> from zones which do not need to.
>
> The old behaviour was fundamentally broken.

Both behaviours are fundamentally broken. On the one hand
we WILL want to deactivate the least used pages so for
GFP_HIGHUSER allocations we know which zone to allocate
from.

On the other hand we want to avoid work in the pageout
code when it isn't needed.

regards,

Rik
--
Virtual memory is like a game you can't win;
However, without VM there's truly nothing to lose...

http://www.surriel.com/		http://distro.conectiva.com/

Send all your spam to aardvark@nl.linux.org (spam digging piggy)

