Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261930AbSI3Fv3>; Mon, 30 Sep 2002 01:51:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261933AbSI3Fv3>; Mon, 30 Sep 2002 01:51:29 -0400
Received: from mx2.elte.hu ([157.181.151.9]:59873 "HELO mx2.elte.hu")
	by vger.kernel.org with SMTP id <S261930AbSI3Fv3>;
	Mon, 30 Sep 2002 01:51:29 -0400
Date: Mon, 30 Sep 2002 08:06:39 +0200 (CEST)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: Ingo Molnar <mingo@elte.hu>
To: "David S. Miller" <davem@redhat.com>
Cc: Linus Torvalds <torvalds@transmeta.com>, <linux-kernel@vger.kernel.org>,
       William Lee Irwin III <wli@holomorphy.com>, <dipankar@in.ibm.com>,
       Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>,
       Arnaldo Carvalho de Melo <acme@conectiva.com.br>
Subject: Re: [patch] smptimers, old BH removal, tq-cleanup, 2.5.39
In-Reply-To: <20020929.173946.33239830.davem@redhat.com>
Message-ID: <Pine.LNX.4.44.0209300802210.12592-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sun, 29 Sep 2002, David S. Miller wrote:

>    From: Ingo Molnar <mingo@elte.hu>
>    Date: Sun, 29 Sep 2002 19:52:17 +0200 (CEST)
>    
>    net_bh_lock: i have removed it, since it would synchronize to nothing. The
>    old protocol handlers should still run on UP, and on SMP the kernel prints
>    a warning upon use. Alexey, is this approach fine with you?
> 
> Just kill this crap completely.  Old protocol handlers are %100
> unsupported in 2.6
>
> I know people are working on fixing up basically every old protocol
> layer currently in the tree, so this will not be an issue.

wonderful. I thought it might have helped if we kep those old-protocol
callbacks around in the UP kernel still (to help converting stuff) - but
if this is being taken care of then great.

	Ingo

