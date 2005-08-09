Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964940AbVHIVFi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964940AbVHIVFi (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Aug 2005 17:05:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964967AbVHIVFh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Aug 2005 17:05:37 -0400
Received: from nef2.ens.fr ([129.199.96.40]:48399 "EHLO nef2.ens.fr")
	by vger.kernel.org with ESMTP id S964940AbVHIVFQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Aug 2005 17:05:16 -0400
Date: Tue, 9 Aug 2005 23:05:05 +0200
From: David Madore <david.madore@ens.fr>
To: Linux Kernel mailing-list <linux-kernel@vger.kernel.org>
Cc: 7eggert@gmx.de, Chris Wright <chrisw@osdl.org>
Subject: Re: capabilities patch (v 0.1)
Message-ID: <20050809210505.GA16404@clipper.ens.fr>
References: <4zuQJ-20d-11@gated-at.bofh.it> <4zv0l-2b8-11@gated-at.bofh.it> <E1E2aaq-0002WB-Tj@be1.lrz> <20050809205206.GW7762@shell0.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050809205206.GW7762@shell0.pdx.osdl.net>
User-Agent: Mutt/1.5.9i
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.5.10 (nef2.ens.fr [129.199.96.32]); Tue, 09 Aug 2005 23:05:06 +0200 (CEST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 09, 2005 at 01:52:06PM -0700, Chris Wright wrote:
> * Bodo Eggert (harvested.in.lkml@7eggert.dyndns.org) wrote:
> > How are you going to tell processes that may exec suid (or set-capability-)
> > programs from those that aren't supposed to gain certain capabilities?
> 
> typically you'd expect exec suid will reset to full caps.

suid exec _must_ reset to full caps or we have the sendmail disaster
again.  However, that is _if_ execve() succeeds.  It is quite possible
that execve() should fail, and that is precisely what my patch does:
if a process has bounded capabilities, it _may not_ exec suid.

-- 
     David A. Madore
    (david.madore@ens.fr,
     http://www.madore.org/~david/ )
