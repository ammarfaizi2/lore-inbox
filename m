Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130174AbRBUXHO>; Wed, 21 Feb 2001 18:07:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129181AbRBUXHE>; Wed, 21 Feb 2001 18:07:04 -0500
Received: from e1.ny.us.ibm.com ([32.97.182.101]:403 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S129170AbRBUXG7>;
	Wed, 21 Feb 2001 18:06:59 -0500
Date: Wed, 21 Feb 2001 18:06:02 -0500 (EST)
From: Richard A Nelson <cowboy@vnet.ibm.com>
X-X-Sender: <cowboy@badlands.lexington.ibm.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.4.1ac20
In-Reply-To: <E14VMx1-00013J-00@the-village.bc.nu>
Message-ID: <Pine.LNX.4.33.0102211758510.2261-100000@badlands.lexington.ibm.com>
X-No-Markup: yes
x-No-ProductLinks: yes
x-No-Archive: yes
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


hrm... it seems the updates to olympic.c have rendered it DOA ;-{

I get an Oops on module loading, followed by a reboot - I've not
been able to trap the oops, but I recall that the EIP was 0x10 (invalid)

The only candidates (it was a trivially small patch) seem to be:
the two additions:  dev->last_rx = jiffies ; I'll bet that at least
one of those points that dev is null (and it must be the first one
because the second seems to be in an #ifdef that shouldn't be triggered.

-- 
Rick Nelson
Perhaps the RBLing (Realtime Black Hole) of msn.com recently, which
prevented a large amount of mail going out for about 4 days, has had a
positive influence in Redmond.  They did agree to work on their anti-relay
capabilities at their POPs to get the RBL lifted.
	-- Bill Campbell on Smail3-users

