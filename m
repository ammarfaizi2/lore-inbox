Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261744AbSIPN6z>; Mon, 16 Sep 2002 09:58:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261806AbSIPN6z>; Mon, 16 Sep 2002 09:58:55 -0400
Received: from 2-028.ctame701-1.telepar.net.br ([200.193.160.28]:33730 "EHLO
	2-028.ctame701-1.telepar.net.br") by vger.kernel.org with ESMTP
	id <S261744AbSIPN6y>; Mon, 16 Sep 2002 09:58:54 -0400
Date: Mon, 16 Sep 2002 11:03:34 -0300 (BRT)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: riel@imladris.surriel.com
To: Helge Hafting <helgehaf@aitel.hist.no>
cc: linux-kernel@vger.kernel.org
Subject: Re: Killing/balancing processes when overcommited
In-Reply-To: <3D85886B.3AB1284@aitel.hist.no>
Message-ID: <Pine.LNX.4.44L.0209161102120.1857-100000@imladris.surriel.com>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 16 Sep 2002, Helge Hafting wrote:
> Rik van Riel wrote:
>
> > 1) memory is exhausted
> > 2) the network driver can't allocate memory and
> >    spits out a message
> > 3) syslogd and/or klogd get killed
> >
> > Clearly you want to be a bit smarter about which process to kill.
>
> Ill-implemented klogd/syslogd.  Pre-allocating a little memory
> is one way to go, or drop messages until allocation
> becomes possible again.  Then log a complaint about
> messages missing due to a temporary OOM.

No.  This has absolutely nothing to do with it.

In this case, "allocating memory" simply means that klogd/syslogd
page faults on something it already allocated, say a piece of the
executable or a swapped-out buffer.

Simple page faults like this can also trigger an OOM-killing.

Rik
-- 
Bravely reimplemented by the knights who say "NIH".

http://www.surriel.com/		http://distro.conectiva.com/

Spamtraps of the month:  september@surriel.com trac@trac.org

