Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751552AbWIUVED@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751552AbWIUVED (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Sep 2006 17:04:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751556AbWIUVEC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Sep 2006 17:04:02 -0400
Received: from mx.pathscale.com ([64.160.42.68]:13977 "EHLO mx.pathscale.com")
	by vger.kernel.org with ESMTP id S1751552AbWIUVEB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Sep 2006 17:04:01 -0400
Subject: Re: Flushing writes to PCI devices
From: "Bryan O'Sullivan" <bos@serpentine.com>
To: Roland Dreier <rdreier@cisco.com>
Cc: Bill Waddington <william.waddington@beezmo.com>,
       linux-kernel@vger.kernel.org
In-Reply-To: <adavenhgcpw.fsf@cisco.com>
References: <fa.gbsNbubc34pqWPOxWCntrwUyt68@ifi.uio.no>
	 <Pine.LNX.4.44L0.0609201423480.7265-100000@iolanthe.rowland.org>
	 <fa.V4O8HKrhUddxYm5+ixVbyZzPybE@ifi.uio.no>
	 <6263h29e4o17ok032m8rv11p4u6547ngk0@4ax.com>
	 <1158862442.29551.22.camel@sardonyx>  <adavenhgcpw.fsf@cisco.com>
Content-Type: text/plain
Date: Thu, 21 Sep 2006 14:04:00 -0700
Message-Id: <1158872640.1996.9.camel@chalcedony.pathscale.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-09-21 at 13:56 -0700, Roland Dreier wrote:
>     Bryan> Yes.  If your device requires that writes to some locations
>     Bryan> in MMIO space be performed in a specific order, you must
>     Bryan> explicitly do this in your driver.  Intel CPUs will flush
>     Bryan> posted writes out of order, for example.
> 
> Really?  Just normal posted PCI writes without using MTRRs or
> write-combining or anything like that?

No, not normal writes, but if you're writing to an area where you've
enabled write combining, it will happen (but not IIRC on AMD x86_64
CPUs).  Sorry for the lack of clarity.

	<b

