Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265830AbTGDH2s (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Jul 2003 03:28:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265836AbTGDH2s
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Jul 2003 03:28:48 -0400
Received: from hank-fep7-0.inet.fi ([194.251.242.202]:42216 "EHLO
	fep07.tmt.tele.fi") by vger.kernel.org with ESMTP id S265830AbTGDH2k
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Jul 2003 03:28:40 -0400
Message-ID: <3F05300E.AA26A021@pp.inet.fi>
Date: Fri, 04 Jul 2003 10:43:10 +0300
From: Jari Ruusu <jari.ruusu@pp.inet.fi>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.2.20aa1 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Chris Friesen <cfriesen@nortelnetworks.com>
CC: Andrew Morton <akpm@osdl.org>, Andries.Brouwer@cwi.nl, akpm@digeo.com,
       linux-kernel@vger.kernel.org, torvalds@osdl.org
Subject: Re: [PATCH] cryptoloop
References: <UTC200307021844.h62IiIQ19914.aeb@smtp.cwi.nl>			<3F0411B9.9E11022D@pp.inet.fi> <20030703082034.5643b336.akpm@osdl.org> <3F04680D.B9703696@pp.inet.fi> <3F046A30.6080509@nortelnetworks.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chris Friesen wrote:
> Jari Ruusu wrote:
> > Because loop-AES attempts to be compatible with structures in loop.h by not
> > modifying loop.h at all. This is what the "no kernel sources patched or
> > replaced" means. Breakage in loop.h breaks loop-AES, and I have to clean the
> > mess.
> 
> We're in a development stream.  It is kind of expected that in-kernel
> APIs may change if the developers feel it will lead to some improvement.
> 
> This sucks for people that are trying to track those APIs with
> out-of-kernel patches, but its a fact of life.

I know. I already have to deal with API breakages.

Changing transfer function prototype may be a tiny speed improvement for one
implementation that happens to use unoptimal API, but at same time be tiny
speed degration to other implementations that use more saner APIs. I am
unhappy with that change, because I happen to maintain four such transfers
that would be subject to tiny speed degration.

Regards,
Jari Ruusu <jari.ruusu@pp.inet.fi>

