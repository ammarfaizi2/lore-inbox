Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281031AbRKTLmc>; Tue, 20 Nov 2001 06:42:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281029AbRKTLmW>; Tue, 20 Nov 2001 06:42:22 -0500
Received: from perninha.conectiva.com.br ([200.250.58.156]:29196 "HELO
	perninha.conectiva.com.br") by vger.kernel.org with SMTP
	id <S281031AbRKTLmF>; Tue, 20 Nov 2001 06:42:05 -0500
Date: Tue, 20 Nov 2001 09:41:37 -0200 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: <riel@duckman.distro.conectiva>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Erik Gustavsson <cyrano@algonet.se>, <linux-kernel@vger.kernel.org>
Subject: Re: Swap
In-Reply-To: <m1k7wm6trd.fsf@frodo.biederman.org>
Message-ID: <Pine.LNX.4.33L.0111200940100.1491-100000@duckman.distro.conectiva>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 19 Nov 2001, Eric W. Biederman wrote:

> That would probably do it.  Though it is puzzling why after the file
> is munmaped it's pages aren't recycled.

Not really. Use-once doesn't work for pages which are
or have been mmap()d, but later use of the cache will
not be able to put pressure on the pages which have
been taken out of the use-once loop.

Use-once as we have it now is fundamentally unbalanced,
I can't see a way of ever getting that thing to work
nicely.

regards,

Rik
-- 
DMCA, SSSCA, W3C?  Who cares?  http://thefreeworld.net/

http://www.surriel.com/		http://distro.conectiva.com/

