Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318383AbSIISKC>; Mon, 9 Sep 2002 14:10:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318503AbSIISKC>; Mon, 9 Sep 2002 14:10:02 -0400
Received: from rj.SGI.COM ([192.82.208.96]:19159 "EHLO rj.sgi.com")
	by vger.kernel.org with ESMTP id <S318383AbSIISKB>;
	Mon, 9 Sep 2002 14:10:01 -0400
Date: Mon, 9 Sep 2002 11:13:55 -0700
From: Jesse Barnes <jbarnes@sgi.com>
To: "Richard B. Johnson" <root@chaos.analogic.com>
Cc: Imran Badr <imran.badr@cavium.com>, "'David S. Miller'" <davem@redhat.com>,
       phillips@arcor.de, linux-kernel@vger.kernel.org
Subject: Re: Calculating kernel logical address ..
Message-ID: <20020909181355.GA1510567@sgi.com>
Mail-Followup-To: "Richard B. Johnson" <root@chaos.analogic.com>,
	Imran Badr <imran.badr@cavium.com>,
	"'David S. Miller'" <davem@redhat.com>, phillips@arcor.de,
	linux-kernel@vger.kernel.org
References: <019f01c25826$c553f310$9e10a8c0@IMRANPC> <Pine.LNX.3.95.1020909134937.18141A-100000@chaos.analogic.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.3.95.1020909134937.18141A-100000@chaos.analogic.com>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 09, 2002 at 02:00:35PM -0400, Richard B. Johnson wrote:
> Well I just read Documentation/DMA-mapping.txt as advised by David
> and it seems as though it will no longer be possible to do what
> many programmers have been wanting to do, to wit:
> 
> (1) In user-code, allocate a buffer.
> (2) Lock that buffer into memory.
> (3) Call some driver that DMAs data to/from that buffer.

It looks drivers/media/video/video-buf.c uses alloc_kiovec() and
map_user_kiobuf() to do it.  And I think Ben LaHaise was talking about
removing these functions and creating some other, lightweight
interface for the same purpose?  OTOH, it's been awhile since I looked
at this stuff, so I'm not sure how it works anymore, I'm sure someone
else could provide more useful info.

Jesse
