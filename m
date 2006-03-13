Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932468AbWCMWIu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932468AbWCMWIu (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Mar 2006 17:08:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932492AbWCMWIu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Mar 2006 17:08:50 -0500
Received: from xenotime.net ([66.160.160.81]:28289 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S932468AbWCMWIt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Mar 2006 17:08:49 -0500
Date: Mon, 13 Mar 2006 14:10:34 -0800
From: "Randy.Dunlap" <rdunlap@xenotime.net>
To: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
Cc: shemminger@osdl.org, GregScott@InfraSupportEtc.com,
       76306.1226@compuserve.com, linux-kernel@vger.kernel.org,
       davem@davemloft.net, netdev@vger.kernel.org, bart@samwel.tk,
       alan@lxorguk.ukuu.org.uk, smackinlay@mail.com
Subject: Re: Router stops routing after changing MAC Address
Message-Id: <20060313141034.c3cf0eea.rdunlap@xenotime.net>
In-Reply-To: <Pine.LNX.4.61.0603131513380.5373@chaos.analogic.com>
References: <925A849792280C4E80C5461017A4B8A20321F2@mail733.InfraSupportEtc.com>
	<20060313100041.212cee08@localhost.localdomain>
	<Pine.LNX.4.61.0603131513380.5373@chaos.analogic.com>
Organization: YPO4
X-Mailer: Sylpheed version 2.2.2 (GTK+ 2.8.3; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 13 Mar 2006 15:27:26 -0500 linux-os \(Dick Johnson\) wrote:

> 
> On Mon, 13 Mar 2006, Stephen Hemminger wrote:
> 
> > There still is a bug in the 3c59x driver.  It doesn't include any code
> > to handle changing the mac address.  It will work if you take the device
> > down, change address, then bring it up. But you shouldn't have to do that.
> >
> > Also, if the driver handles setting mac address, it could have prevented
> > you from using a multicast address.
> >
> > Something like this is needed (untested, I don't have that hardware).
> >
[cut patch]

> Actually, it doesn't make any difference. Changing the IEEE station
> (physical) address is not an allowed procedure even though hooks are
> available in many drivers to do this. According to the IEEE 802
> physical media specification, this 48-bit address must be unique and
> must be one of a group assigned by IEEE. Failure to follow this
> simple protocol can (will) cause an entire network to fail. If
> you don't care, then you certainly don't care about multicast
> bits either, basically let them set it to all ones as well.

They used to allow "Locally Administered Addresses."  Hrm,
google still finds 18,000 hits for that phrase.  Is that now
outlawed?

Even ieee.org has hit(s) for it:
http://standards.ieee.org/regauth/groupmac/tutorial.html

http://en.wikipedia.org/wiki/MAC_address
http://www.mynetwatchman.com/pckidiot/chap04.htm

---
~Randy
You can't do anything without having to do something else first.
-- Belefant's Law
