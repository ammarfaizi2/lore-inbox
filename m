Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316667AbSHXUJz>; Sat, 24 Aug 2002 16:09:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316672AbSHXUJz>; Sat, 24 Aug 2002 16:09:55 -0400
Received: from pc2-cwma1-5-cust12.swa.cable.ntl.com ([80.5.121.12]:17139 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S316667AbSHXUJz>; Sat, 24 Aug 2002 16:09:55 -0400
Subject: Re: IDE janitoring comments
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Andre Hedrick <andre@linux-ide.org>, linux-kernel@vger.kernel.org
In-Reply-To: <20020824151558.26134@192.168.4.1>
References: <20020824151558.26134@192.168.4.1>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-6) 
Date: 24 Aug 2002 21:14:11 +0100
Message-Id: <1030220051.3196.5.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2002-08-24 at 16:15, Benjamin Herrenschmidt wrote:
>  - Do we really want to keep all those _P versions around ?
> A quick grep showed _only_ by the non-portable x86 specific
> recovery timer stuff that taps ISA timers (well, I think ports
> 0x40 and 0x43 and an ISA timer). I would strongly suggest to

I'd like to keep them around for the moment. They should be using
udelay() but thats a general issue with _p inb/outb etc.

> After much thinking about the above, I came to the conslusion
> we probably want to just kill all the IN_BYTE, OUT_BYTE, etc.

Agreed entirely


> Also, getting rid of the _P version would make things a lot
> easier as well here too.

What currently uses the _P versions ?

