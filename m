Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269154AbRHLNIq>; Sun, 12 Aug 2001 09:08:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269155AbRHLNIg>; Sun, 12 Aug 2001 09:08:36 -0400
Received: from druid.if.uj.edu.pl ([149.156.64.221]:5124 "HELO
	druid.if.uj.edu.pl") by vger.kernel.org with SMTP
	id <S269154AbRHLNI1>; Sun, 12 Aug 2001 09:08:27 -0400
Date: Sun, 12 Aug 2001 15:09:21 +0200 (CEST)
From: Maciej Zenczykowski <maze@druid.if.uj.edu.pl>
To: Rik van Riel <riel@conectiva.com.br>
Cc: David Ford <david@blue-labs.org>, <linux-kernel@vger.kernel.org>
Subject: Re: VM nuisance
In-Reply-To: <Pine.LNX.4.33L.0108102347050.3530-100000@imladris.rielhome.conectiva>
Message-ID: <Pine.LNX.4.33.0108121506100.18332-100000@druid.if.uj.edu.pl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> No.  The problem is that whenever I change something to
> the OOM killer I get flamed.
>
> Both by the people for whom the OOM killer kicks in too
> early and by the people for whom the OOM killer now doesn't
> kick in.
>
> I haven't got the faintest idea how to come up with an OOM
> killer which does the right thing for everybody.

How about adding some sort of per-process priority (i.e. a la nice) which
would determine the order in which they would be OOMed? Then we could
safely run X with a kigh KillMe and Netscape with an even higher KillMe
and we would probably avoid the something useing too much memory let's
kill root's shell...

[i.e. if a lower KillMe proc runs out of memory we kill off the process
with the highest KillMe using most mem and can safely give this mem to the
proc which just ran out]

MaZe.

