Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276118AbRJUVAK>; Sun, 21 Oct 2001 17:00:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276743AbRJUVAB>; Sun, 21 Oct 2001 17:00:01 -0400
Received: from [216.151.155.121] ([216.151.155.121]:27909 "EHLO
	belphigor.mcnaught.org") by vger.kernel.org with ESMTP
	id <S276118AbRJUU7w>; Sun, 21 Oct 2001 16:59:52 -0400
To: Patrick Mau <mau@oscar.prima.de>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: connect() to localhost non-blocking.
In-Reply-To: <20011021224221.A8560@oscar.dorf.de>
From: Doug McNaught <doug@wireboard.com>
Date: 21 Oct 2001 17:00:18 -0400
In-Reply-To: Patrick Mau's message of "Sun, 21 Oct 2001 22:42:21 +0200"
Message-ID: <m3n12klndp.fsf@belphigor.mcnaught.org>
User-Agent: Gnus/5.0806 (Gnus v5.8.6) XEmacs/21.1 (20 Minutes to Nikko)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Patrick Mau <mau@oscar.prima.de> writes:

> I wrote a little test program to do some poll() benchmarks.
> I changed the host address to localhost and observed that
> connect() always returns EINPROGRESS when used with non-blocking
> sockets.
> 
> >From the man page:
> 
> EINPROGRESS
>  The socket is non-blocking and the connection cannot be completed
>  immediately. It is possible to select(2) or poll(2) for completion by
>  selecting the socket for writing.
> 
> So my question is:
> 
> What is meant by 'cannot be completed immediately' ?
> I thought that connections to localhost would complete
> without any delay when the application listens ?

Probably the accept()ing process hasn't been scheduled yet.
EINPROGRESS is a perfectly reasonable response in such a case. 

-Doug
-- 
Let us cross over the river, and rest under the shade of the trees.
   --T. J. Jackson, 1863
