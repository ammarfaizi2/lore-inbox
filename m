Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964878AbWFNFSg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964878AbWFNFSg (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Jun 2006 01:18:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964876AbWFNFSg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Jun 2006 01:18:36 -0400
Received: from ns.suse.de ([195.135.220.2]:7371 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S964874AbWFNFSf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Jun 2006 01:18:35 -0400
From: Andi Kleen <ak@suse.de>
To: David Miller <davem@davemloft.net>
Subject: Re: 2.6.17: networking bug??
Date: Wed, 14 Jun 2006 07:18:21 +0200
User-Agent: KMail/1.9.3
Cc: lkml@rtr.ca, jheffner@psc.edu, torvalds@osdl.org,
       linux-kernel@vger.kernel.org, netdev@vger.kernel.org
References: <Pine.LNX.4.64.0606131048550.5498@g5.osdl.org> <448F0D4B.30201@rtr.ca> <20060613.142603.48825062.davem@davemloft.net>
In-Reply-To: <20060613.142603.48825062.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200606140718.21609.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Also, as John Heffner mentioned, even if we could detect the broken
> boxes you can't just "turn off window scaling" after it's been
> negotiated.  It's immutably active for the entire connection once
> enabled.

In theory you could set a bit in the dst entry and not use it next time
you connect to that host. That would be ok for web browsing at least
when creates new connections all the time.

But it's unclear how to even detect this situation reliably

e.g. you don't want to disable it just because there was a bit of 
packet loss on a connection to a particular host earlier and there
is no clear heuristic to detect that this particular problem happened.
 
> So the broken boxes, which to be honest are few and far between these
> days, need to go, they really do.

Agreed.

-Andi
