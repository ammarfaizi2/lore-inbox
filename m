Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261265AbUKSHBW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261265AbUKSHBW (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Nov 2004 02:01:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261280AbUKSHBV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Nov 2004 02:01:21 -0500
Received: from fw.osdl.org ([65.172.181.6]:9704 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261265AbUKSHBP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Nov 2004 02:01:15 -0500
Date: Thu, 18 Nov 2004 23:01:09 -0800
From: Chris Wright <chrisw@osdl.org>
To: James Morris <jmorris@redhat.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Ross Kendall Axe <ross.axe@blueyonder.co.uk>, netdev@oss.sgi.com,
       Stephen Smalley <sds@epoch.ncsc.mil>,
       lkml <linux-kernel@vger.kernel.org>, Chris Wright <chrisw@osdl.org>,
       "David S. Miller" <davem@davemloft.net>
Subject: Re: [PATCH] linux 2.9.10-rc1: Fix oops in unix_dgram_sendmsg when using SELinux and SOCK_SEQPACKET
Message-ID: <20041118230109.V2357@build.pdx.osdl.net>
References: <1100821144.6005.40.camel@localhost.localdomain> <Xine.LNX.4.44.0411182207080.7831-100000@thoron.boston.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Xine.LNX.4.44.0411182207080.7831-100000@thoron.boston.redhat.com>; from jmorris@redhat.com on Thu, Nov 18, 2004 at 10:12:13PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* James Morris (jmorris@redhat.com) wrote:
> On Thu, 18 Nov 2004, Alan Cox wrote:
> 
> > As to the other stuff I think the only change needed is to check the
> > queued asynchronous error and report that before going on to the
> > connected test
> 
> How about this?

The other patch is already committed, so relative diff would be needed.

> (Also now ignores any supplied address per 
> http://www.opengroup.org/onlinepubs/009695399/functions/sendto.html)

Nitpick, but I missed where it said ignore the address.  And it seems
counter intuitive to provide address, only to have it ignored and
delivered elsewhere.

thanks,
-chris
