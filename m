Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267867AbTBVLOR>; Sat, 22 Feb 2003 06:14:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267881AbTBVLOR>; Sat, 22 Feb 2003 06:14:17 -0500
Received: from ce06d.unt0.torres.ka0.zugschlus.de ([212.126.206.6]:31237 "EHLO
	torres.ka0.zugschlus.de") by vger.kernel.org with ESMTP
	id <S267880AbTBVLOQ>; Sat, 22 Feb 2003 06:14:16 -0500
Date: Sat, 22 Feb 2003 12:24:24 +0100
From: Marc Haber <mh+linux-kernel@zugschlus.de>
To: linux-kernel@vger.kernel.org
Subject: Re: 2.4.20-ac1, tulip driver falls into transmit timeouts
Message-ID: <20030222112424.GA24580@torres.ka0.zugschlus.de>
References: <20030222084130.GB23827@torres.ka0.zugschlus.de> <20030222085331.GB5411@alpha.home.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030222085331.GB5411@alpha.home.local>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 22, 2003 at 09:53:31AM +0100, Willy Tarreau wrote:
> I suspect that your Catalyst has its interface in auto-negociation mode. This
> switch behaves randomly when in auto-neg. I had some which spontaneously
> renegociated after several months in production. You should force the ports
> to 100FD on the switch to make the problem disappear. BTW, when forced, it
> doesn't send its capabilities on the link and NICs often think it's a hub and
> then switch to 100 half. So you may also have to force your NICs to 100 fdx
> (ethtool or mii-diag).

yuck. Will try that later today.

> BTW, ensure that there's no spanning tree on the switch since it may be an
> external indirect cause of the link drops that your PC detected. BTW, note that
> exactly one minute has elapsed between your half and full duplex state changes.
> This might help in finding the origin of the problem.

The port is "spanning-tree portfast", but we need spanning tree on the
switch because of some reundant links being present in the network.

> Hoping this helps,

Thanks for your comments.

Greetings
Marc

-- 
-----------------------------------------------------------------------------
Marc Haber         | "I don't trust Computers. They | Mailadresse im Header
Karlsruhe, Germany |  lose things."    Winona Ryder | Fon: *49 721 966 32 15
Nordisch by Nature |  How to make an American Quilt | Fax: *49 721 966 31 29
