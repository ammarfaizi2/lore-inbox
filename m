Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262282AbTIZOin (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Sep 2003 10:38:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262308AbTIZOin
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Sep 2003 10:38:43 -0400
Received: from jurassic.park.msu.ru ([195.208.223.243]:30724 "EHLO
	jurassic.park.msu.ru") by vger.kernel.org with ESMTP
	id S262282AbTIZOim (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Sep 2003 10:38:42 -0400
Date: Fri, 26 Sep 2003 18:38:27 +0400
From: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
To: "David S. Miller" <davem@redhat.com>
Cc: Manfred Spraul <manfred@colorfullife.com>, linux-kernel@vger.kernel.org
Subject: Re: NS83820 2.6.0-test5 driver seems unstable on IA64
Message-ID: <20030926183827.A821@jurassic.park.msu.ru>
References: <3F73D9C4.1050201@colorfullife.com> <20030925230702.4ef87780.davem@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20030925230702.4ef87780.davem@redhat.com>; from davem@redhat.com on Thu, Sep 25, 2003 at 11:07:02PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 25, 2003 at 11:07:02PM -0700, David S. Miller wrote:
> On Fri, 26 Sep 2003 08:16:36 +0200
> Manfred Spraul <manfred@colorfullife.com> wrote:
> 
> > Is that really the right solution? Add a full-packet copy to every driver?
> 
> In the short term, yes it is.

What about aligning the packet directly in the rx buffer (by memmoving
the entire packet to buf+2) instead of copying to another skb?
This appears to be a) more than 2 times faster b) easy to implement.

Ivan.
