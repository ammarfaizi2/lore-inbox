Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130425AbRBBW7W>; Fri, 2 Feb 2001 17:59:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130543AbRBBW7M>; Fri, 2 Feb 2001 17:59:12 -0500
Received: from adsl-209-182-168-213.value.net ([209.182.168.213]:29199 "EHLO
	draco.foogod.com") by vger.kernel.org with ESMTP id <S130425AbRBBW6z>;
	Fri, 2 Feb 2001 17:58:55 -0500
Date: Fri, 2 Feb 2001 14:58:14 -0800
From: alex@foogod.com
To: Hans Reiser <reiser@namesys.com>
Cc: Alan Cox <alan@redhat.com>, John Morrison <john@vmlinux.net>,
        Chris Mason <mason@suse.com>, Jan Kasprzak <kas@informatics.muni.cz>,
        linux-kernel@vger.kernel.org, reiserfs-list@namesys.com,
        "Yury Yu. Rupasov" <yura@yura.polnet.botik.ru>
Subject: Re: [reiserfs-list] Re: ReiserFS Oops (2.4.1, deterministic, symlink
Message-ID: <20010202145814.L19961@draco.foogod.com>
In-Reply-To: <200102022139.f12LdII21148@devserv.devel.redhat.com> <3A7B2E94.F52C4342@namesys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0pre3us
In-Reply-To: <3A7B2E94.F52C4342@namesys.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 03, 2001 at 01:03:00AM +0300, Hans Reiser wrote:
> My design objective in ReiserFS is not to say that it wasn't my fault they had
> that bug because they are so ignorant about a filesystem that
> really isn't very important to them unless it screws up.  My design objective is
> to ensure they don't have that bug.  They are more important than me.

The whole argument back and forth here seems to be:

Hans: It's better if it fails to compile with a clear message than compiling 
      ok and breaking horribly and unpredictably later.
Alan: It won't work and it'll generate more mail, not less.

Now, it seems to me, as long as the ReiserFS folks are going to be getting the 
bulk of the extra work(/mail/whatever) out of this, and they've been advised 
of the risks to their own person and are ok with that (which they apparently 
are), then they might as well go ahead and try it.  It's their inboxes.

The one thing I do have to say about all of this, however, is that if this 
sort of testing for compiler issues (or tool issues, or library issues or 
anything else) is going to be done as part of individual kernel components, 
there should be some way to globally configure this, so that it can be turned 
off should someone, for some reason, want (or need) to do something with an 
unsupported version of something and know what they're doing, without having 
to hunt through every line of kernel source to find the multiple places 
different developers have put in different checks for the thing they're 
trying to do.

Perhaps a "Kernel Hacking" configuration option (or just something in a 
documented .h file) for "Allow compiling with buggy GCC 2.96" which would turn 
off all such checks?

-alex
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
