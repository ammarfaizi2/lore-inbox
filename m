Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272372AbTHIOG3 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 9 Aug 2003 10:06:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272378AbTHIOG3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Aug 2003 10:06:29 -0400
Received: from waste.org ([209.173.204.2]:57791 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S272372AbTHIOGF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Aug 2003 10:06:05 -0400
Date: Sat, 9 Aug 2003 09:05:42 -0500
From: Matt Mackall <mpm@selenic.com>
To: "David S. Miller" <davem@redhat.com>
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org, jmorris@intercode.com.au
Subject: Re: [RFC][PATCH] Make cryptoapi non-optional?
Message-ID: <20030809140542.GR31810@waste.org>
References: <20030809074459.GQ31810@waste.org> <20030809010418.3b01b2eb.davem@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030809010418.3b01b2eb.davem@redhat.com>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 09, 2003 at 01:04:18AM -0700, David S. Miller wrote:
> On Sat, 9 Aug 2003 02:44:59 -0500
> Matt Mackall <mpm@selenic.com> wrote:
> 
> > The attached (lightly tested) patch gets rid of the SHA in the
> > /dev/random code and replaces it with cryptoapi, leaving us with just
> > one SHA implementation.
>  ...
> >  __u32 secure_tcp_syn_cookie(__u32 saddr, __u32 daddr, __u16 sport,
> >  		__u16 dport, __u32 sseq, __u32 count, __u32 data)
>  ...
> > +	tfm = crypto_alloc_tfm("sha1", 0);
> 

> This patch needs tons of work.

Yes, it's completely bogus. It also needs tons of error-checking, etc.
All of which is a big waste of time if the answer to "is making
cryptoapi mandatory ok?" is no. So before embarking on the hard part,
I thought I'd ask the hard question.

-- 
Matt Mackall : http://www.selenic.com : of or relating to the moon
