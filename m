Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130526AbRAGVTC>; Sun, 7 Jan 2001 16:19:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130130AbRAGVSw>; Sun, 7 Jan 2001 16:18:52 -0500
Received: from brutus.conectiva.com.br ([200.250.58.146]:56820 "EHLO
	brutus.conectiva.com.br") by vger.kernel.org with ESMTP
	id <S130526AbRAGVSo>; Sun, 7 Jan 2001 16:18:44 -0500
Date: Sun, 7 Jan 2001 19:18:31 -0200 (BRDT)
From: Rik van Riel <riel@conectiva.com.br>
To: Zlatko Calusic <zlatko@iskon.hr>
cc: Marcelo Tosatti <marcelo@conectiva.com.br>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [patch] mm-cleanup-1 (2.4.0)
In-Reply-To: <dnitnrcbji.fsf@magla.iskon.hr>
Message-ID: <Pine.LNX.4.21.0101071917250.21675-100000@duckman.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 7 Jan 2001, Zlatko Calusic wrote:

> OK, maybe I was too fast in concluding with that change. I'm
> still trying to find out why is MM working bad in some
> circumstances (see my other email to the list).
> 
> Anyway, I would than suggest to introduce another /proc entry
> and call it appropriately: max_async_pages. Because that is what
> we care about, anyway. I'll send another patch.

In fact, that's NOT what we care about.

What we really care about is the number of disk seeks
the VM subsystem has queued to disk, since it's seek
time that causes other requests to suffer bad latency.

regards,

Rik
--
Virtual memory is like a game you can't win;
However, without VM there's truly nothing to lose...

		http://www.surriel.com/
http://www.conectiva.com/	http://distro.conectiva.com.br/

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
