Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262127AbVBKFER@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262127AbVBKFER (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Feb 2005 00:04:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262176AbVBKFER
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Feb 2005 00:04:17 -0500
Received: from smtp807.mail.sc5.yahoo.com ([66.163.168.186]:3244 "HELO
	smtp807.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S262127AbVBKFEO convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Feb 2005 00:04:14 -0500
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: "David S. Miller" <davem@davemloft.net>
Subject: Re: [PATCH] arp_queue: serializing unlink + kfree_skb
Date: Fri, 11 Feb 2005 00:04:11 -0500
User-Agent: KMail/1.7.2
Cc: Werner Almesberger <wa@almesberger.net>, herbert@gondor.apana.org.au,
       anton@samba.org, okir@suse.de, netdev@oss.sgi.com,
       linux-kernel@vger.kernel.org
References: <20050131102920.GC4170@suse.de> <20050210012304.E25338@almesberger.net> <20050210195026.09b507e7.davem@davemloft.net>
In-Reply-To: <20050210195026.09b507e7.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200502110004.12133.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 10 February 2005 22:50, David S. Miller wrote:
> > > Unlike the above routines, it is required that explicit memory
> > > barriers are performed before and after the operation.  It must
> > > be done such that all memory operations before and after the
> > > atomic operation calls are strongly ordered with respect to the
> > > atomic operation itself.
> > 
> > Hmm, given that this description will not only be read by implementers
> > of atomic functions, but also by users, the "explicit memory barriers"
> > may be confusing.
> 
> Absolutely, I agree.  My fingers even itched as I typed those lines
> in.  I didn't change the wording because I couldn't come up with
> anything better.

What about the following:

Unlike the routines above, these functions should always perform memory
barriers before and after the operation in question so that all memory
accesses before and after the atomic operation are strongly ordered with
respect to the atomic operation itself.

-- 
Dmitry
