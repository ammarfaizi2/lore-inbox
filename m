Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261622AbUKENSM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261622AbUKENSM (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Nov 2004 08:18:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262678AbUKENRW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Nov 2004 08:17:22 -0500
Received: from rproxy.gmail.com ([64.233.170.203]:60630 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262683AbUKENQI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Nov 2004 08:16:08 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=tF1V75SbegjXUn8KLstNj77oz+sAvpNItyyoeoVZUxc6aQIxfs+PiNkeboIQFiiv8ufJZX/FqBPVs09NHjzRR74h4edwlOE3ebkjXdIvUnuUnLSbYzFs1UiWiSTHEhUBMWEBs6Q03xrSB1ROsdlMAAVACtzd5KiMOpK4gpdxZTo=
Message-ID: <58cb370e041105051635c15281@mail.gmail.com>
Date: Fri, 5 Nov 2004 14:16:05 +0100
From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Reply-To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
To: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH] IDE remove some cruft from ide.h
Cc: Chris Wedgwood <cw@f00f.org>, LKML <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
In-Reply-To: <418AE8C0.3040205@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <20041103091101.GC22469@taniwha.stupidest.org>
	 <418AE8C0.3040205@pobox.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 04 Nov 2004 21:43:12 -0500, Jeff Garzik <jgarzik@pobox.com> wrote:
> Bart, Chris's two patches are OK with me.  If you agree, then please
> merge them up into your ide-2.6 queue.

OK (but I will leave SECTOR_[SIZE, WORDS] for
now as this change depends on the other patch).

> Chris, a useful follow-up patch (if Bart agrees) is a global
> search-n-replace of WIN_xxx constants with ATA_CMD_xxx constants.
> Depending on the size of the patch, it might even need to be split up
> across several patches.

One ceveat here: hdreg.h and WIN_xxx are (ab)used by user-space
so for sure there will be complaints (not that we should care :)...

Bartlomiej
