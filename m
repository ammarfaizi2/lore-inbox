Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267001AbTAFQBI>; Mon, 6 Jan 2003 11:01:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267005AbTAFQBI>; Mon, 6 Jan 2003 11:01:08 -0500
Received: from elin.scali.no ([62.70.89.10]:10506 "EHLO elin.scali.no")
	by vger.kernel.org with ESMTP id <S267001AbTAFQBI>;
	Mon, 6 Jan 2003 11:01:08 -0500
Date: Mon, 6 Jan 2003 17:12:43 +0100 (CET)
From: Steffen Persvold <sp@scali.com>
X-X-Sender: sp@sp-laptop.isdn.scali.no
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: "David S. Miller" <davem@redhat.com>, Jeff Garzik <jgarzik@pobox.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: NAPI and tg3
In-Reply-To: <1041870960.17472.42.camel@irongate.swansea.linux.org.uk>
Message-ID: <Pine.LNX.4.44.0301061707200.15870-100000@sp-laptop.isdn.scali.no>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 6 Jan 2003, Alan Cox wrote:

> On Mon, 2003-01-06 at 15:00, Steffen Persvold wrote:
> > I discovered that if I renice the ksoftirqd processes to level 0, the 
> > performance was actually better with the NAPI enabled driver compared to 
> > the one without (as was intended my NAPI IIRC). With the default nice 
> > level (19) on the ksoftirqd processes, the performance on multithreaded 
> > programs was pretty lousy with the NAPI enabled driver.
> > 
> > Any reason why the ksoftirqd shouldn't be nice level 0 by default ? Is 
> > this already fixed in 2.4.21-pre series ?
> 
> Hack the code to only fall back to ksoftirqd when there are say 10 rather
> than 1 pending event and it should perform even better but still handle
> overload properly
> 

Ok I can try that, but what about the nice level of ksoftirqd ? Any 
specific reason for it beeing 19 (lowest priority) and not 0 (equally to 
most other processes in the system) ?

Regards,
 -- 
  Steffen Persvold   |       Scali AS      
 mailto:sp@scali.com |  http://www.scali.com
Tel: (+47) 2262 8950 |   Olaf Helsets vei 6
Fax: (+47) 2262 8951 |   N0621 Oslo, NORWAY

