Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130770AbRCPRx7>; Fri, 16 Mar 2001 12:53:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130777AbRCPRxu>; Fri, 16 Mar 2001 12:53:50 -0500
Received: from fs1.dekanat.physik.uni-tuebingen.de ([134.2.216.20]:4873 "EHLO
	fs1.dekanat.physik.uni-tuebingen.de") by vger.kernel.org with ESMTP
	id <S130770AbRCPRxk>; Fri, 16 Mar 2001 12:53:40 -0500
Date: Fri, 16 Mar 2001 18:52:26 +0100 (CET)
From: Richard Guenther <richard.guenther@student.uni-tuebingen.de>
To: <Sane_Purushottam@emc.com>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: fork and pthreads
In-Reply-To: <93F527C91A6ED411AFE10050040665D0560664@corpusmx1.us.dg.com>
Message-ID: <Pine.LNX.4.30.0103161850040.517-100000@fs1.dekanat.physik.uni-tuebingen.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

Well, using pthreads and forking in them seems to trigger libc
bugs (read: SIGSEGvs) here under certain conditions (happens,
after I introduced signal handlers and using pthread_sigmask,
I think), so hangs should be definitely possible, too...

Richard.

On Fri, 16 Mar 2001 Sane_Purushottam@emc.com wrote:

> I am having a strange problem.
>
> I have a big daemon program to which I am trying to add multi-threading.
>
> At the begining, after some sanity check, this program does a double fork to
> create a deamon.
>
> After that it listens for the client on the port. Whenever the client
> connects, it creates a new thread using
> pthread-create.
>
> The problem is, the thread (main thread) calling pthread-create hangs
> indefinetely in __sigsuspend. The newly created thread however, runs
> normally to completion.
>
> I wrote few test programs trying to simulate this behaviour but all of them
> worked as expected.
>
> Does anyone know, what's going on ??
>
> Nitin Sane
> sane_purushottam@emc.com
> *(508)382-7319
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>

--
Richard Guenther <richard.guenther@student.uni-tuebingen.de>
WWW: http://www.anatom.uni-tuebingen.de/~richi/
The GLAME Project: http://www.glame.de/

