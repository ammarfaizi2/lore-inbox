Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751418AbVLESzp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751418AbVLESzp (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Dec 2005 13:55:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751416AbVLESzp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Dec 2005 13:55:45 -0500
Received: from styx.suse.cz ([82.119.242.94]:64200 "EHLO mail.suse.cz")
	by vger.kernel.org with ESMTP id S1751409AbVLESzo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Dec 2005 13:55:44 -0500
Date: Mon, 5 Dec 2005 19:55:43 +0100
From: Jiri Benc <jbenc@suse.cz>
To: Joseph Jezak <josejx@gentoo.org>
Cc: mbuesch@freenet.de, linux-kernel@vger.kernel.org,
       bcm43xx-dev@lists.berlios.de, NetDev <netdev@vger.kernel.org>
Subject: Re: Broadcom 43xx first results
Message-ID: <20051205195543.5a2e2a8d@griffin.suse.cz>
In-Reply-To: <4394892D.2090100@gentoo.org>
References: <E1Eiyw4-0003Ab-FW@www1.emo.freenet-rz.de>
	<20051205190038.04b7b7c1@griffin.suse.cz>
	<4394892D.2090100@gentoo.org>
X-Mailer: Sylpheed-Claws 1.0.4a (GTK+ 1.2.10; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 05 Dec 2005 13:38:37 -0500, Joseph Jezak wrote:
> We're not writing an entire stack.  We're writing a layer that sits in 
> between the current ieee80211 stack that's already present in the kernel 
> and drivers that do not have a hardware MAC.  Since ieee80211 is already 
> in use in the kernel today, this seemed like a natural and useful 
> extension to the existing code.  I agree that it's somewhat wasteful to 
> keep rewriting 802.11 stacks and we considered other options, but it 
> seemed like a more logical choice to work with what was available and 
> recommended than to use an external stack.

Unfortunately, the only long-term solution is to rewrite completely the
current in-kernel ieee80211 code (I would not call it a "stack") or
replace it with something another. The current code was written for
Intel devices and it doesn't support anything else - so every developer
of a wifi driver tries to implement his own "softmac" now. I cannot see
how this can move as forward and I think we can agree this is not the
way to go.

Rewriting (or, if you like, enhancing) the current 802.11 code seems to
be wasting of time now, when nearly complete Linux stack was opensourced
by Devicescape. We can try to merge it, but I'm not convinced it is
possible, the Devicescape's stack is far more advanced.


-- 
Jiri Benc
SUSE Labs
