Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288756AbSANSiw>; Mon, 14 Jan 2002 13:38:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288759AbSANSim>; Mon, 14 Jan 2002 13:38:42 -0500
Received: from ns.ithnet.com ([217.64.64.10]:1540 "HELO heather.ithnet.com")
	by vger.kernel.org with SMTP id <S288756AbSANSia>;
	Mon, 14 Jan 2002 13:38:30 -0500
Date: Mon, 14 Jan 2002 19:38:16 +0100
From: Stephan von Krawczynski <skraw@ithnet.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Memory problem with bttv driver
Message-Id: <20020114193816.3fa131f8.skraw@ithnet.com>
In-Reply-To: <E16QBLq-0002Mu-00@the-village.bc.nu>
In-Reply-To: <20020114184334.0a1712d4.skraw@ithnet.com>
	<E16QBLq-0002Mu-00@the-village.bc.nu>
Organization: ith Kommunikationstechnik GmbH
X-Mailer: Sylpheed version 0.7.0 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 14 Jan 2002 17:56:54 +0000 (GMT)
Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:

> > > The bt848 drivers are working beautifully
> > > for me in 2.4.18pre
> > 
> > Well, I had a quick look at the code, and it seems that vmalloc is just
> > failing, the source line is obvious./proc/meminfo before modprobe and
xawtv:> > 
> >         total:    used:    free:  shared: buffers:  cached:
> > Mem:  1054728192 120070144 934658048        0 10420224 65257472
> > Swap: 1085652992        0 1085652992
> > 
> > Can this be highmem-related?
> 
> That would make complete sense if so. The bttv uses vmalloc_32(), as the
> card has 32bit limits, and I am not running bttv (nor I suspect are most
> people) with highmem enabled

Ok, we re-checked without highmem: it's still the same problem. I try to find
out what's so special about 2.4.10-SUSE...

Sorry for this dumb newbie question: is there an easy way (/proc?) to find out
how much vmalloc space is used/left?

Regards,
Stephan

