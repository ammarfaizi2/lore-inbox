Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268022AbUHKKpO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268022AbUHKKpO (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Aug 2004 06:45:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268021AbUHKKpO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Aug 2004 06:45:14 -0400
Received: from imladris.demon.co.uk ([193.237.130.41]:31502 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S268020AbUHKKo5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Aug 2004 06:44:57 -0400
Date: Wed, 11 Aug 2004 11:44:37 +0100
From: Christoph Hellwig <hch@infradead.org>
To: James Ketrenos <jketreno@linux.intel.com>
Cc: Pavel Machek <pavel@suse.cz>, Christoph Hellwig <hch@infradead.org>,
       Jeff Chua <jeffchua@silk.corp.fedex.com>,
       Tomas Szepe <szepe@pinerecords.com>, netdev@oss.sgi.com,
       kernel list <linux-kernel@vger.kernel.org>
Subject: Re: ipw2100 wireless driver
Message-ID: <20040811114437.A27439@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	James Ketrenos <jketreno@linux.intel.com>,
	Pavel Machek <pavel@suse.cz>,
	Jeff Chua <jeffchua@silk.corp.fedex.com>,
	Tomas Szepe <szepe@pinerecords.com>, netdev@oss.sgi.com,
	kernel list <linux-kernel@vger.kernel.org>
References: <20040714114135.GA25175@elf.ucw.cz> <Pine.LNX.4.60.0407141947270.27995@boston.corp.fedex.com> <20040714115523.GC2269@elf.ucw.cz> <20040809201556.GB9677@louise.pinerecords.com> <Pine.LNX.4.61.0408101258130.1290@boston.corp.fedex.com> <20040810075558.A14154@infradead.org> <20040810101640.GF9034@atrey.karlin.mff.cuni.cz> <4119F203.1070009@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <4119F203.1070009@linux.intel.com>; from jketreno@linux.intel.com on Wed, Aug 11, 2004 at 05:16:35AM -0500
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by phoenix.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 11, 2004 at 05:16:35AM -0500, James Ketrenos wrote:
> We're currently working to clean up ipw2100 and ieee80211 code for submission to 
> netdev for discussion and hopefully inclusion in the future.  The ieee80211 code 
> is still being heavily developed, but its usable.  If anyone wants to help out, 
> or if folks feel its ready as-is to get pulled into wireless-2.6, let me know.

Maybe we should switch to your ieee802.11 for a generic wireless stack then
instead of the original hostap code.  At least it seems more actively
maintained right now and supports two drivers already.

Btw, I've looked at the ipw2100 and have to concerns regarding the firmware,

 a) yo'ure not using the proper firmware loader but some horrible
    handcrafted code using sys_open/sys_read & co that's not namespace
    safe at all
 b) the firmware has an extremly complicated and hard to comply with license,
    I'm not sure we want a driver that can't work without a so strangely
    licensed blob in the kernel. Can you talk to intel lawyers and put it on
    simple redristribution and binary modification for allowed for all purposes
    license please?
    

 
> Thanks,
> James
> 
> 
> 
---end quoted text---
