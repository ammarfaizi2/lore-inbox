Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932521AbVLETSs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932521AbVLETSs (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Dec 2005 14:18:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932519AbVLETSs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Dec 2005 14:18:48 -0500
Received: from styx.suse.cz ([82.119.242.94]:56271 "EHLO mail.suse.cz")
	by vger.kernel.org with ESMTP id S932518AbVLETSr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Dec 2005 14:18:47 -0500
Date: Mon, 5 Dec 2005 20:18:46 +0100
From: Jiri Benc <jbenc@suse.cz>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Joseph Jezak <josejx@gentoo.org>, mbuesch@freenet.de,
       linux-kernel@vger.kernel.org, bcm43xx-dev@lists.berlios.de,
       NetDev <netdev@vger.kernel.org>
Subject: Re: Broadcom 43xx first results
Message-ID: <20051205201846.5fa5eb5a@griffin.suse.cz>
In-Reply-To: <4394902C.8060100@pobox.com>
References: <E1Eiyw4-0003Ab-FW@www1.emo.freenet-rz.de>
	<20051205190038.04b7b7c1@griffin.suse.cz>
	<4394892D.2090100@gentoo.org>
	<20051205195543.5a2e2a8d@griffin.suse.cz>
	<4394902C.8060100@pobox.com>
X-Mailer: Sylpheed-Claws 1.0.4a (GTK+ 1.2.10; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 05 Dec 2005 14:08:28 -0500, Jeff Garzik wrote:
> Patently false.
> 
> ieee80211 is used by Intel.  Some bits used by HostAP, which also 
> duplicates a lot of ieee80211 code.  And bcm43xx.  And another couple 
> drivers found in -mm or out-of-tree.

Hostap uses only encryption code, which was copied from - guess who -
hostap. Everything other must be done by the hostap driver itself.

bcm43xx can use - like every other driver - only constants and defines
from ieee80211.h. This is the reason why they are trying to implement
"softmac" on top of it. But that work was already done by Jouni.

> > of a wifi driver tries to implement his own "softmac" now. I cannot see
> > how this can move as forward and I think we can agree this is not the
> > way to go.
> 
> You're agreeing with only yourself, then?

I meant that every driver tries to implements its own "softmac". This is
not the way to go, right?

> > Rewriting (or, if you like, enhancing) the current 802.11 code seems to
> > be wasting of time now, when nearly complete Linux stack was opensourced
> > by Devicescape. We can try to merge it, but I'm not convinced it is
> > possible, the Devicescape's stack is far more advanced.
> 
> This invalid logic is why we have a ton of wireless stacks, all 
> duplicating each other.

Heh? We have one nearly finished stack (and no, it's not the one in
kernel). Why should we try to implement a new stack instead of fixing
some issues of the nearly finished one?


-- 
Jiri Benc
SUSE Labs
