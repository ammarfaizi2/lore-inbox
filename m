Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289260AbSBFLpY>; Wed, 6 Feb 2002 06:45:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289889AbSBFLpN>; Wed, 6 Feb 2002 06:45:13 -0500
Received: from garrincha.netbank.com.br ([200.203.199.88]:2577 "HELO
	netbank.com.br") by vger.kernel.org with SMTP id <S289260AbSBFLox>;
	Wed, 6 Feb 2002 06:44:53 -0500
Date: Wed, 6 Feb 2002 09:44:33 -0200 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: <riel@imladris.surriel.com>
To: <rwhron@earthlink.net>
Cc: Momchil Velikov <velco@fadata.bg>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Radix-tree pagecache for 2.5
In-Reply-To: <20020206020410.GA18035@earthlink.net>
Message-ID: <Pine.LNX.4.33L.0202060942400.17850-100000@imladris.surriel.com>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 5 Feb 2002 rwhron@earthlink.net wrote:

> I am curious if the small followup patch to 2.5.3-dj1 makes radix-tree
> more like 2.4.17-ratpagecache.  (overall, it seems that radix-tree did
> better in I/O without the small followup patch).

It would be useful if you also did dbench tests with a much
lower amount of dbench processes.

Once you get over 'dbench 16' or so the whole thing basically
becomes an excercise in how well the system can trigger task
starvation in get_request_wait.

I can recommend 'dbench 1'  'dbench 4'  'dbench 16'   ;)

> dbench 64 processes
> 2.5.3-dj1rat         **************************  13.1  MB/sec
> 2.5.3-dj1            **********************  11.1  MB/sec
> 2.5.3-dj1rat2        **********************  11.1  MB/sec
>
> dbench 192 processes
> 2.5.3-dj1rat         *************   6.8  MB/sec
> 2.5.3-dj1rat2        *************   6.7  MB/sec
> 2.5.3-dj1            *************   6.6  MB/sec



Rik
-- 
"Linux holds advantages over the single-vendor commercial OS"
    -- Microsoft's "Competing with Linux" document

http://www.surriel.com/		http://distro.conectiva.com/

