Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311147AbSCVLAn>; Fri, 22 Mar 2002 06:00:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311171AbSCVLAe>; Fri, 22 Mar 2002 06:00:34 -0500
Received: from ns.ithnet.com ([217.64.64.10]:30220 "HELO heather.ithnet.com")
	by vger.kernel.org with SMTP id <S311147AbSCVLAS>;
	Fri, 22 Mar 2002 06:00:18 -0500
Date: Fri, 22 Mar 2002 12:00:10 +0100
From: Stephan von Krawczynski <skraw@ithnet.com>
To: trond.myklebust@fys.uio.no
Cc: green@namesys.com, sneakums@zork.net, linux-kernel@vger.kernel.org
Subject: Re: BUG REPORT: kernel nfs between 2.4.19-pre2 (server) and 2.2.21-pre3 (client)
Message-Id: <20020322120010.16a53cc9.skraw@ithnet.com>
In-Reply-To: <15514.30892.392730.325607@charged.uio.no>
Organization: ith Kommunikationstechnik GmbH
X-Mailer: Sylpheed version 0.7.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 22 Mar 2002 01:19:56 +0100
Trond Myklebust <trond.myklebust@fys.uio.no> wrote:

> >>>>> " " == Stephan von Krawczynski <skraw@ithnet.com> writes:
> 
>      > Trond: can you please tell me in short, what the common case
>      > (or your guess) is why I see this stale file handles on the
>      > client side. I am going to try and find out myself what the
>      > problem with reiserfs is here, it gets a bit on my nerves
>      > now. Do you suspect the fs to drop some inodes under the
>      > nfs-server?
> 
> Hold on thar: are you using nfs-server (a.k.a. unfsd) or are you using
> knfsd?

This is a knfsd setup. 

> The client will only return ESTALE if the server has first told it to
> do so. For knfsd, this is only supposed to occur if the file has
> actually been deleted on the server (knfsd is supposed to be able to
> retrieve ReiserFS file that have fallen out of cache).

The files are obviously not deleted from the server. Can you give me a short
hint in where to look after this specific case (source location). I will try to
do some debugging around the place to see what is going on.

Thank you for your help

Stephan

