Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261595AbTK0Tyc (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Nov 2003 14:54:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261724AbTK0Tyc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Nov 2003 14:54:32 -0500
Received: from yue.hongo.wide.ad.jp ([203.178.139.94]:33032 "EHLO
	yue.hongo.wide.ad.jp") by vger.kernel.org with ESMTP
	id S261595AbTK0Tya (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Nov 2003 14:54:30 -0500
Date: Fri, 28 Nov 2003 04:54:13 +0900 (JST)
Message-Id: <20031128.045413.133305490.yoshfuji@linux-ipv6.org>
To: rmk+lkml@arm.linux.org.uk
Cc: felipe_alfaro@linuxmail.org, davem@redhat.com,
       linux-kernel@vger.kernel.org, netdev@oss.sgi.com,
       yoshfuji@linux-ipv6.org
Subject: Re: [PATCH 2.6]: IPv6: strcpy -> strlcpy
From: YOSHIFUJI Hideaki / =?iso-2022-jp?B?GyRCNUhGIzFRTEAbKEI=?= 
	<yoshfuji@linux-ipv6.org>
In-Reply-To: <20031127194602.A25015@flint.arm.linux.org.uk>
References: <1069934643.2393.0.camel@teapot.felipe-alfaro.com>
	<20031127.210953.116254624.yoshfuji@linux-ipv6.org>
	<20031127194602.A25015@flint.arm.linux.org.uk>
Organization: USAGI Project
X-URL: http://www.yoshifuji.org/%7Ehideaki/
X-Fingerprint: 90 22 65 EB 1E CF 3A D1 0B DF 80 D8 48 07 F8 94 E0 62 0E EA
X-PGP-Key-URL: http://www.yoshifuji.org/%7Ehideaki/hideaki@yoshifuji.org.asc
X-Face: "5$Al-.M>NJ%a'@hhZdQm:."qn~PA^gq4o*>iCFToq*bAi#4FRtx}enhuQKz7fNqQz\BYU]
 $~O_5m-9'}MIs`XGwIEscw;e5b>n"B_?j/AkL~i/MEa<!5P`&C$@oP>ZBLP
X-Mailer: Mew version 2.2 on Emacs 20.7 / Mule 4.1 (AOI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <20031127194602.A25015@flint.arm.linux.org.uk> (at Thu, 27 Nov 2003 19:46:02 +0000), Russell King <rmk+lkml@arm.linux.org.uk> says:

> > > > I agree, using sizeof() is the less error prone way of
> > > > doing things like this.
> > > > 
> > > > Felipe could you please rewrite your patch like this?
> > > 
> > > Done!
> > 
> > Thanks. Ok to me.
> 
> I'm slightly cautious here, although I haven't read the patch yet.
> Did anyone consider whether any of these structures were copied to
> user space, and whether, as a result of this change, we're now
> copying uninitialised data to users?

I believe that it, to change from strcpy() to strlcpy(), just 
eliminates possibility of buffer-overrun.

--yoshfuji
