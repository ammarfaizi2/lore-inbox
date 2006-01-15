Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751600AbWAOB4H@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751600AbWAOB4H (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 14 Jan 2006 20:56:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751609AbWAOB4G
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 14 Jan 2006 20:56:06 -0500
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:16788
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S1750842AbWAOB4F (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 14 Jan 2006 20:56:05 -0500
Date: Sat, 14 Jan 2006 17:51:40 -0800 (PST)
Message-Id: <20060114.175140.07007614.davem@davemloft.net>
To: jgarzik@pobox.com
Cc: linville@tuxdriver.com, netdev@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: wireless: recap of current issues (other issues)
From: "David S. Miller" <davem@davemloft.net>
In-Reply-To: <43C97693.7000109@pobox.com>
References: <20060113213237.GH16166@tuxdriver.com>
	<20060113222408.GM16166@tuxdriver.com>
	<43C97693.7000109@pobox.com>
X-Mailer: Mew version 4.2.53 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jeff Garzik <jgarzik@pobox.com>
Date: Sat, 14 Jan 2006 17:09:23 -0500

> A big open issue:  should you fake ethernet, or represent 802.11 
> natively throughout the rest of the net stack?
> 
> The former causes various and sundry hacks, and the latter requires that 
> you touch a bunch of non-802.11 code to make it aware of a new frame class.

The former, most importantly, can cause the packet to get copied.
Actually, this depends upon how you implement things and when the
header change occurs.

My vote is for making the whole of the networking 802.11 frame class
aware.
