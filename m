Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261472AbVASUAr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261472AbVASUAr (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Jan 2005 15:00:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261706AbVASUAq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Jan 2005 15:00:46 -0500
Received: from prgy-npn1.prodigy.com ([207.115.54.37]:30595 "EHLO
	oddball.prodigy.com") by vger.kernel.org with ESMTP id S261472AbVASUAh
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Jan 2005 15:00:37 -0500
Message-ID: <41EEBCCA.1040606@tmr.com>
Date: Wed, 19 Jan 2005 15:02:18 -0500
From: Bill Davidsen <davidsen@tmr.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040913
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@osdl.org>
CC: Dave Jones <davej@redhat.com>, Andrew Morton <akpm@osdl.org>,
       marcelo.tosatti@cyclades.com, Greg KH <greg@kroah.com>, chrisw@osdl.org,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: thoughts on kernel security issues
References: <20050113033542.GC1212@redhat.com><20050112094807.K24171@build.pdx.osdl.net> <Pine.LNX.4.58.0501122025140.2310@ppc970.osdl.org>
In-Reply-To: <Pine.LNX.4.58.0501122025140.2310@ppc970.osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:
> 
> On Wed, 12 Jan 2005, Dave Jones wrote:
> 
>>For us thankfully, exec-shield has trapped quite a few remotely
>>exploitable holes, preventing the above.
> 
> 
> One thing worth considering, but may be abit _too_ draconian, is a
> capability that says "can execute ELF binaries that you can write to".
> 
> Without that capability set, you can only execute binaries that you cannot
> write to, and that you cannot _get_ write permission to (ie you can't be
> the owner of them either - possibly only binaries where the owner is
> root).

How would you map that to interpreted languages? Bash may not be an 
issue (in general), but perl, java, SQL, etc, would be. People other 
than software developers do write in some of those.

> I realize people disagree with me, which is also why I don't in any way
> take vendor-sec as a personal affront or anything like that: I just think
> it's a mistake, and am very happy to be vocal about it, but hey, the
> fundamental strength of open source is exactly the fact that people don't
> have to agree about everything.

That's true, but in practice an administrator who disagrees with a 
developer gets to maintain their own application or O/S, and most users 
have no recourse but to go to another O/S or app. Which makes it far 
more practical to explain a point than to storm off and do it yourself 
and have to maintain it forever.

-- 
    -bill davidsen (davidsen@tmr.com)
"The secret to procrastination is to put things off until the
  last possible moment - but no longer"  -me
