Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315427AbSF3Tg2>; Sun, 30 Jun 2002 15:36:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315429AbSF3Tg1>; Sun, 30 Jun 2002 15:36:27 -0400
Received: from t10-170.gprs.mtsnet.ru ([213.87.10.170]:41856 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id <S315427AbSF3Tg0>; Sun, 30 Jun 2002 15:36:26 -0400
Date: Sun, 30 Jun 2002 23:38:16 +0400
From: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
To: Oliver Pitzeier <o.pitzeier@uptime.at>, axp-kernel-list@redhat.com,
       linux-kernel@vger.kernel.org
Subject: Re: stxcopy.S error with 2.5.23 on Alpha
Message-ID: <20020630233816.B716@localhost.park.msu.ru>
References: <000401c2182a$729b0410$010b10ac@sbp.uptime.at> <20020628182841.A29028@twiddle.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20020628182841.A29028@twiddle.net>; from rth@twiddle.net on Fri, Jun 28, 2002 at 06:28:41PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 28, 2002 at 06:28:41PM -0700, Richard Henderson wrote:
> On Thu, Jun 20, 2002 at 09:16:45AM +0200, Oliver Pitzeier wrote:
> > Are all these errors because of the missing "regdef.h"?
> 
> Yes.
> 
> > And if yes, why is it missing!? :-(
> 
> No idea.

The reason is the "-nostdinc" flag introduced by the new 2.5 build
system. We're using a glibc header, which is a bug IMHO, as
it broke cross-compilation. The lazy solution was moving
regdef.h from /usr/include/alpha to asm-alpha (as in my recently
posted incomplete patches). Personally, I wouldn't mind to get rid
of OSF mnemonics - VMS/gas numeric registers names are much more
easy to remember for me. ;-)
Just a matter of taste, of course.

Ivan.
