Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751330AbVIURrx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751330AbVIURrx (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Sep 2005 13:47:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751336AbVIURrx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Sep 2005 13:47:53 -0400
Received: from pat.uio.no ([129.240.130.16]:57274 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id S1751330AbVIURrw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Sep 2005 13:47:52 -0400
Subject: Re: [PATCH] Keys: Add possessor permissions to keys
From: Trond Myklebust <trond.myklebust@fys.uio.no>
To: Andrew Morton <akpm@osdl.org>
Cc: David Howells <dhowells@redhat.com>, torvalds@osdl.org,
       keyrings@linux-nfs.org, linux-kernel@vger.kernel.org
In-Reply-To: <20050921101558.7ad7e7d7.akpm@osdl.org>
References: <5378.1127211442@warthog.cambridge.redhat.com>
	 <12434.1127314090@warthog.cambridge.redhat.com>
	 <20050921101558.7ad7e7d7.akpm@osdl.org>
Content-Type: text/plain
Date: Wed, 21 Sep 2005 13:47:14 -0400
Message-Id: <1127324834.11109.26.camel@lade.trondhjem.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.1.1 
Content-Transfer-Encoding: 7bit
X-UiO-Spam-info: not spam, SpamAssassin (score=-3.916, required 12,
	autolearn=disabled, AWL 1.08, UIO_MAIL_IS_INTERNAL -5.00)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

on den 21.09.2005 Klokka 10:15 (-0700) skreiv Andrew Morton:

> > +			if (PTR_ERR(key_ref) != -EAGAIN) {
> > +				if (IS_ERR(key_ref))
> > +					key = key_deref(key_ref);
> > +				else
> > +					key = ERR_PTR(PTR_ERR(key_ref));
> > +				break;
> > +			}
> > +		}
> 
> That's getting a bit intimate with how IS_ERR and PTR_ERR are implemented
> but I guess we're unlikely to change that.

Shouldn't that test for IS_ERR(key_ref) be inverted?

Cheers,
  Trond

