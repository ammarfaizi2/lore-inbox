Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261883AbSI2XzM>; Sun, 29 Sep 2002 19:55:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261889AbSI2XzL>; Sun, 29 Sep 2002 19:55:11 -0400
Received: from zero.aec.at ([193.170.194.10]:3338 "EHLO zero.aec.at")
	by vger.kernel.org with ESMTP id <S261883AbSI2Xy5>;
	Sun, 29 Sep 2002 19:54:57 -0400
To: Jochen Friedrich <jochen@scram.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: v2.6 vs v3.0
References: <m3k7l47qsv.fsf@averell.firstfloor.org>
	<Pine.LNX.4.44.0209291914220.18326-100000@alpha.bocc.de>
From: Andi Kleen <ak@muc.de>
Date: 30 Sep 2002 02:00:04 +0200
In-Reply-To: <Pine.LNX.4.44.0209291914220.18326-100000@alpha.bocc.de>
Message-ID: <m3u1k85ou3.fsf@averell.firstfloor.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jochen Friedrich <jochen@scram.de> writes:

> Hi Andi,
> 
> > Actually current IPv6 is stable and has been for a long time, it's just not
> > completely standards compliant (but still quite usable for a lot of people)
> 
> For end systems (no router) with static IPv6 definitions this seems to be
> true. However, for machines which use autoconfiguration (stateless as
> there isn't a usable IPv6 capable DHCP server AFAIK) or act as routers,
> the current state of the implementation of the default route can best be
> described as buggy. (Autoconfigured machines seem to loose their default
> route after some time, e.g.).

Are you sure this is not related to the routing daemon or rdisc daemon you 
use ? In the past when I had problems with lost default routes always such
a daemon was to blame.

> So IPv6 is returned by the resolver even though IPv6 isn't available in
> the kernel. The default of the resolver options should be dependent
> on the presence or absence of IPv6 in the currently running kernel IMHO.

Sounds more like an glibc issue. I would file a glibc gnats bug on this,
then it may even get fixed. The kernel has nothing to do with this at least.
 
> Finally, IPv6 sockets which also communicate over IPv4 using mapped
> addresses are considered bad nowadays ;-)

Hmm? 

-Andi
