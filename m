Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261598AbSIXHXC>; Tue, 24 Sep 2002 03:23:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261599AbSIXHXB>; Tue, 24 Sep 2002 03:23:01 -0400
Received: from dp.samba.org ([66.70.73.150]:8382 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id <S261598AbSIXHXB>;
	Tue, 24 Sep 2002 03:23:01 -0400
From: Rusty Russell <rusty@rustcorp.com.au>
To: "David S. Miller" <davem@redhat.com>
Cc: mingo@elte.hu, torvalds@transmeta.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] streq() 
In-reply-to: Your message of "Mon, 23 Sep 2002 23:24:13 MST."
             <20020923.232413.08022213.davem@redhat.com> 
Date: Tue, 24 Sep 2002 17:28:00 +1000
Message-Id: <20020924072814.CFC332C1AC@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <20020923.232413.08022213.davem@redhat.com> you write:
>    From: Rusty Russell <rusty@rustcorp.com.au>
>    Date: Tue, 24 Sep 2002 16:04:33 +1000
>    
>    For runtime checks (which are never as good) you could change the GFP_
>    defined to set the high bit.
> 
> Another idea is to make a gfp_flags_t, that worked very well
> for things like mm_segment_t.

But you can't or them together without some icky macro, unless they're
typedef to an integer type in which case gcc doesn't warn you if you
just stuck a "sizeof(x)" in there.

Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
