Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130971AbRCMNMX>; Tue, 13 Mar 2001 08:12:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131012AbRCMNMN>; Tue, 13 Mar 2001 08:12:13 -0500
Received: from brutus.conectiva.com.br ([200.250.58.146]:41974 "HELO
	burns.conectiva") by vger.kernel.org with SMTP id <S130971AbRCMNME>;
	Tue, 13 Mar 2001 08:12:04 -0500
Date: Tue, 13 Mar 2001 10:03:49 -0300 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
To: Mike Galbraith <mikeg@wen-online.de>
cc: David Shoon <dave@zylotech.com.au>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        alan@lxorguk.ukuu.org.uka.redhat.com,
        MOLNAR Ingo <mingo@chiara.elte.hu>
Subject: Re: system hang with "__alloc_page: 1-order allocation failed"
In-Reply-To: <Pine.LNX.4.33.0103131011250.1413-100000@mikeg.weiden.de>
Message-ID: <Pine.LNX.4.21.0103131001440.2102-100000@imladris.rielhome.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 13 Mar 2001, Mike Galbraith wrote:

> (A workaround is to lower max_threads to 25% of memory.. works, but is
> really cheezy.  OTOH, allowing half of memory to be allocated in task
> structs is a bit cheezy looking too.  That means that these tasks
> can't be big enough to be doing real work.. no?)

If half of memory is allocated for task structures, we won't
even be able to allocate the minimum number of page table
pages needed for each task ...

For a "normal" task we'll need at least 1 page directory and
3 page table pages. We only have space for half when the
maximum number of task_struct's is allocated.

Maybe it would be good to lower the default threads-max to
about 10% or less of physical memory ?

regards,

Rik
--
Virtual memory is like a game you can't win;
However, without VM there's truly nothing to lose...

		http://www.surriel.com/
http://www.conectiva.com/	http://distro.conectiva.com.br/

