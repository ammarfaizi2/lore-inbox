Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264455AbTFEDEc (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Jun 2003 23:04:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264456AbTFEDEc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Jun 2003 23:04:32 -0400
Received: from dp.samba.org ([66.70.73.150]:19630 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id S264455AbTFEDEb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Jun 2003 23:04:31 -0400
Date: Thu, 5 Jun 2003 13:17:31 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Maciej <maciej@killer-robot.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: orinoco_cs module removal problem
Message-ID: <20030605031731.GE11914@zax>
Mail-Followup-To: David Gibson <david@gibson.dropbear.id.au>,
	Maciej <maciej@killer-robot.net>, linux-kernel@vger.kernel.org
References: <20030604175121.GA1709@apathy.black-flower>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030604175121.GA1709@apathy.black-flower>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 04, 2003 at 12:51:21PM -0500, Maciej wrote:
> I just switched from 2.5.68 to 2.5.70, and I'm having trouble removing
> the orinoco_cs module on the fly. After bringing the interface down,
> doing an "rmmod orinoco_cs" causes the rmmod process to lock up, and
> subseqeunt invocations of lsmod and 'cat /proc/modules' to do the same.
> I get a bunch of messages like the following in the kernel log:
> 
> "unregister_netdevice: waiting for eth2 to become free. Usage count = 1
> 
> However, eth2, the orinoco device, no longer exists (it's not listed
> in /proc/net/dev).

Yeah, that version of the driver is buggy.  I've already sent an
update to Linus, which is in current BK.

-- 
David Gibson			| For every complex problem there is a
david@gibson.dropbear.id.au	| solution which is simple, neat and
				| wrong.
http://www.ozlabs.org/people/dgibson
