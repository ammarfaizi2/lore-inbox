Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318983AbSHSS4P>; Mon, 19 Aug 2002 14:56:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318984AbSHSS4P>; Mon, 19 Aug 2002 14:56:15 -0400
Received: from mhw.ulib.iupui.edu ([134.68.164.123]:46029 "EHLO
	mhw.ULib.IUPUI.Edu") by vger.kernel.org with ESMTP
	id <S318983AbSHSS4P>; Mon, 19 Aug 2002 14:56:15 -0400
Date: Mon, 19 Aug 2002 14:00:18 -0500 (EST)
From: "Mark H. Wood" <mwood@IUPUI.Edu>
X-X-Sender: <mwood@mhw.ULib.IUPUI.Edu>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: ethtool documentation
In-Reply-To: <1028672873.18130.198.camel@irongate.swansea.linux.org.uk>
Message-ID: <Pine.LNX.4.33.0208191310130.32065-100000@mhw.ULib.IUPUI.Edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 6 Aug 2002, Alan Cox wrote:
> On Tue, 2002-08-06 at 21:42, Randy.Dunlap wrote:
> > Do you mean several unicast MAC addresses, as opposed to
> > broadcast + several multicast + (one) unicast MAC address?
> > If so, I'm not familiar with that scenario.
>
> Two unicast addresses, one for the sane world one for DECnet. The DEC
> tulip supports this as one example

Yes indeedy.  This is what DECnet Phase IV has instead of ARP.  Rather
than broadcast a query and hope someone answers with the desired mapping,
Phase IV specifies a mapping formula so that the sender can simply
calculate a MAC address for any neighbor, given its upper-level address.
That's where those AA-00-04 addresses come from -- the lowest 16 bits are
the DECnet area and node number.  There are a number of well-known
multicast addresses (AB-00-04) too.

Notice something that nobody has brought up yet (unless it's in the 3000
messages I haven't caught up to yet, sorry):  LAA and UAA addresses can
always be distinguished, by a bit in the top end.  You can manufacture all
the LAAs you want and namespace collisions are your problem, but UAAs are
expected to be unique and unchanging.

-- 
Mark H. Wood, Lead System Programmer   mwood@IUPUI.Edu
MS Windows *is* user-friendly, but only for certain values of "user".

