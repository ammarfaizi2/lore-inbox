Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269260AbUISQF0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269260AbUISQF0 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Sep 2004 12:05:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269261AbUISQFZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Sep 2004 12:05:25 -0400
Received: from ip214-49.coastside.net ([207.213.214.33]:23755 "EHLO
	jlundell.local") by vger.kernel.org with ESMTP id S269260AbUISQFS
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Sep 2004 12:05:18 -0400
Mime-Version: 1.0
Message-Id: <p06110429bd735d9afd46@[10.2.4.30]>
In-Reply-To: <414B7470.4000703@pobox.com>
References: <1095396793.10407.9.camel@sli10-desk.sh.intel.com>
 <20040916221406.1f3764e0.akpm@osdl.org>
 <1095411933.10407.29.camel@sli10-desk.sh.intel.com>
 <20040917161920.16d18333.akpm@osdl.org> <414B7470.4000703@pobox.com>
Date: Sun, 19 Sep 2004 09:04:40 -0700
To: Jeff Garzik <jgarzik@pobox.com>, Andrew Morton <akpm@osdl.org>
From: Jonathan Lundell <linux@lundell-bros.com>
Subject: Re: hotplug e1000 failed after 32 times
Cc: Li Shaohua <shaohua.li@intel.com>, linux-kernel@vger.kernel.org,
       "David S. Miller" <davem@redhat.com>
Content-Type: text/plain; charset="us-ascii" ; format="flowed"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 7:34 PM -0400 9/17/04, Jeff Garzik wrote:
>Even if you allocate and free board numbers as described, how 
>precisely do you propose to predict which settings belong to which 
>hotplugged board?  Look at the problem, and you realize that the 
>board<->setting association becomes effectively _random_ for any 
>adapter not present at modprobe time.
>
>The best model is to set these settings via netlink/ethtool after 
>registering the interface, but before bringing it up.

It's certainly true that the driver-local index isn't usable for the 
association (not even if one remembers, say, the slot association, 
since a card can presumably be moved).

Out of curiosity, though, isn't there a residual related problem, in 
that a reinserted card gets a new eth# as well? Not insurmountable, I 
suppose, but a bitch to automate.
-- 
/Jonathan Lundell.
