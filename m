Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261230AbULQPKh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261230AbULQPKh (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Dec 2004 10:10:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261254AbULQPKh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Dec 2004 10:10:37 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:16548 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S261230AbULQPKc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Dec 2004 10:10:32 -0500
Date: Fri, 17 Dec 2004 16:10:31 +0100
From: Pavel Machek <pavel@ucw.cz>
To: James Morris <jmorris@redhat.com>
Cc: Bryan Fulton <bryan@coverity.com>, linux-kernel@vger.kernel.org,
       netdev@oss.sgi.com, netfilter-devel@lists.netfilter.org
Subject: Re: [Coverity] Untrusted user data in kernel
Message-ID: <20041217151031.GA27170@atrey.karlin.mff.cuni.cz>
References: <1103247211.3071.74.camel@localhost.localdomain> <Xine.LNX.4.44.0412170012040.12382-100000@thoron.boston.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Xine.LNX.4.44.0412170012040.12382-100000@thoron.boston.redhat.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> This at least needs CAP_NET_ADMIN.

Hmm, but that means that CAP_NET_ADMIN implies all other capabilities,
unless you fix this.

								Pavel

> > TAINTED variable "((tmp).num_counters * 16)" was passed to a tainted
> > sink.
> > 
> > 1161            counters = vmalloc(tmp.num_counters * sizeof(struct
> > ip6t_counters));
> > 1162            if (!counters) {
> > 1163                    ret = -ENOMEM;
> > 1164                    goto free_newinfo;
> > 1165            }
> > 
> > TAINTED variable "((tmp).num_counters * 16)" was passed to a tainted
> > sink.
> > 
> > 1166            memset(counters, 0, tmp.num_counters * sizeof(struct
> > ip6t_counters));


-- 
Boycott Kodak -- for their patent abuse against Java.
