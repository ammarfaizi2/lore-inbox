Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129272AbRBLWsJ>; Mon, 12 Feb 2001 17:48:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129231AbRBLWr7>; Mon, 12 Feb 2001 17:47:59 -0500
Received: from yellow.csi.cam.ac.uk ([131.111.8.67]:13719 "EHLO
	yellow.csi.cam.ac.uk") by vger.kernel.org with ESMTP
	id <S129112AbRBLWry>; Mon, 12 Feb 2001 17:47:54 -0500
Date: Mon, 12 Feb 2001 22:46:57 +0000 (GMT)
From: James Sutherland <jas88@cam.ac.uk>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org
Subject: Re: LILO and serial speeds over 9600
In-Reply-To: <E14SQtT-0008C5-00@the-village.bc.nu>
Message-ID: <Pine.SOL.4.21.0102122211370.22949-100000@yellow.csi.cam.ac.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 12 Feb 2001, Alan Cox wrote:

> > > I have toyed a few times about having a simple Ethernet- or UDP-based
> > > console protocol (TCP is too heavyweight, sorry) where a machine would
> > > seek out a console server on the network.  Anyone has any ideas about
> > > it?
> > 
> > Excellent plan: data centre sysadmins the world over will worship your
> > name if it works...
> 
> Sounds like MOP on the old Vaxen. TCP btw isnt as heavyweight as people 
> sometimes think. You can (and people have) implemented a simple TCP client
> and IP and SLIP in 8K of EPROM on a 6502. There is a common misconception
> that a TCP must be complex.
> 
> All you actually _have_ to support is receiving frames in order, sending one
> frame at a time when the last data is acked and basic backoff. You dont have
> to parse tcp options, you dont have to support out of order reassembly.

It's not a huge undertaking, I know, but UDP will probably still be
a bit simpler. Turn the question around: would using TCP bring any real
benefits, in a system which will only be used to shift a few kb each boot
time?

At a later date, perhaps TCP could be used - it would certainly make sense
for the kernel-side code: once you have a fully-fledged IP stack, why not
use it. There's no reason the server couldn't support both, and machines
would just use whichever was more appropriate at the time.


James.


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://vger.kernel.org/lkml/
