Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315721AbSHAQh6>; Thu, 1 Aug 2002 12:37:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315734AbSHAQh6>; Thu, 1 Aug 2002 12:37:58 -0400
Received: from willy.net1.nerim.net ([62.212.114.60]:11789 "EHLO
	www.home.local") by vger.kernel.org with ESMTP id <S315721AbSHAQh5>;
	Thu, 1 Aug 2002 12:37:57 -0400
Date: Thu, 1 Aug 2002 18:41:08 +0200
From: Willy Tarreau <willy@w.ods.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Willy Tarreau <willy@w.ods.org>,
       Marcelo Tosatti <marcelo@conectiva.com.br>,
       lkml <linux-kernel@vger.kernel.org>
Subject: Re: [PANIC] APM bug with -rc4 and -rc5
Message-ID: <20020801164108.GA20042@alpha.home.local>
References: <Pine.LNX.4.44.0208010336330.1728-100000@freak.distro.conectiva> <20020801121205.GA168@pcw.home.local> <20020801133202.GA200@pcw.home.local> <1028213732.14865.50.camel@irongate.swansea.linux.org.uk> <20020801135623.GA19879@alpha.home.local> <20020801152459.GA19989@alpha.home.local> <1028220826.14865.69.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1028220826.14865.69.camel@irongate.swansea.linux.org.uk>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 01, 2002 at 05:53:46PM +0100, Alan Cox wrote:
> Very curious indeed because someone else reported that rc3-ac5 works
> (which has the same vm86 code). In addition the vm86 handler in the
> kernel isnt actually used for APM. We make 32bit APM calls and the one
> 16bit case we do is a true return to real mode.

well, I saw it wrong. In fact, sometimes the system boots OK if it
is after a warm boot, and it seems that all the tests I've done with
"old" vm86 code were done from a warm boot. Now I can confirm that
from a cold boot, it also panics. And you're right about rc3-ac5,
since it also works for me.

Still searching...
Willy
