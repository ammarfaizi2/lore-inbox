Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261677AbVAMPqP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261677AbVAMPqP (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Jan 2005 10:46:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261686AbVAMPmw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Jan 2005 10:42:52 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:24279 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S261649AbVAMPhX
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Jan 2005 10:37:23 -0500
Date: Thu, 13 Jan 2005 10:09:00 -0200
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
To: Scott Doty <scott@sonic.net>
Cc: linux-kernel@vger.kernel.org, davem@redhat.com,
       Herbert Xu <herbert@gondor.apana.org.au>
Subject: Re: 2.4.28(+?): Strange ARP problem
Message-ID: <20050113120900.GA5681@logos.cnet>
References: <20050113145029.GA22622@sonic.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050113145029.GA22622@sonic.net>
User-Agent: Mutt/1.5.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 13, 2005 at 06:50:29AM -0800, Scott Doty wrote:
> Hi,
> 
> We use Linux extensively here at Sonic.net.  Our web servers have two
> NIC's -- a NIC with a public IP address, and a NIC on our SAN (with NetApps).
> 
> When we tried to upgrade to 2.4.28, we encountered a problem with NetApp
> reachability, which turns out to have been a problem with ARP:  we
> were seeing two ARP entries for the NetApp IP's.  One would be correct, and
> one would be "incomplete".
> 
> Occasionally, a system would glom onto the incomplete entry, and NFS
> connectivity would tank.  This doesn't happen with 2.4.27.
> 
> We'd like to upgrade to 2.4.29-rc2, but we have much trepidation about doing
> so.  I certainly don't want to treat the list as "our own personal help
> desk" (as warned about in the FAQ), but was hoping someone could shed some
> light on the problem.  I think either myself or one of our guys can write a
> patch to fix it, if someone would point us in the right direction.
> 
> Thank you,

Scott, 

I have no idea of what might be causing such regression - I see a few ARP
related changelogs on v2.4.28-rc2:

  o [IPV4]: Set ARP hw type correctly for BOOTP over FDDI
  o [IPV4]: Permit the official ARP hw type in SIOCSARP for FDDI

Maybe you can try earlier v2.4.28's (-rc1 for one) to check where 
the problem starts to happen?

David, Herbert, any ideas?


