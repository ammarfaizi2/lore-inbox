Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261254AbTEKVzw (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 May 2003 17:55:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261265AbTEKVzw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 May 2003 17:55:52 -0400
Received: from imladris.demon.co.uk ([193.237.130.41]:23429 "EHLO
	imladris.demon.co.uk") by vger.kernel.org with ESMTP
	id S261254AbTEKVzv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 May 2003 17:55:51 -0400
Subject: Re: [bug 2.5.69] xirc2ps_cs, irq 3: nobody cared, shutdown hangs
From: David Woodhouse <dwmw2@infradead.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Jeff Garzik <jgarzik@pobox.com>, Zwane Mwaikambo <zwane@linuxpower.ca>,
       Daniel Ritz <daniel.ritz@gmx.ch>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@diego.com>
In-Reply-To: <1052673649.29921.15.camel@dhcp22.swansea.linux.org.uk>
References: <200305111647.32113.daniel.ritz@gmx.ch>
	 <Pine.LNX.4.50.0305111202510.15337-100000@montezuma.mastecende.com>
	 <3EBE8768.4000007@pobox.com>
	 <1052673649.29921.15.camel@dhcp22.swansea.linux.org.uk>
Content-Type: text/plain
Organization: 
Message-Id: <1052690907.15307.10.camel@imladris.demon.co.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5.dwmw2) 
Date: Sun, 11 May 2003 23:08:27 +0100
Content-Transfer-Encoding: 7bit
X-SA-Exim-Rcpt-To: alan@lxorguk.ukuu.org.uk, jgarzik@pobox.com, zwane@linuxpower.ca, daniel.ritz@gmx.ch, linux-kernel@vger.kernel.org, akpm@diego.com
X-SA-Exim-Scanned: No; SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2003-05-11 at 18:20, Alan Cox wrote:
> On Sul, 2003-05-11 at 18:24, Jeff Garzik wrote:
> >   If pcmcia hardware disappears on you, you _really_ don't want to be 
> > bitbanging its ports.

PCMCIA has varying pin length for the CD pins and hence gives you a few
milliseconds of warning before the card is _actually_ disconnected.

After that period of time has elapsed and the card is actually gone, you
_really_ don't want to be bitbanging its ports.

> Its quite safe to do so.

Not on all platforms.

-- 
dwmw2


