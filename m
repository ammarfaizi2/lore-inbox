Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130985AbRBAQak>; Thu, 1 Feb 2001 11:30:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131001AbRBAQaa>; Thu, 1 Feb 2001 11:30:30 -0500
Received: from brutus.conectiva.com.br ([200.250.58.146]:56061 "EHLO
	brutus.conectiva.com.br") by vger.kernel.org with ESMTP
	id <S130985AbRBAQaR>; Thu, 1 Feb 2001 11:30:17 -0500
Date: Thu, 1 Feb 2001 14:29:27 -0200 (BRDT)
From: Rik van Riel <riel@conectiva.com.br>
To: David Ford <david@linux.com>
cc: Ed Tomlinson <tomlins@cam.org>, linux-kernel@vger.kernel.org
Subject: Re: VM brokenness, possibly related to reiserfs
In-Reply-To: <3A7959E9.E62F4581@linux.com>
Message-ID: <Pine.LNX.4.21.0102011428090.1321-100000@duckman.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 1 Feb 2001, David Ford wrote:

> Correct, the point of the matter is to find stress points.  It
> will do the exact same thing when it reaches the end of swap.  
> I suspect a relation to reiserfs fighting for buffers perhaps.  
> This fight occurs a few megs before the OOM routine trips.

Ah, so this is the problem. I've already heard that the
OOM killer is no longer triggered for some reason, I'll
enter the bug in the Linux-MM bugzilla so I don't forget
it and I'll fix it ASAP.

ObBugzillaURL:
	http://www.linux-mm.org/bugzilla.shtml

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
