Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750744AbWCFG5A@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750744AbWCFG5A (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Mar 2006 01:57:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751910AbWCFG5A
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Mar 2006 01:57:00 -0500
Received: from smtp.osdl.org ([65.172.181.4]:2283 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750744AbWCFG47 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Mar 2006 01:56:59 -0500
Date: Sun, 5 Mar 2006 22:55:17 -0800
From: Andrew Morton <akpm@osdl.org>
To: "David Leimbach" <leimy2k@gmail.com>
Cc: lucho@ionkov.net, linux-kernel@vger.kernel.org,
       v9fs-developer@lists.sourceforge.net
Subject: Re: [V9fs-developer] Re: [PATCH] v9fs: print 9p messages
Message-Id: <20060305225517.20aa5f80.akpm@osdl.org>
In-Reply-To: <3e1162e60603052249o334fa0ffne9a400fd4237d25a@mail.gmail.com>
References: <20060304152513.GA24046@ionkov.net>
	<20060305223623.1deb25a4.akpm@osdl.org>
	<3e1162e60603052249o334fa0ffne9a400fd4237d25a@mail.gmail.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"David Leimbach" <leimy2k@gmail.com> wrote:
>
> > Also, those macro names:
>  >
>  > #define DEBUG_ERROR             (1<<0)
>  > #define DEBUG_CURRENT           (1<<1)
>  > #define DEBUG_9P                (1<<2)
>  > #define DEBUG_VFS               (1<<3)
>  > #define DEBUG_CONV              (1<<4)
>  > #define DEBUG_MUX               (1<<5)
>  > #define DEBUG_TRANS             (1<<6)
>  > #define DEBUG_SLABS             (1<<7)
>  > #define DEBUG_FCALL             (1<<8)
>  >
>  > are quite poorly chosen.  If someone else were to make a similarly poor
>  > naming choice there would be collisions.
> 
> 
> 
>  Would
>  #define 9P_DEBUG_ERROR
>  ...
> 
>  be better?  it seems they should be better "namespaced".

Well, "P9" would have a better chance of compiing ;)

But yes, that's how it should have been from the outset.  Whether you want
to do it now depends upon whether you want to put up with that much churn.

If you _are_ prepared to churn the code that much then it would be a good
time to think about perhaps permitting all that debug code to be omitted
for non-debug builds.  Make the various tests evaluate to constant zero if
!debug and don't include this newly-added file in non-debug builds at all.

It's all rather low-priority stuff though.
