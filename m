Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261724AbUDCMtg (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 3 Apr 2004 07:49:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261735AbUDCMtg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 3 Apr 2004 07:49:36 -0500
Received: from electric-eye.fr.zoreil.com ([213.41.134.224]:8064 "EHLO
	fr.zoreil.com") by vger.kernel.org with ESMTP id S261724AbUDCMtf
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 3 Apr 2004 07:49:35 -0500
Date: Sat, 3 Apr 2004 14:45:21 +0200
From: Francois Romieu <romieu@fr.zoreil.com>
To: Manfred Spraul <manfred@colorfullife.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       Adam Nielsen <a.nielsen@optushome.com.au>
Subject: Re: [PATCH] Fix kernel lockup in RTL-8169 gigabit ethernet driver
Message-ID: <20040403144521.B20457@electric-eye.fr.zoreil.com>
References: <406EA054.2020401@colorfullife.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <406EA054.2020401@colorfullife.com>; from manfred@colorfullife.com on Sat, Apr 03, 2004 at 01:30:28PM +0200
X-Organisation: Land of Sunshine Inc.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Manfred Spraul <manfred@colorfullife.com> :
[...]
> tx_left counts packets submitted by hard_xmit_start to the hardware. 
> Initially OWNbit is set, the packet is owned by the nic. The OWNbit is 
> cleared by the hardware after the packet was sent. A packet with OWNbit 
> set means that the nic didn't send it yet to the wire. I think the "else 
> break;" patch is correct, but someone with docs should confirm that.

Realtek Gigabit Ethernet Media Access Controller with power management R8169
Rev.1.21, p.54
[...]
Ownership: This bit, when set, indicates that the descriptor is owned by
the NIC. When cleared, it indicates that the descriptor is owned by the host
system. NIC clears this bit when the relative buffer data is already
transmitted. In this case, OWN=0.

[...]
> Perhaps gcc optimized away the reload from memory and loops on a 

Point taken.

--
Ueimor
