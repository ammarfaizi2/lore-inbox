Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129406AbRAJT6n>; Wed, 10 Jan 2001 14:58:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129436AbRAJT6d>; Wed, 10 Jan 2001 14:58:33 -0500
Received: from penguin.engin.umich.edu ([141.213.33.36]:34828 "EHLO
	penguin.engin.umich.edu") by vger.kernel.org with ESMTP
	id <S129406AbRAJT6T>; Wed, 10 Jan 2001 14:58:19 -0500
Date: Wed, 10 Jan 2001 14:57:27 -0500 (EST)
From: Chris Wing <wingc@engin.umich.edu>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: linux-kernel@vger.kernel.org
Subject: Re: Subtle MM bug
Message-ID: <Pine.LNX.4.21.0101101445500.9483-100000@penguin.engin.umich.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan:

> I've seen exactly nil cases where there are any security holes in apps caused
> by that pthreads api non adherance. 

I don't know of any exploitable bugs that were found in it, but the identd
server included in Red Hat 6.1 (pidentd 3.0.10) unintentionally ran as
root instead of nobody because its programmer used pthreads and assumed
that setuid() would affect all threads.

I pointed this out to the author and Red Hat, and it was fixed in
pidentd 3.0.11 and Red Hat 6.2.

-Chris Wing
wingc@engin.umich.edu

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
