Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129137AbRBLXgD>; Mon, 12 Feb 2001 18:36:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129601AbRBLXfy>; Mon, 12 Feb 2001 18:35:54 -0500
Received: from yellow.csi.cam.ac.uk ([131.111.8.67]:28571 "EHLO
	yellow.csi.cam.ac.uk") by vger.kernel.org with ESMTP
	id <S129436AbRBLXfs>; Mon, 12 Feb 2001 18:35:48 -0500
Date: Mon, 12 Feb 2001 23:35:00 +0000 (GMT)
From: James Sutherland <jas88@cam.ac.uk>
To: "H. Peter Anvin" <hpa@transmeta.com>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Werner Almesberger <Werner.Almesberger@epfl.ch>,
        linux-kernel@vger.kernel.org
Subject: Re: LILO and serial speeds over 9600
In-Reply-To: <3A886FAC.C47465A7@transmeta.com>
Message-ID: <Pine.SOL.4.21.0102122331360.21380-100000@yellow.csi.cam.ac.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 12 Feb 2001, H. Peter Anvin wrote:

> Alan Cox wrote:
> > 
> > > > Explain 'controlled buffer overrun'.
> > >
> > > That's probably the ability to send new data even if there's unacked old
> > > data (e.g. because the receiver can't keep up or because we've had losses).
> > 
> > Well let me see, the typical window on the other end of the connection if
> > its a normal PC class host will be 32K. I think that should be sufficient.
> 
> Depends on what the client can handle.  For the kernel, that might be
> true, but for example a boot loader may only have a few K worth of buffer
> space.

Fortunately, the bulky stuff (printk's from the booting kernel) will be
going from the boot loader to the server, and should be buffered there
OK until they can be processed. Only the stuff sent to the client will
need buffering, and that should be simple keystrokes...


James.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://vger.kernel.org/lkml/
