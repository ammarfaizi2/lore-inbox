Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265059AbTGCLHA (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Jul 2003 07:07:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265069AbTGCLGz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Jul 2003 07:06:55 -0400
Received: from hank-fep6-0.inet.fi ([194.251.242.201]:25059 "EHLO
	fep06.tmt.tele.fi") by vger.kernel.org with ESMTP id S265059AbTGCLGw
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Jul 2003 07:06:52 -0400
Message-ID: <3F0411B9.9E11022D@pp.inet.fi>
Date: Thu, 03 Jul 2003 14:21:29 +0300
From: Jari Ruusu <jari.ruusu@pp.inet.fi>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.2.20aa1 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Andries.Brouwer@cwi.nl
CC: akpm@digeo.com, linux-kernel@vger.kernel.org, torvalds@osdl.org
Subject: Re: [PATCH] cryptoloop
References: <UTC200307021844.h62IiIQ19914.aeb@smtp.cwi.nl>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andries.Brouwer@cwi.nl wrote:
> akpm:
> > You'll note that loop.c goes from (page/offset/len) to (addr/len),
> > and this transfer function then immediately goes from (addr,len)
> > to (page/offset/len). That's rather silly ..
> 
> Changing that would kill all existing modules that use the loop device.
> 
> Maybe nobody cares. Then we can do so in a subsequent patch.

I care. Please don't break the transfer function prototype.

I don't know if you guys have realized it or not, but cryptoloop+cryptoapi
is the slowest possible loop crypto implementation on the planet. Before you
guys sacrifice loop performance with cryptoloop only stuff, you may want to
do google search for "loop-AES" (twice as fast on most modern boxes) and
choose to preserve fast interfaces that other implementations depend on.

Regards,
Jari Ruusu <jari.ruusu@pp.inet.fi>

