Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281993AbRKZSMo>; Mon, 26 Nov 2001 13:12:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281992AbRKZSLy>; Mon, 26 Nov 2001 13:11:54 -0500
Received: from perninha.conectiva.com.br ([200.250.58.156]:52484 "HELO
	perninha.conectiva.com.br") by vger.kernel.org with SMTP
	id <S281998AbRKZSLZ>; Mon, 26 Nov 2001 13:11:25 -0500
Date: Mon, 26 Nov 2001 16:11:04 -0200 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: <riel@duckman.distro.conectiva>
To: "David S. Miller" <davem@redhat.com>
Cc: <mingo@elte.hu>, <velco@fadata.bg>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Scalable page cache
In-Reply-To: <20011126.100217.112611573.davem@redhat.com>
Message-ID: <Pine.LNX.4.33L.0111261607190.1491-100000@duckman.distro.conectiva>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 26 Nov 2001, David S. Miller wrote:
>    From: Ingo Molnar <mingo@elte.hu>
>    Date: Mon, 26 Nov 2001 18:22:25 +0100 (CET)
>
>    The problem with the tree is that if we have a big, eg. 16 GB pagecache,
>    then even assuming a perfectly balanced tree, it takes more than 20
>    iterations to find the page in the tree.
>
> His tree is per-inode, so you'd need a fully in ram 16GB _FILE_ to get
> the bad tree search properties you describe.

Also, if you keep heavily accessing that file, chances
are the top nodes of the tree will be in cache.

> I like his patch, a lot.

Certainly removes some complexity ;)

Rik
-- 
DMCA, SSSCA, W3C?  Who cares?  http://thefreeworld.net/

http://www.surriel.com/		http://distro.conectiva.com/

