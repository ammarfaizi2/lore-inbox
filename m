Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318591AbSIFNSo>; Fri, 6 Sep 2002 09:18:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318599AbSIFNSn>; Fri, 6 Sep 2002 09:18:43 -0400
Received: from 2-210.ctame701-1.telepar.net.br ([200.193.160.210]:18129 "EHLO
	2-210.ctame701-1.telepar.net.br") by vger.kernel.org with ESMTP
	id <S318591AbSIFNSn>; Fri, 6 Sep 2002 09:18:43 -0400
Date: Fri, 6 Sep 2002 10:22:43 -0300 (BRT)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: riel@imladris.surriel.com
To: "Peter T. Breuer" <ptb@it.uc3m.es>
cc: Anton Altaparmakov <aia21@cantab.net>, Daniel Phillips <phillips@arcor.de>,
       Alexander Viro <viro@math.psu.edu>,
       Xavier Bestel <xavier.bestel@free.fr>, <david.lang@digitalinsight.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: (fwd) Re: [RFC] mount flag "direct"
In-Reply-To: <200209060917.g869H5c08220@oboe.it.uc3m.es>
Message-ID: <Pine.LNX.4.44L.0209061021280.1857-100000@imladris.surriel.com>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 6 Sep 2002, Peter T. Breuer wrote:

>    suppose that I make the FS twice as slow as before by meddling with
>    it to make it sharable
>
>    then I simply share it among 4 nodes to get a two times _speed up_
>    overall.
>
> That's the basic idea. Details left to reader.

The "detail" is lock contention. If you lock the filesystem
and invalidate the caches you'll be able to do one operation
every disk seek, across all nodes.

Chances are your 4-node system would have lower aggregate
throughput than a single node system.

Rik
-- 
Bravely reimplemented by the knights who say "NIH".

http://www.surriel.com/		http://distro.conectiva.com/

Spamtraps of the month:  september@surriel.com trac@trac.org

