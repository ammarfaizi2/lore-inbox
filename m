Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315415AbSHRQ77>; Sun, 18 Aug 2002 12:59:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315427AbSHRQ77>; Sun, 18 Aug 2002 12:59:59 -0400
Received: from svr-ganmtc-appserv-mgmt.ncf.coxexpress.com ([24.136.46.5]:45069
	"EHLO svr-ganmtc-appserv-mgmt.ncf.coxexpress.com") by vger.kernel.org
	with ESMTP id <S315415AbSHRQ77>; Sun, 18 Aug 2002 12:59:59 -0400
Subject: Re: [PATCH] (0/4) Entropy accounting fixes
From: Robert Love <rml@tech9.net>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Oliver Xymoron <oxymoron@waste.org>,
       linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.44.0208180916560.10546-100000@home.transmeta.com>
References: <Pine.LNX.4.44.0208180916560.10546-100000@home.transmeta.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 
Date: 18 Aug 2002 13:03:58 -0400
Message-Id: <1029690238.1837.28.camel@phantasy>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2002-08-18 at 12:59, Linus Torvalds wrote:

> Is there anything that actually uses /dev/random at all (except for 
> clueless programs that really don't need to)?

Some OpenSSH installs must use /dev/random (either an earlier version
than what Oliver quoted or the distribution changed it) because I have
seen headless/diskless machines where they block on ssh session key
generation indefinitely.  I wrote my netdev-random to solve this...

We have seen similar stuff on embedded devices at MontaVista.

> Now this I absolutely agree with. The xor'ing of the buffer data is 
> clearly a good idea. I agree 100% with this part. You'll see no arguments 
> against this part at all.

Yes this is _very_ smart.

	Robert Love

