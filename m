Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264661AbRFPVtC>; Sat, 16 Jun 2001 17:49:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264665AbRFPVsw>; Sat, 16 Jun 2001 17:48:52 -0400
Received: from humbolt.nl.linux.org ([131.211.28.48]:1298 "EHLO
	humbolt.nl.linux.org") by vger.kernel.org with ESMTP
	id <S264661AbRFPVsn>; Sat, 16 Jun 2001 17:48:43 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: Rik van Riel <riel@conectiva.com.br>
Subject: Re: spindown [was Re: 2.4.6-pre2, pre3 VM Behavior]
Date: Sat, 16 Jun 2001 23:44:57 +0200
X-Mailer: KMail [version 1.2]
Cc: Pavel Machek <pavel@suse.cz>, John Stoffel <stoffel@casc.com>,
        Roger Larsson <roger.larsson@norran.net>,
        Linux-Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.21.0106161801220.2056-100000@imladris.rielhome.conectiva>
In-Reply-To: <Pine.LNX.4.21.0106161801220.2056-100000@imladris.rielhome.conectiva>
MIME-Version: 1.0
Message-Id: <0106162344570L.00879@starship>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 16 June 2001 23:06, Rik van Riel wrote:
> On Sat, 16 Jun 2001, Daniel Phillips wrote:
> > As a side note, the good old multisecond delay before bdflush kicks in
> > doesn't really make a lot of sense - when bandwidth is available the
> > filesystem-initiated writeouts should happen right away.
>
> ... thus spinning up the disk ?

Nope, the disk is already spinning, some other writeouts just finished.

> How about just making sure we write out a bigger bunch
> of dirty pages whenever one buffer gets too old ?

It's simpler than that.  It's basically just: disk traffic low? good, write 
out all the dirty buffers.  Not quite as crude as that, but nearly.

> Does the patch below do anything good for your laptop? ;)

I'll wait for the next one ;-)

--
Daniel
