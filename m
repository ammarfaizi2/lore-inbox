Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318602AbSHEQGd>; Mon, 5 Aug 2002 12:06:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318608AbSHEQGd>; Mon, 5 Aug 2002 12:06:33 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:23571 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S318602AbSHEQGd>; Mon, 5 Aug 2002 12:06:33 -0400
Date: Mon, 5 Aug 2002 09:10:08 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Rusty Russell <rusty@rustcorp.com.au>
cc: "David S. Miller" <davem@redhat.com>, <linux-kernel@vger.kernel.org>,
       <vamsi_krishna@in.ibm.com>
Subject: Re: [PATCH] kprobes for 2.5.30 
In-Reply-To: <20020805072606.C4E9E4125@lists.samba.org>
Message-ID: <Pine.LNX.4.44.0208050906030.1753-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 5 Aug 2002, Rusty Russell wrote:
> 
> In testing, I came up against the "spin_unlock() causes schedule()
> inside interrupt" problem.

It shouldn't cause a schedule, it should cause a big warning (with 
complete trace) to be printed out. Or did you mean something else?

Maybe the warning should be changed to

	Warning, kernel is mixing metaphors. "It's not rocket surgery".

to make it clear why it's a bad idea.

		Linus

