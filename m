Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284548AbRLESPi>; Wed, 5 Dec 2001 13:15:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284546AbRLESP1>; Wed, 5 Dec 2001 13:15:27 -0500
Received: from perninha.conectiva.com.br ([200.250.58.156]:53262 "HELO
	perninha.conectiva.com.br") by vger.kernel.org with SMTP
	id <S284550AbRLESPT>; Wed, 5 Dec 2001 13:15:19 -0500
Date: Wed, 5 Dec 2001 14:58:24 -0200 (BRST)
From: Marcelo Tosatti <marcelo@conectiva.com.br>
To: Roy Sigurd Karlsbakk <roy@karlsbakk.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: /proc/sys/vm/(max|min)-readahead effect????
In-Reply-To: <Pine.LNX.4.30.0112051909210.2966-100000@mustard.heime.net>
Message-ID: <Pine.LNX.4.21.0112051454530.20519-100000@freak.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 5 Dec 2001, Roy Sigurd Karlsbakk wrote:

> > Do you also have VM pressure going on or do you have lots of free memory ?
> 
> I've got a lot of memory (some 380 megs), but what is VM pressure?

VM pressure means that there is not enough free memory on the system...
Allocators have to reclaim memory.

Basically you cannot simply expect an increase in readahead size to
increase performance:

1) The files you created may not be sequential
2) The lack of memory on the system may be interfering in weird ways, and
maybe _INCREASING_ the readahead may decrease performance.
...

Also, remember: The real applications running on the system may not want
to read files sequentially, so increasing readahead is just useless. 

