Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293053AbSBWA1E>; Fri, 22 Feb 2002 19:27:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293055AbSBWA0z>; Fri, 22 Feb 2002 19:26:55 -0500
Received: from garrincha.netbank.com.br ([200.203.199.88]:27408 "HELO
	netbank.com.br") by vger.kernel.org with SMTP id <S293053AbSBWA0n>;
	Fri, 22 Feb 2002 19:26:43 -0500
Date: Fri, 22 Feb 2002 21:26:23 -0300 (BRT)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: <riel@imladris.surriel.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Paul Larson <plars@austin.ibm.com>, <marcelo@conectiva.com.br>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] 2.4.18-rc2 Fix for get_pid hang
In-Reply-To: <E16eQ4R-0003cZ-00@the-village.bc.nu>
Message-ID: <Pine.LNX.4.33L.0202222125050.7820-100000@imladris.surriel.com>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 23 Feb 2002, Alan Cox wrote:

> > This was made against 2.4.18-rc2 but applies cleanly against
> > 2.4.18-rc4.  This is a fix for a problem where if we run out of
> > available pids, get_pid will hang the system while it searches through
> > the tasks for an available pid forever.
>
> Wouldn't it be a much cleaner patch to limit the maximum number of
> processes to less than the number of pids available. You seem to be
> fixing a non problem by adding branches to the innards of a loop.

The problem here is that thread and process groups share
the pid namespace, so you the number of processes at which
you run out of pids varies between 10700 and 32000 ...

regards,

Rik
-- 
"Linux holds advantages over the single-vendor commercial OS"
    -- Microsoft's "Competing with Linux" document

http://www.surriel.com/		http://distro.conectiva.com/

