Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317971AbSIJShy>; Tue, 10 Sep 2002 14:37:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317977AbSIJShy>; Tue, 10 Sep 2002 14:37:54 -0400
Received: from pc1-cwma1-5-cust128.swa.cable.ntl.com ([80.5.120.128]:7155 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S317971AbSIJShv>; Tue, 10 Sep 2002 14:37:51 -0400
Subject: Re: [linux-usb-devel] Re: [BK PATCH] USB changes for 2.5.34
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: David Brownell <david-b@pacbell.net>,
       Matthew Dharm <mdharm-kernel@one-eyed-alien.net>,
       Greg KH <greg@kroah.com>, linux-usb-devel@lists.sourceforge.net,
       linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.44.0209100947481.2842-100000@home.transmeta.com>
References: <Pine.LNX.4.44.0209100947481.2842-100000@home.transmeta.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-6) 
Date: 10 Sep 2002 19:44:40 +0100
Message-Id: <1031683480.31787.107.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2002-09-10 at 17:51, Linus Torvalds wrote:
> (In fact, on UP a BUG() tends to be quite usable just about anywhere 
> except in an interrupt handler: there may be some local locks like 
> directory semaphores etc that are held and not released, but _most_ of the 
> time the machine is quite usable. SMP really does make things harder to 
> debug even quite apart from the races it introduces. Sad.)

It drops you politely into the kernel debugger, you fix up the values
and step over it. If you want to debug with zen mind power and printk
feel free. For the rest of us BUG() is fine on SMP

