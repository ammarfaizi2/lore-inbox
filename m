Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318789AbSIISit>; Mon, 9 Sep 2002 14:38:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318805AbSIISis>; Mon, 9 Sep 2002 14:38:48 -0400
Received: from packet.digeo.com ([12.110.80.53]:6603 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S318789AbSIIShu>;
	Mon, 9 Sep 2002 14:37:50 -0400
Message-ID: <3D7CEB7F.8A8AFB26@digeo.com>
Date: Mon, 09 Sep 2002 11:42:07 -0700
From: Andrew Morton <akpm@digeo.com>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.5.32 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Jesse Barnes <jbarnes@sgi.com>
CC: "Richard B. Johnson" <root@chaos.analogic.com>,
       Imran Badr <imran.badr@cavium.com>,
       "'David S. Miller'" <davem@redhat.com>, phillips@arcor.de,
       linux-kernel@vger.kernel.org
Subject: Re: Calculating kernel logical address ..
References: <019f01c25826$c553f310$9e10a8c0@IMRANPC> <Pine.LNX.3.95.1020909134937.18141A-100000@chaos.analogic.com> <20020909181355.GA1510567@sgi.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 09 Sep 2002 18:42:27.0678 (UTC) FILETIME=[A56BDFE0:01C25830]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jesse Barnes wrote:
> 
> On Mon, Sep 09, 2002 at 02:00:35PM -0400, Richard B. Johnson wrote:
> > Well I just read Documentation/DMA-mapping.txt as advised by David
> > and it seems as though it will no longer be possible to do what
> > many programmers have been wanting to do, to wit:
> >
> > (1) In user-code, allocate a buffer.
> > (2) Lock that buffer into memory.
> > (3) Call some driver that DMAs data to/from that buffer.
> 
> It looks drivers/media/video/video-buf.c uses alloc_kiovec() and
> map_user_kiobuf() to do it.

For video-buf.c and for Imran's application, that's just a wrapper
which is used to get at get_user_pages().

It would be best to not use the kiobuf code please - its future is
up in the air.  Just use get_user_pages() directly for now.
