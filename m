Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262499AbSJHMvH>; Tue, 8 Oct 2002 08:51:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262508AbSJHMvH>; Tue, 8 Oct 2002 08:51:07 -0400
Received: from pc1-cwma1-5-cust51.swa.cable.ntl.com ([80.5.120.51]:57849 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S262499AbSJHMvG>; Tue, 8 Oct 2002 08:51:06 -0400
Subject: Re: [patch] IDE driver model update
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Alexander Viro <viro@math.psu.edu>
Cc: Patrick Mochel <mochel@osdl.org>, Linus Torvalds <torvalds@transmeta.com>,
       Andre Hedrick <andre@linux-ide.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.GSO.4.21.0210080813030.2894-100000@weyl.math.psu.edu>
References: <Pine.GSO.4.21.0210080813030.2894-100000@weyl.math.psu.edu>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 08 Oct 2002 14:05:37 +0100
Message-Id: <1034082337.26477.96.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2002-10-08 at 13:24, Alexander Viro wrote:
> > IDE objects can also outlast the hardware - consider an active mount on
> > an ejected pcmcia card. Right now we don't do the right stuff to
> > reconnect that on re-insert but one day we may need to. As it is we keep
> > the instance around to avoid crashes
> 
> Ouch.  That (reconnects) may require interesting things from queue-related
> code.  What behaviour do you want while card is disconnected?  All requests
> getting errors / all requests getting blocked / reads failing, writes blocking?

Right now it errors further requests. USB scsi does the whole reconnect
thing and seems to get it right, I need to look into this

