Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263256AbTAEGIb>; Sun, 5 Jan 2003 01:08:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263291AbTAEGIb>; Sun, 5 Jan 2003 01:08:31 -0500
Received: from packet.digeo.com ([12.110.80.53]:43231 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S263256AbTAEGI3>;
	Sun, 5 Jan 2003 01:08:29 -0500
Message-ID: <3E17CDD9.F5475B8B@digeo.com>
Date: Sat, 04 Jan 2003 22:16:57 -0800
From: Andrew Morton <akpm@digeo.com>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.5.54 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Andre Hedrick <andre@pyxtechnologies.com>
CC: Rik van Riel <riel@conectiva.com.br>, Richard Stallman <rms@gnu.org>,
       andrew@indranet.co.nz, linux-kernel@vger.kernel.org
Subject: Re: Linux iSCSI Initiator, OpenSource (fwd) (Re: Gauntlet Set NOW!)
References: <3E179CCF.F4CAE1E5@digeo.com> <Pine.LNX.4.10.10301041901530.421-100000@master.linux-ide.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 05 Jan 2003 06:16:57.0586 (UTC) FILETIME=[0CF3FD20:01C2B482]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andre Hedrick wrote:
> 
> ..
> Again all I want to know is where the threshold of fair usage lays.

Yes, it needs to be clarified.
 
> This posting made by Linus to the gnu.misc.discuss newsgroup (Message-ID
> "4b0rbb$5iu@klaava.helsinki.fi") on December 17, 1995 where he
> basically gave his permission for the EXPORT_SYMBOL
> vs. EXPORT_SYMBOL_GPL system hereby proprietary modules that call only
> EXPORT_SYMBOL symbols are allowed:
> 
> http://groups.google.com/groups?as_umsgid=4b0rbb%245iu%40klaava.helsinki.fi

I wasn't aware of that posting until Adam pointed it out.  It seems
to be a sensible and easily understandable position.
 
> Until there is some type of agreement ratified by all of us, this is a
> safe position for setting and holding a precedence.  If any one of the
> copyright holders in the kernel wishes to formally object, please do so
> now.

Yup.  Now is their chance.  Is everyone OK with treating the contents
of header files in the same was as EXPORT_SYMBOL()?  ie: LGPL?

Really, I don't see any alternative.  Even things like the semaphore
down() function are inlined.  Linus's 1995 intentions are infeasible
unless we also treat that part of the kernel API which is implemented
in headers as being exported.

It might make sense to be more selective, by putting #ifdef GPL around
some portions.  If anyone cares, and can be bothered.  If any inlined
function is complex enough to justify that then it's too damn big and
should be zoomed into a .c file anyway.
