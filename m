Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290820AbSBFViY>; Wed, 6 Feb 2002 16:38:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290823AbSBFViR>; Wed, 6 Feb 2002 16:38:17 -0500
Received: from garrincha.netbank.com.br ([200.203.199.88]:48658 "HELO
	netbank.com.br") by vger.kernel.org with SMTP id <S290820AbSBFVh7>;
	Wed, 6 Feb 2002 16:37:59 -0500
Date: Wed, 6 Feb 2002 19:37:42 -0200 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: <riel@imladris.surriel.com>
To: <rwhron@earthlink.net>
Cc: <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Radix-tree pagecache for 2.5
In-Reply-To: <20020206213420.GA24571@earthlink.net>
Message-ID: <Pine.LNX.4.33L.0202061936240.17850-100000@imladris.surriel.com>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 6 Feb 2002 rwhron@earthlink.net wrote:
> On Wed, Feb 06, 2002 at 09:44:33AM -0200, Rik van Riel wrote:
> > Once you get over 'dbench 16' or so the whole thing basically
> > becomes an excercise in how well the system can trigger task
> > starvation in get_request_wait.
>
> It's neat you've identified that bottleneck.

Umm, there's one thing you need to remember about these
high dbench loads though.

They run fastest when you run each of the dbench forks
sequentially and have the others stuck in get_request_wait.

This, of course, is completely unacceptable for real-world
server scenarios, where all users of the server need to be
serviced fairly.

regards,

Rik
-- 
"Linux holds advantages over the single-vendor commercial OS"
    -- Microsoft's "Competing with Linux" document

http://www.surriel.com/		http://distro.conectiva.com/

