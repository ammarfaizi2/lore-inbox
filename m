Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1160999AbWIGPkO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1160999AbWIGPkO (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Sep 2006 11:40:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161003AbWIGPkO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Sep 2006 11:40:14 -0400
Received: from ns1.suse.de ([195.135.220.2]:25822 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1160999AbWIGPkM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Sep 2006 11:40:12 -0400
Date: Thu, 7 Sep 2006 08:39:47 -0700
From: Greg KH <greg@kroah.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: Greg KH <gregkh@suse.de>, torvalds@osdl.org, akpm@osdl.org,
       "Theodore Ts'o" <tytso@mit.edu>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       Justin Forbes <jmforbes@linuxtx.org>, linux-kernel@vger.kernel.org,
       Chris Wedgwood <reviews@ml.cw.f00f.org>,
       Randy Dunlap <rdunlap@xenotime.net>, Dave Jones <davej@redhat.com>,
       Ang Way Chuang <wcang@nrg.cs.usm.my>,
       Chuck Wolber <chuckw@quantumlinux.com>, stable@kernel.org,
       alan@lxorguk.ukuu.org.uk
Subject: Re: [stable] [patch 29/37] dvb-core: Proper handling ULE SNDU length of 0
Message-ID: <20060907153947.GB29602@kroah.com>
References: <20060906224631.999046890@quad.kroah.org> <20060906225740.GD15922@kroah.com> <1157633876.30159.82.camel@aeonflux.holtmann.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1157633876.30159.82.camel@aeonflux.holtmann.net>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 07, 2006 at 02:57:56PM +0200, Marcel Holtmann wrote:
> Hi Greg,
> 
> > ULE (Unidirectional Lightweight Encapsulation RFC 4326) decapsulation
> > code has a bug that allows an attacker to send a malformed ULE packet
> > with SNDU length of 0 and bring down the receiving machine. This patch
> > fix the bug and has been tested on version 2.6.17.11. This bug is 100%
> > reproducible and the modified source code (GPL) used to produce this bug
> > will be posted on http://nrg.cs.usm.my/downloads.htm shortly.  The
> > kernel will produce a dump during CRC32 checking on faulty ULE packet.
> 
> the upstream code changed for 2.6.18. It has a different way of
> addressing this issue, but it also changes a lot of other stuff in the
> whole code. However it might be worth looking at it, because the
> upstream code might be still vulnerable.

So we should not take this patch for 2.6.17.y?  Do you have a different
patch we should use instead?

thanks,

greg k-h
