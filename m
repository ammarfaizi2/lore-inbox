Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132939AbRDJGeb>; Tue, 10 Apr 2001 02:34:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132940AbRDJGeV>; Tue, 10 Apr 2001 02:34:21 -0400
Received: from fgwmail5.fujitsu.co.jp ([192.51.44.35]:20405 "EHLO
	fgwmail5.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id <S132939AbRDJGeG>; Tue, 10 Apr 2001 02:34:06 -0400
Date: Tue, 10 Apr 2001 15:33:57 +0900
Message-ID: <66gdjmay.wl@frostrubin.open.nm.fujitsu.co.jp>
From: Tachino Nobuhiro <tachino@open.nm.fujitsu.co.jp>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Tachino Nobuhiro <tachino@open.nm.fujitsu.co.jp>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: rw_semaphores
In-Reply-To: <Pine.LNX.4.31.0104092242320.11520-100000@penguin.transmeta.com>
In-Reply-To: <y9t9easn.wl@frostrubin.open.nm.fujitsu.co.jp>
	<Pine.LNX.4.31.0104092242320.11520-100000@penguin.transmeta.com>
User-Agent: Wanderlust/2.4.0 (Rio) EMY/1.13.9 (Art is long, life is short) SLIM/1.14.3 () APEL/10.2 MULE XEmacs/21.2 (beta46) (Urania) (i586-kondara-linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


At Mon, 9 Apr 2001 22:43:53 -0700 (PDT),
Linus Torvalds wrote:

> The ordering is certainly possible, but if it happens,
> __down_read_failed() won't actually sleep, because it will notice that the
> value is positive and just return immediately. So it will do some
> unnecessary work (add itself to the wait-queue only to remove itself
> immediately again), but it will do the right thing.
> 
> 		Linus
> 

  I understand. Thank you.
