Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030198AbVIVDOv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030198AbVIVDOv (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Sep 2005 23:14:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030197AbVIVDOv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Sep 2005 23:14:51 -0400
Received: from mail.dvmed.net ([216.237.124.58]:3496 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1030195AbVIVDOu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Sep 2005 23:14:50 -0400
Message-ID: <433221A1.5000600@pobox.com>
Date: Wed, 21 Sep 2005 23:14:41 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla Thunderbird 1.0.6-1.1.fc4 (X11/20050720)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Joshua Kwan <joshk@triplehelix.org>
CC: axboe@suse.de, Linux Kernel <linux-kernel@vger.kernel.org>,
       "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: SATA suspend-to-ram patch - merge?
References: <433104E0.4090308@triplehelix.org>
In-Reply-To: <433104E0.4090308@triplehelix.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: 0.0 (/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Joshua Kwan wrote:
> Is Jens' patch still relevant? If so, should it be rediffed and merged
> into mainline? It doesn't seem to cause any weird side-effects.
> 
> More importantly, I would be inclined to properly rediff Jens' patch and
> merge it into Debian 2.6.12 kernel sources if there aren't any such
> side-effects, since it benefits everyone using SATA and suspend-to-ram
> (that is, users of relatively modern laptops.)

Jens' patch is technical correct for SATA, but really we want to do more 
stuff at the SCSI layer (see James Bottomley's response to Jens' patch).

Unfortunately, this also implies that we have to figure out which SCSI 
devices are available to be power-managed, and which SCSI devices are on 
a shared bus that should never be suspended.

So currently we are in limbo...

	Jeff


