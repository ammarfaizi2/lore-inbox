Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161027AbWIGAcR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161027AbWIGAcR (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Sep 2006 20:32:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161026AbWIGAcR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Sep 2006 20:32:17 -0400
Received: from nef2.ens.fr ([129.199.96.40]:62990 "EHLO nef2.ens.fr")
	by vger.kernel.org with ESMTP id S1161027AbWIGAcQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Sep 2006 20:32:16 -0400
Date: Thu, 7 Sep 2006 02:32:10 +0200
From: David Madore <david.madore@ens.fr>
To: Linux Kernel mailing-list <linux-kernel@vger.kernel.org>
Cc: Casey Schaufler <casey@schaufler-ca.com>
Subject: Re: patch to make Linux capabilities into something useful (v 0.3.1)
Message-ID: <20060907003210.GA5503@clipper.ens.fr>
References: <20060906132623.GA15665@clipper.ens.fr> <20060907001151.48122.qmail@web36607.mail.mud.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060907001151.48122.qmail@web36607.mail.mud.yahoo.com>
User-Agent: Mutt/1.5.9i
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.5.10 (nef2.ens.fr [129.199.96.32]); Thu, 07 Sep 2006 02:32:10 +0200 (CEST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 07, 2006 at 12:12:15AM +0000, Casey Schaufler wrote:
> You have not introduced new capabilities
> so much as you've introduced a new layer of
> policy, that being things that unprivileged
> processes can do but that "underprivileged"
> processes cannot. I personally think that
> this would make a spiffy LSM, but I don't
> buy it as an extension of the POSIX (draft)
> capability mechanism. Why? Because the
> capability mechanism deals with providing
> controls over the abilty to violate the
> traditional Unix security policy, as
> implemented in Linux. Adding "negative"
> privilege might not be a bad idea, but
> it is outside the scope of capabilities
> AND there is a mechanism (LSM) explicity
> in place for adding such restrictions.

I understand your point.  But if we want these under-privileges to
follow the same inheritance rules as the over-privileges provided by
capabilities (were it only to make things simpler to comprehend),
doesn't it make sense to implement them in the same framework?  Rather
than trying to reproduce the same rules in a different part of the
kernel, causing code reduplication which would eventually, inevitably,
fall out of sync...  I think it's easier for everyone if under- and
over-privileges are treated in a uniform fashion.  Perhaps that's not
what POSIX intended, but I don't think "not what was intended" is a
sufficient reason for backing away from something that might be
useful.  Do you have a specific problem in mind?

However, the suggestion makes sense: if I can't convince the Powers
That Be that implementing under-privileges with capabilities is a Good
Thing (and I can see that it will be a serious problem), I'll try the
LSM approach.

-- 
     David A. Madore
    (david.madore@ens.fr,
     http://www.madore.org/~david/ )
