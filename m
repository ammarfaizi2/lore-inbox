Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261477AbUCIUc0 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Mar 2004 15:32:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261567AbUCIUc0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Mar 2004 15:32:26 -0500
Received: from mx1.redhat.com ([66.187.233.31]:45803 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261477AbUCIUcU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Mar 2004 15:32:20 -0500
Date: Tue, 9 Mar 2004 15:32:58 -0500 (EST)
From: James Morris <jmorris@redhat.com>
X-X-Sender: jmorris@thoron.boston.redhat.com
To: Clay Haapala <chaapala@cisco.com>
cc: Jouni Malinen <jkmaline@cc.hut.fi>, "David S. Miller" <davem@redhat.com>,
       <linux-kernel@vger.kernel.org>
Subject: Re: Crypto API and keyed non-HMAC digest algorithms / Michael MIC
In-Reply-To: <yquj7jxuudvn.fsf@chaapala-lnx2.cisco.com>
Message-ID: <Xine.LNX.4.44.0403091532020.27586-100000@thoron.boston.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 9 Mar 2004, Clay Haapala wrote:

> On Tue, 9 Mar 2004, James Morris uttered the following:
> > Agreed.  I really wanted to keep digests 'pure', and not implement a
> > setkey method, but it seems like the simplest way at this stage.
> > 
> I had the same thought in my attempt at adding CRC32C to the crypto
> routines, that what was needed was "digests + setkey".  But I didn't
> want to add the key baggage to digests, and so created a new alg type
> (CHKSUM), with pretty much identical code to digest, but with a
> modified init and a new setkey interface.
> 
> So, we could modify digests now, or perhaps Jouni and I could combine
> our code into a new KEYED_DIGEST type and leave digests 'pure'.
> What's best?

I think that adding a setkey method for digests is the simplest approach.


- James
-- 
James Morris
<jmorris@redhat.com>


