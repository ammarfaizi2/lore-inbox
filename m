Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265211AbUITA6f@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265211AbUITA6f (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Sep 2004 20:58:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265222AbUITA6f
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Sep 2004 20:58:35 -0400
Received: from fmr12.intel.com ([134.134.136.15]:26562 "EHLO
	orsfmr001.jf.intel.com") by vger.kernel.org with ESMTP
	id S265211AbUITA6e (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Sep 2004 20:58:34 -0400
Subject: Re: hotplug e1000 failed after 32 times
From: Li Shaohua <shaohua.li@intel.com>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Andrew Morton <akpm@osdl.org>, lkml <linux-kernel@vger.kernel.org>,
       "David S. Miller" <davem@redhat.com>
In-Reply-To: <414B7470.4000703@pobox.com>
References: <1095396793.10407.9.camel@sli10-desk.sh.intel.com>
	 <20040916221406.1f3764e0.akpm@osdl.org>
	 <1095411933.10407.29.camel@sli10-desk.sh.intel.com>
	 <20040917161920.16d18333.akpm@osdl.org>  <414B7470.4000703@pobox.com>
Content-Type: text/plain
Message-Id: <1095641512.24333.8.camel@sli10-desk.sh.intel.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Mon, 20 Sep 2004 08:51:53 +0800
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2004-09-18 at 07:34, Jeff Garzik wrote:
> All this work and code for such an uncommon case??
> 
> First off, any settings which are _indexed_ are almost guaranteed 
> broken.  For reasons as we see here, and others.  Any 
> "setting_foo[board_number]" should be found and eliminated instead.
> 
> Even if you allocate and free board numbers as described, how precisely 
> do you propose to predict which settings belong to which hotplugged 
> board?  Look at the problem, and you realize that the board<->setting 
> association becomes effectively _random_ for any adapter not present at 
> modprobe time.
> 
> The best model is to set these settings via netlink/ethtool after 
> registering the interface, but before bringing it up.
I'm not familiar with the NIC driver, but this problem really is
annoying. The gurus, please consider a solution. It's not an uncommon
case. I believe it's common in a big system with hotplug support. I can
understand why the driver doesn't support more than 32 a card, but one
card with 32 times hotplug failed is a little ugly.

Thanks,
Shaohua

