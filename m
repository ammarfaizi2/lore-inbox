Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129521AbQLDRJ1>; Mon, 4 Dec 2000 12:09:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129573AbQLDRJS>; Mon, 4 Dec 2000 12:09:18 -0500
Received: from mandrakesoft.mandrakesoft.com ([216.71.84.35]:1900 "EHLO
	mandrakesoft.mandrakesoft.com") by vger.kernel.org with ESMTP
	id <S129521AbQLDRJE>; Mon, 4 Dec 2000 12:09:04 -0500
Date: Mon, 4 Dec 2000 10:37:54 -0600 (CST)
From: Jeff Garzik <jgarzik@mandrakesoft.mandrakesoft.com>
To: Thomas Sailer <sailer@ife.ee.ethz.ch>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Pavel Machek <pavel@suse.cz>,
        torvalds@transmeta.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] i810_audio 2.4.0-test11
In-Reply-To: <3A2BA005.F85423F6@ife.ee.ethz.ch>
Message-ID: <Pine.LNX.3.96.1001204103533.9128C-100000@mandrakesoft.mandrakesoft.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 4 Dec 2000, Thomas Sailer wrote:
> And before killing format conversion you should kill
> the mmap stunt, because the format conversion complexity
> (~25 LOC) is by far dwarfed by the mmap emulation stuff.

mmap -emulation- ??  Ug.  Is Quake really worth that much? :)


> The underlying question is:
> 
> - do we want an usb audio driver that supports the OSS
>   interface and with which most existing applications work

of course

> Anything in between is IMO silly. Killing the format
> conversion drops the advantage of running many existing
> applications but don't bring you much closer to the goal
> of simplicity.

OSS has always implied that the software performs conversions when the
hardware cannot support certain formats.  And the kernel direction has
always been to -remove- any software conversion code.  We removed
SoftOSS, for example.

	Jeff



-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
