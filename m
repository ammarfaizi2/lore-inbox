Return-Path: <linux-kernel-owner+w=401wt.eu-S964970AbWL1Ic2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964970AbWL1Ic2 (ORCPT <rfc822;w@1wt.eu>);
	Thu, 28 Dec 2006 03:32:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964976AbWL1Ic2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Dec 2006 03:32:28 -0500
Received: from pne-smtpout2-sn1.fre.skanova.net ([81.228.11.159]:56166 "EHLO
	pne-smtpout2-sn1.fre.skanova.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S964970AbWL1Ic1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Dec 2006 03:32:27 -0500
X-Greylist: delayed 4164 seconds by postgrey-1.27 at vger.kernel.org; Thu, 28 Dec 2006 03:32:27 EST
To: balagi@justmail.de
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
       "akpm@osdl.org" <akpm@osdl.org>, axboe@kernel.dk
Subject: Re: [PATCH 1/1] 2.6.20-rc1-mm1 pktcdvd: cleanup
References: <op.tk78gghciudtyh@master>
From: Peter Osterlund <petero2@telia.com>
Date: 28 Dec 2006 08:21:42 +0100
In-Reply-To: <op.tk78gghciudtyh@master>
Message-ID: <m3irfwo589.fsf@telia.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Thomas Maier" <balagi@justmail.de> writes:

> this is a patch to cleanup some things in the pktcdvd driver for linux 2.6.20:
> 
> - update documentation
> - removed DECLARE_BUF_AS_STRING macro

This part looks good.

> - use clear_bdi_congested/set_bdi_congested functions directly instead of old wrappers

I'm unsure about this one. What's the point of having the
blk_clear_queue_congested()/blk_set_queue_congested() functions if
they are not supposed to be used?

-- 
Peter Osterlund - petero2@telia.com
http://web.telia.com/~u89404340
