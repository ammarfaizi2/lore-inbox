Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316039AbSEJPzW>; Fri, 10 May 2002 11:55:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316044AbSEJPzV>; Fri, 10 May 2002 11:55:21 -0400
Received: from ahriman.Bucharest.roedu.net ([141.85.128.71]:2775 "HELO
	ahriman.bucharest.roedu.net") by vger.kernel.org with SMTP
	id <S316039AbSEJPzS>; Fri, 10 May 2002 11:55:18 -0400
Date: Fri, 10 May 2002 19:04:36 +0300 (EEST)
From: Mihai RUSU <dizzy@roedu.net>
X-X-Sender: <dizzy@ahriman.bucharest.roedu.net>
To: "David S. Miller" <davem@redhat.com>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: mmap, SIGBUS, and handling it
In-Reply-To: <20020510.083050.55863714.davem@redhat.com>
Message-ID: <Pine.LNX.4.33.0205101900090.9661-100000@ahriman.bucharest.roedu.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 10 May 2002, David S. Miller wrote:

>    From: Mihai RUSU <dizzy@roedu.net>
>    Date: Fri, 10 May 2002 18:37:21 +0300 (EEST)
>
>    PS: why signal(SIGBUS,SIG_IGN) doesnt work, but a user handler its called
>    if set with signal(SIGBUS,handle_sigbus) ?
>
> How would you like the kernel to "ignore" a page fault that cannot be
> serviced?
>

You are right, its not that I want to ignore it. The problem was that I
want to handle it some way but I dont know how. If I will make a user
handler for it how can I know if its a SIGBUS from a HW error or a SIGBUS
from that write()-case. Because I have to continue serving files even
after received a SIGBUS in that write (otherwise my file server will exit
with SIGBUS and thats no good :) ).

Take for example any single process ftp/http server, they are hit by this
problem. Which solution would you recommend ? :)

----------------------------
Mihai RUSU

Disclaimer: Any views or opinions presented within this e-mail are solely
those of the author and do not necessarily represent those of any company,
unless otherwise specifically stated.

