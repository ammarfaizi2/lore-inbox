Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292284AbSBTU1P>; Wed, 20 Feb 2002 15:27:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292282AbSBTU0y>; Wed, 20 Feb 2002 15:26:54 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:59911 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S292281AbSBTU0j>;
	Wed, 20 Feb 2002 15:26:39 -0500
Message-ID: <3C74067C.EE824444@mandrakesoft.com>
Date: Wed, 20 Feb 2002 15:26:36 -0500
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.17-2mdksmp i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Ed Tomlinson <tomlins@cam.org>
CC: Larry McVoy <lm@bitmover.com>, Rik van Riel <riel@conectiva.com.br>,
        Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [PATCH] struct page, new bk tree
In-Reply-To: <Pine.LNX.4.33L.0202192044140.7820-100000@imladris.surriel.com> <20020219155706.H26350@work.bitmover.com> <20020220201716.45A574E2E@oscar.casa.dyndns.org>
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ed Tomlinson wrote:
> 
> In my opinion the idea of cset -x (while usefull) is fundamentally
> broken.  The result of this is that ideas like blacklist need to be
> considered.  I would propose instead an undo -x, that would
> generate a cset to reverse the one following the -x.  This might
> lead to conflicts - these would be resolved the normal bk fashion.
> If bk handled ¯bad¯ csets in this manner there would be no need for
> blacklists - it is more robust in that you can always used undo -x.

Well, if the changes are properly split up, you shouldn't need to do
this...  In the ideal situation it is easiest for Linus to accept or
reject a "bk pull" in its entirety.  Then he can just do a "bk unpull"

	Jeff



-- 
Jeff Garzik      | "Why is it that attractive girls like you
Building 1024    |  always seem to have a boyfriend?"
MandrakeSoft     | "Because I'm a nympho that owns a brewery?"
                 |             - BBC TV show "Coupling"
