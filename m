Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262730AbUGFCRv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262730AbUGFCRv (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Jul 2004 22:17:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262756AbUGFCRv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Jul 2004 22:17:51 -0400
Received: from lists.us.dell.com ([143.166.224.162]:23638 "EHLO
	lists.us.dell.com") by vger.kernel.org with ESMTP id S262730AbUGFCRu
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Jul 2004 22:17:50 -0400
Date: Mon, 5 Jul 2004 21:17:38 -0500
From: Matt Domsch <Matt_Domsch@dell.com>
To: Meelis Roos <mroos@linux.ee>
Cc: Linux Kernel list <linux-kernel@vger.kernel.org>, akpm@osdl.org
Subject: Re: EDD unknown symbols in 2.6.7+BK
Message-ID: <20040706021738.GA20540@lists.us.dell.com>
References: <Pine.GSO.4.44.0407060001560.18649-100000@math.ut.ee>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.GSO.4.44.0407060001560.18649-100000@math.ut.ee>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 06, 2004 at 12:03:12AM +0300, Meelis Roos wrote:
> WARNING: /lib/modules/2.6.7/build/arch/i386/kernel/edd.ko needs unknown symbol eddnr
> WARNING: /lib/modules/2.6.7/build/arch/i386/kernel/edd.ko needs unknown symbol edd_disk80_sig

Wow.  That module moved from arch/i386/kernel/ to drivers/firmware
a few months ago.  It would have broken with BK this week as
those symbols were removed and merged into a single 'edd' exported
object.

I recommend doing a 'bk -r co -q', make clean, make oldconfig, to
clean up your copy of the tree.

Thanks,
Matt

-- 
Matt Domsch
Sr. Software Engineer, Lead Engineer
Dell Linux Solutions linux.dell.com & www.dell.com/linux
Linux on Dell mailing lists @ http://lists.us.dell.com
