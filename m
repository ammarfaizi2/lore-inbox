Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750742AbWIHJf1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750742AbWIHJf1 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Sep 2006 05:35:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750746AbWIHJf0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Sep 2006 05:35:26 -0400
Received: from coyote.holtmann.net ([217.160.111.169]:6382 "EHLO
	mail.holtmann.net") by vger.kernel.org with ESMTP id S1750742AbWIHJf0
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Sep 2006 05:35:26 -0400
Subject: Re: [stable] [patch 29/37] dvb-core: Proper handling ULE SNDU
	length of 0
From: Marcel Holtmann <marcel@holtmann.org>
To: Greg KH <greg@kroah.com>
Cc: Greg KH <gregkh@suse.de>, torvalds@osdl.org, akpm@osdl.org,
       "Theodore Ts'o" <tytso@mit.edu>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       Justin Forbes <jmforbes@linuxtx.org>, linux-kernel@vger.kernel.org,
       Chris Wedgwood <reviews@ml.cw.f00f.org>,
       Randy Dunlap <rdunlap@xenotime.net>, Dave Jones <davej@redhat.com>,
       Ang Way Chuang <wcang@nrg.cs.usm.my>,
       Chuck Wolber <chuckw@quantumlinux.com>, stable@kernel.org,
       alan@lxorguk.ukuu.org.uk
In-Reply-To: <20060907153947.GB29602@kroah.com>
References: <20060906224631.999046890@quad.kroah.org>
	 <20060906225740.GD15922@kroah.com>
	 <1157633876.30159.82.camel@aeonflux.holtmann.net>
	 <20060907153947.GB29602@kroah.com>
Content-Type: text/plain
Date: Fri, 08 Sep 2006 13:31:13 +0200
Message-Id: <1157715073.4128.6.camel@aeonflux.holtmann.net>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

> > > ULE (Unidirectional Lightweight Encapsulation RFC 4326) decapsulation
> > > code has a bug that allows an attacker to send a malformed ULE packet
> > > with SNDU length of 0 and bring down the receiving machine. This patch
> > > fix the bug and has been tested on version 2.6.17.11. This bug is 100%
> > > reproducible and the modified source code (GPL) used to produce this bug
> > > will be posted on http://nrg.cs.usm.my/downloads.htm shortly.  The
> > > kernel will produce a dump during CRC32 checking on faulty ULE packet.
> > 
> > the upstream code changed for 2.6.18. It has a different way of
> > addressing this issue, but it also changes a lot of other stuff in the
> > whole code. However it might be worth looking at it, because the
> > upstream code might be still vulnerable.
> 
> So we should not take this patch for 2.6.17.y?  Do you have a different
> patch we should use instead?

I have no idea. I don't have any DVB hardware for testing at hand. The
patch looks sane and seems to fix this problem. However for upstream we
can't apply it and upstream might not be vulnerable, because of the
updated version. If upstream is not vulnerable, I would prefer we go
with the upstream version. Anyway, not my call to make.

Regards

Marcel


