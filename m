Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319304AbSH2TQq>; Thu, 29 Aug 2002 15:16:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319305AbSH2TQq>; Thu, 29 Aug 2002 15:16:46 -0400
Received: from pc1-cwma1-5-cust128.swa.cable.ntl.com ([80.5.120.128]:55548
	"EHLO irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S319304AbSH2TQp>; Thu, 29 Aug 2002 15:16:45 -0400
Subject: Re: [PATCH][2.5.32] CPU frequency and voltage scaling (0/4)
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <aklq8b$220$1@penguin.transmeta.com>
References: <Pine.LNX.4.44.0208281649540.27728-100000@home.transmeta.com>
	<1030618420.7290.112.camel@irongate.swansea.linux.org.uk> 
	<aklq8b$220$1@penguin.transmeta.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-6) 
Date: 29 Aug 2002 20:24:14 +0100
Message-Id: <1030649054.7190.164.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2002-08-29 at 19:47, Linus Torvalds wrote:
> Hmm.. I would assume that you'd just use the high frequency for that?

That doesnt work if Im trying to keep the machine running slowly at low
power but still want the I/O to work. I guess its fudgeable however and
the battery policy is enough info.

> I don't know the exact details of what kinds of frequencies the Geode
> supports, but it sounds to me like you don't really need another
> frequency value.. 

It tops out at about 300Mhz. Life gets excessively interesting because
about half the I/O on the Geode is imaginary and caused by SMM traps.
When power saving you normally set the geode to run slowly but spike
hard to full power when faking hardware. WIthout that some stuff like
the SB emulation doesnt work very well.

Alan

