Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262945AbUKRU3w@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262945AbUKRU3w (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Nov 2004 15:29:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262939AbUKRTmK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Nov 2004 14:42:10 -0500
Received: from mail.euroweb.hu ([193.226.220.4]:4749 "HELO mail.euroweb.hu")
	by vger.kernel.org with SMTP id S262922AbUKRTd7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Nov 2004 14:33:59 -0500
To: torvalds@osdl.org
CC: miklos@szeredi.hu, hbryan@us.ibm.com, akpm@osdl.org,
       linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
       pavel@ucw.cz
In-reply-to: <Pine.LNX.4.58.0411181108140.2222@ppc970.osdl.org> (message from
	Linus Torvalds on Thu, 18 Nov 2004 11:16:31 -0800 (PST))
Subject: Re: [PATCH] [Request for inclusion] Filesystem in Userspace
References: <OF28252066.81A6726A-ON88256F50.005D917A-88256F50.005EA7D9@us.ibm.com>
 <E1CUq57-00043P-00@dorka.pomaz.szeredi.hu> <Pine.LNX.4.58.0411180959450.2222@ppc970.osdl.org>
 <E1CUquZ-0004Az-00@dorka.pomaz.szeredi.hu> <Pine.LNX.4.58.0411181027070.2222@ppc970.osdl.org>
 <E1CUrS0-0004Hi-00@dorka.pomaz.szeredi.hu> <Pine.LNX.4.58.0411181108140.2222@ppc970.osdl.org>
Message-Id: <E1CUs2R-0004Nr-00@dorka.pomaz.szeredi.hu>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Thu, 18 Nov 2004 20:33:51 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Ehh - the _CPU_ handles dirtying pages all on its own. The OS never even 
> knows that a page got dirtied, so "starting writeout early" is not much of 
> an option.

OK, sorry.  I'd rephrase it then to say will the system allow _all_
it's pages to be used for file data?

> IOW, from a merging standpoint, simple really _is_ better. Even if you
> really really want to use exotic features like "direct IO" and writable
> mappings some day, let's just put it this way: it's a lot easier to merge
> something that has no questions about strange cases, and then _later_ add
> in the strange cases, than it is to merge it all on day #1.

OK, I see your point.  And yes, I know writable mappings are rare.

> I'm a sucker. Ask anybody. I'll accept the exact same patch that I
> rejected earlier if you just do it the right way. I'm convinced that some
> people actually do it on purpose just for the amusement value ("Look, he
> did it _again_. What a doofus!")

Actually I did plan to split up FUSE the next time I submit it, so
these extra features can be taken on their own merrit.

Thanks,
Miklos
