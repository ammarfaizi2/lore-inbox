Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285347AbSAGTW3>; Mon, 7 Jan 2002 14:22:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285424AbSAGTWU>; Mon, 7 Jan 2002 14:22:20 -0500
Received: from mx2.elte.hu ([157.181.151.9]:48801 "HELO mx2.elte.hu")
	by vger.kernel.org with SMTP id <S285347AbSAGTWO>;
	Mon, 7 Jan 2002 14:22:14 -0500
Date: Mon, 7 Jan 2002 22:19:40 +0100 (CET)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: <mingo@elte.hu>
To: Brian Gerst <bgerst@didntduck.org>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@transmeta.com>
Subject: Re: [patch] O(1) scheduler, -D1, 2.5.2-pre9, 2.4.17
In-Reply-To: <3C39F11F.35C88B2D@didntduck.org>
Message-ID: <Pine.LNX.4.33.0201072218120.15677-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 7 Jan 2002, Brian Gerst wrote:

> I noticed in this patch that you removed the rest_init() function.
> The reason it was split from start_kernel() is that there was a race
> where init memory could be freed before the call to cpu_idle().  Note
> that start_kernel() is marked __init and rest_init() is not.

you are right, i've missed that detail. I've fixed this in my tree
(reverted that part to the previous behavior), the fix will show up in the
next patch. Thanks,

	Ingo

