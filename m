Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314396AbSHANxP>; Thu, 1 Aug 2002 09:53:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314529AbSHANxP>; Thu, 1 Aug 2002 09:53:15 -0400
Received: from willy.net1.nerim.net ([62.212.114.60]:6669 "EHLO www.home.local")
	by vger.kernel.org with ESMTP id <S314396AbSHANxP>;
	Thu, 1 Aug 2002 09:53:15 -0400
Date: Thu, 1 Aug 2002 15:56:23 +0200
From: Willy Tarreau <willy@w.ods.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Willy TARREAU <willy@w.ods.org>,
       Marcelo Tosatti <marcelo@conectiva.com.br>,
       lkml <linux-kernel@vger.kernel.org>
Subject: Re: [PANIC] APM bug with -rc4 and -rc5
Message-ID: <20020801135623.GA19879@alpha.home.local>
References: <Pine.LNX.4.44.0208010336330.1728-100000@freak.distro.conectiva> <20020801121205.GA168@pcw.home.local> <20020801133202.GA200@pcw.home.local> <1028213732.14865.50.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1028213732.14865.50.camel@irongate.swansea.linux.org.uk>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 01, 2002 at 03:55:32PM +0100, Alan Cox wrote:
> I've only run -ac on the box (I need the IDE) and that has subtly
> different APM code. I do not however understand why it has changed
> behaviour. I could understand if it did it at the actual poweroff point
> but not earlier

Ok, thanks. I'll try to revert some patches from -rc4. But it looks
more like a side effect IMHO. Perhaps the APM initialization code
triggers one of the numerous bugs in the bios :-/

If I enable APM in the bios, the crash is somewhat different. I get
about two pages of call traces looping back every 8 pointers.

Seems like a memory corruption to me...

2.4.19-rc3-ac5 is OK, BTW.

Cheers,
Willy
