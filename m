Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311180AbSEAMd4>; Wed, 1 May 2002 08:33:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311564AbSEAMdz>; Wed, 1 May 2002 08:33:55 -0400
Received: from smtp1.libero.it ([193.70.192.51]:21682 "EHLO smtp1.libero.it")
	by vger.kernel.org with ESMTP id <S311180AbSEAMdy> convert rfc822-to-8bit;
	Wed, 1 May 2002 08:33:54 -0400
Content-Type: text/plain; charset=US-ASCII
From: Andrea Aime <aaime@libero.it>
To: linux-kernel@vger.kernel.org
Subject: Re: How to tune vm to be less swap happy?
Date: Wed, 1 May 2002 14:33:57 +0000
User-Agent: KMail/1.4.5
In-Reply-To: <200205011202.38653.aaime@libero.it>
Cc: sneakums@zork.net
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200205011433.57599.aaime@libero.it>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sean wrote:
> I've found the rmap VM[0] to be a lot less swap-happy than the stock
> VM.  For example, I don't come in in the morning to find that the
> updatedb run has pushed everything into swap and bloated the inode and
> dentry caches to ridiculous sizes.  There is also a patch around for
> the stock VM, but I haven't tried it and I don't know what it does.

Thank you for your answer, Sean.
I've tried 2.4.19-pre6 (with preempt-patch), 2.4.19pre7ac2 (with rmap),
2.4.19-pre7aa2. The rmap kernel behaved a bit better by avoid swapping-out
to swap-in a second later (compared to aa), but still suffered (IMHO) from an 
oversized cache. The stock kernel was the worst one, of course.
The final cache size doesn't seem to depend much on the kernel, that's because
I asked for VM tune parameters. I also noticed that aa kernel dropped cache 
size down to 24MB, but only after one hour without any activity (had 
lunch...). BTW, please cc me, I'm not on the list, 
Best regards
Andrea Aime
