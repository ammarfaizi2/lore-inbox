Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261518AbSI1OGi>; Sat, 28 Sep 2002 10:06:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261540AbSI1OGh>; Sat, 28 Sep 2002 10:06:37 -0400
Received: from ws-002.ray.fi ([193.64.14.2]:40884 "EHLO behemoth.ts.ray.fi")
	by vger.kernel.org with ESMTP id <S261518AbSI1OGe>;
	Sat, 28 Sep 2002 10:06:34 -0400
Date: Sat, 28 Sep 2002 17:11:46 +0300 (EEST)
From: Tommi Kyntola <kynde@ts.ray.fi>
X-X-Sender: kynde@behemoth.ts.ray.fi
To: Greg KH <greg@kroah.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: USB Mass Storage Hangs
In-Reply-To: <20020927055158.GB8971@kroah.com>
Message-ID: <Pine.LNX.4.44.0209281703030.8153-100000@behemoth.ts.ray.fi>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> On Fri, Sep 27, 2002 at 12:38:16AM -0500, Stephen Marz wrote:
> > This message regards the USB mass storage driver for kernel version
> > 2.4.18-10:
> > 
> > On my Dell Inspiron 7500 I have an adaptec USB 2.0 cardbus
> > adapter.  I plugged in a 120GB hard drive and the mass
> > storage driver in linux detects it and runs it fine.  The
> > problem comes in when I try to also plug in my CD-RW into
> > the cardbus adapter (it has two USB 2.0 ports).  The mass
> > storage driver will detect and gather information about
> > the drive, however it doesn't take more than two or
> > three minutes before the entire system hangs.  The kernel
> > immediately drops all knowledge of any USB device on
> > my system.
> > 
> > Anybody else notice this problem?
> 
> Is there a kernel oops anywhere?
> And are both of these devices USB 2.0 devices?  If so, you might want to
> try the 2.4.20-pre kernels, it has much better USB 2.0 support than the
> kernel you are using.

I can still panic even the 2.4.20-pre8, by plugging in 
a usb mass storage key, mount, umount, unplug, plug back in,
mount, umount
The second umount hangs at doing something like "waiting CSW" and
after few seconds (30ish, I'd say) the kernel panics.

Reason why I havent been moaning about this since last fall, when I first 
discovered this and reported, is my lack of time to get into this and
a work-around I found that avoids it.
If I rmmod the usb-storage after I've unmounted the key and insmod back in 
before mounting it again, it works like a charm.

If someone is now interested in this topic (Matthew hasn't responded)
I can easily send the panic reports or whatever information needed.
I've tested this on atleast dozen very different boxes and the results 
were identical.

With previous kernels (say, from 2.4.17-preX to 2.4.19-preX it oopsed 
rather than paniced), I think I still have those oopses somewhere if 
anyone wants them.

Feel free to contact directly or via lkml,
Tommi Kynde Kyntola		kynde@ts.ray.fi
      "A man alone in the forest talking to himself and
       no women around to hear him. Is he still wrong?"

> 
> thanks,
> 
> greg k-h
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 


