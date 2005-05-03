Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261655AbVECT4k@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261655AbVECT4k (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 May 2005 15:56:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261657AbVECT40
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 May 2005 15:56:26 -0400
Received: from prgy-npn1.prodigy.com ([207.115.54.37]:11150 "EHLO
	oddball.prodigy.com") by vger.kernel.org with ESMTP id S261655AbVECTzk
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 May 2005 15:55:40 -0400
Message-ID: <4277B84C.8030808@tmr.com>
Date: Tue, 03 May 2005 13:43:40 -0400
From: Bill Davidsen <davidsen@tmr.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.6) Gecko/20050319
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@osdl.org>
CC: Andrea Arcangeli <andrea@suse.de>, Matt Mackall <mpm@selenic.com>,
       linux-kernel <linux-kernel@vger.kernel.org>, git@vger.kernel.org
Subject: Re: Mercurial 0.4b vs git patchbomb benchmark
References: <42764C0C.8030604@tmr.com><20050429203959.GC21897@waste.org> <Pine.LNX.4.58.0505020921080.3594@ppc970.osdl.org>
In-Reply-To: <Pine.LNX.4.58.0505020921080.3594@ppc970.osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:
> 
> On Mon, 2 May 2005, Bill Davidsen wrote:
> 
>>>-#!/usr/bin/python
>>>+#!/usr/bin/env python
> 
> 
>>Could you explain why this is necessary or desirable? I looked at what 
>>env does, and I am missing the point of duplicating bash normal 
>>behaviour regarding definition of per-process environment entries.
> 
> 
> It's not about environment.
> 
> It's about the fact that many people have things like python in
> /usr/local/bin/python, because they compiled it themselves or similar.
> 
> Pretty much the only path you can _really_ depend on for #! stuff is 
> /bin/sh.
> 
> Any system that doesn't have /bin/sh is so fucked up that it's not worth
> worrying about. Anything else can be in /bin, /usr/bin or /usr/local/bin
> (and sometimes other strange places).
> 
> That said, I think the /usr/bin/env trick is stupid too. It may be more 
> portable for various Linux distributions, but if you want _true_ 
> portability, you use /bin/sh, and you do something like
> 
> 	#!/bin/sh
> 	exec perl perlscript.pl "$@"
> 
> instead.
> 		Linus
> 
And that eliminates the need for having /usr/bin/env in the "expected" 
place. I like it.

Wish there was a way to specify "use path" without all this workaround.

-- 
    -bill davidsen (davidsen@tmr.com)
"The secret to procrastination is to put things off until the
  last possible moment - but no longer"  -me

