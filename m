Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261611AbSIXIYl>; Tue, 24 Sep 2002 04:24:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261612AbSIXIYl>; Tue, 24 Sep 2002 04:24:41 -0400
Received: from pizda.ninka.net ([216.101.162.242]:24512 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S261611AbSIXIYk>;
	Tue, 24 Sep 2002 04:24:40 -0400
Date: Tue, 24 Sep 2002 01:19:47 -0700 (PDT)
Message-Id: <20020924.011947.11684681.davem@redhat.com>
To: rusty@rustcorp.com.au
Cc: mingo@elte.hu, torvalds@transmeta.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] streq() 
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <20020924072814.CFC332C1AC@lists.samba.org>
References: <20020923.232413.08022213.davem@redhat.com>
	<20020924072814.CFC332C1AC@lists.samba.org>
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Rusty Russell <rusty@rustcorp.com.au>
   Date: Tue, 24 Sep 2002 17:28:00 +1000

   In message <20020923.232413.08022213.davem@redhat.com> you write:
   > Another idea is to make a gfp_flags_t, that worked very well
   > for things like mm_segment_t.
   
   But you can't or them together without some icky macro, unless they're
   typedef to an integer type in which case gcc doesn't warn you if you
   just stuck a "sizeof(x)" in there.

Maybe if you make it unsigned char or something.

If there aren't too many spots which need to "or" stuff,
all the "icky macro" stuff could be contained to gfp.h
