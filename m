Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263798AbUFBSIe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263798AbUFBSIe (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Jun 2004 14:08:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263756AbUFBSId
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Jun 2004 14:08:33 -0400
Received: from zero.aec.at ([193.170.194.10]:15879 "EHLO zero.aec.at")
	by vger.kernel.org with ESMTP id S263815AbUFBSGJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Jun 2004 14:06:09 -0400
To: Alasdair G Kergon <agk@redhat.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 3/5: Device-mapper: snapshots
References: <22Gkd-1AX-17@gated-at.bofh.it>
From: Andi Kleen <ak@muc.de>
Date: Wed, 02 Jun 2004 20:06:06 +0200
In-Reply-To: <22Gkd-1AX-17@gated-at.bofh.it> (Alasdair G. Kergon's message
 of "Wed, 02 Jun 2004 18:00:29 +0200")
Message-ID: <m3r7sx6dip.fsf@averell.firstfloor.org>
User-Agent: Gnus/5.110003 (No Gnus v0.3) Emacs/21.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alasdair G Kergon <agk@redhat.com> writes:
> +
> +/*-----------------------------------------------------------------
> + * Persistent snapshots, by persistent we mean that the snapshot
> + * will survive a reboot.
> + *---------------------------------------------------------------*/

Is this target supposed to be crash safe? What happens when
the computer crashes while writing to such a volume?

I suppose it would need barriers for that at least, which it doesn't
seem to use.

-Andi

