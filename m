Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129061AbQKFSXY>; Mon, 6 Nov 2000 13:23:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129493AbQKFSXQ>; Mon, 6 Nov 2000 13:23:16 -0500
Received: from waste.org ([209.173.204.2]:35376 "EHLO waste.org")
	by vger.kernel.org with ESMTP id <S129061AbQKFSXJ>;
	Mon, 6 Nov 2000 13:23:09 -0500
Date: Mon, 6 Nov 2000 12:22:49 -0600 (CST)
From: Oliver Xymoron <oxymoron@waste.org>
To: David Woodhouse <dwmw2@infradead.org>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Jeff Garzik <jgarzik@mandrakesoft.com>, Keith Owens <kaos@ocs.com.au>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Persistent module storage [was Linux 2.4 Status / TODO page] 
In-Reply-To: <9399.973532073@redhat.com>
Message-ID: <Pine.LNX.4.10.10011061210360.30477-100000@waste.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 6 Nov 2000, David Woodhouse wrote:

> The point here is that although I've put up with just keeping the sound 
> driver loaded for the last few years, permanently taking up a large amount 
> of DMA memory, the inter_module_xxx stuff that Keith is proposing would 
> give us a simple way of storing the data which we want to store. 
...
> Being able to do it completely in userspace would be neater, though.

I think there are a bunch of other devices that need stuff from userspace
before they fully init, namely the ones that load proprietary firmware
images. Will an approach like that work here?

Alternately, we could have a "virtual module" called mixer-settings-n,
which when requested would tell modprobe to call a program to do its
fiddly things but wouldn't actually load a module.

The virtual module idea is ugly, yes, and perhaps what's needed is a more
generic userspace hook interface. Something that merged what
/sbin/hotplug, /sbin/modprobe, and the much-talked-about devfsd-like
notifier are supposed to do.

--
 "Love the dolphins," she advised him. "Write by W.A.S.T.E.." 

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
