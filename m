Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314278AbSDVRHk>; Mon, 22 Apr 2002 13:07:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314280AbSDVRHj>; Mon, 22 Apr 2002 13:07:39 -0400
Received: from ns.suse.de ([213.95.15.193]:54029 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S314278AbSDVRHj>;
	Mon, 22 Apr 2002 13:07:39 -0400
To: DJ Barrow <dj.barrow@asitatech.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: novice coding in /linux/net/ipv4/util.c From: DJ Barrow <dj.barrow@asitatech.com>
In-Reply-To: <20020422151025Z314220-22651+13849@vger.kernel.org.suse.lists.linux.kernel>
From: Andi Kleen <ak@suse.de>
Date: 22 Apr 2002 19:07:38 +0200
Message-ID: <p73it6j8xwl.fsf@oldwotan.suse.de>
X-Mailer: Gnus v5.7/Emacs 20.6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

DJ Barrow <dj.barrow@asitatech.com> writes:

> This textbook peice of novice coding which has existed since 2.2.14.

Even earlier I think 

BTW do you call libresolv novice coding too ? 

> For those who can't spot the error, please note that this function is 
> returning a static string, excellent stuff if you are hoping to reuse the 
> same function like the following
> printk("%s %s\n",in_ntoa(addr1),in_ntoa(addr2));

That is why most of networking uses the NIPQUAD macro instead.

Best would be probably to convert the few remaining users of in_ntoa
to NIPQUAD and drop this function.

-Andi

