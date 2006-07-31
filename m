Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030197AbWGaPdW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030197AbWGaPdW (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Jul 2006 11:33:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030195AbWGaPdW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Jul 2006 11:33:22 -0400
Received: from smtprelay01.ispgateway.de ([80.67.18.13]:7393 "EHLO
	smtprelay01.ispgateway.de") by vger.kernel.org with ESMTP
	id S1030193AbWGaPdV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Jul 2006 11:33:21 -0400
From: Ingo Oeser <ioe-lkml@rameria.de>
To: NeilBrown <neilb@suse.de>
Subject: Re: [PATCH 005 of 9] md: Replace magic numbers in sb_dirty with well defined bit flags
Date: Mon, 31 Jul 2006 17:33:11 +0200
User-Agent: KMail/1.9.3
Cc: Andrew Morton <akpm@osdl.org>, linux-raid@vger.kernel.org,
       linux-kernel@vger.kernel.org
References: <20060731172842.24323.patches@notabene> <1060731073218.24482@suse.de>
In-Reply-To: <1060731073218.24482@suse.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200607311733.12848.ioe-lkml@rameria.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Neil,

I think the names in this patch don't match the description at all.
May I suggest different ones?

On Monday, 31. July 2006 09:32, NeilBrown wrote:
> 
> Instead of magic numbers (0,1,2,3) in sb_dirty, we have
> some flags instead:
> MD_CHANGE_DEVS
>    Some device state has changed requiring superblock update
>    on all devices.

MD_SB_STALE or MD_SB_NEED_UPDATE

> MD_CHANGE_CLEAN
>    The array has transitions from 'clean' to 'dirty' or back,
>    requiring a superblock update on active devices, but possibly
>    not on spares

Maybe split this into MD_SB_DIRTY and MD_SB_CLEAN ?

> MD_CHANGE_PENDING
>    A superblock update is underway.  

MD_SB_PENDING_UPDATE


Regards

Ingo Oeser
