Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266998AbTAFPnG>; Mon, 6 Jan 2003 10:43:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266999AbTAFPnF>; Mon, 6 Jan 2003 10:43:05 -0500
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:8069
	"EHLO irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S266998AbTAFPnE>; Mon, 6 Jan 2003 10:43:04 -0500
Subject: Re: NAPI and tg3
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Steffen Persvold <sp@scali.com>
Cc: "David S. Miller" <davem@redhat.com>, Jeff Garzik <jgarzik@pobox.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.44.0301061538420.15870-100000@sp-laptop.isdn.scali.no>
References: <Pine.LNX.4.44.0301061538420.15870-100000@sp-laptop.isdn.scali.no>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1041870960.17472.42.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.1 (1.2.1-2) 
Date: 06 Jan 2003 16:36:00 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2003-01-06 at 15:00, Steffen Persvold wrote:
> I discovered that if I renice the ksoftirqd processes to level 0, the 
> performance was actually better with the NAPI enabled driver compared to 
> the one without (as was intended my NAPI IIRC). With the default nice 
> level (19) on the ksoftirqd processes, the performance on multithreaded 
> programs was pretty lousy with the NAPI enabled driver.
> 
> Any reason why the ksoftirqd shouldn't be nice level 0 by default ? Is 
> this already fixed in 2.4.21-pre series ?

Hack the code to only fall back to ksoftirqd when there are say 10 rather
than 1 pending event and it should perform even better but still handle
overload properly

