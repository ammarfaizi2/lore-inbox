Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265029AbUJNNx2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265029AbUJNNx2 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Oct 2004 09:53:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265044AbUJNNx2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Oct 2004 09:53:28 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:19670 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S265029AbUJNNxY
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Oct 2004 09:53:24 -0400
Date: Thu, 14 Oct 2004 14:53:23 +0100
From: Matthew Wilcox <matthew@wil.cx>
To: Christoph Hellwig <hch@infradead.org>, Matthew Wilcox <matthew@wil.cx>,
       Greg KH <greg@kroah.com>, linux-pci@atrey.karlin.mff.cuni.cz,
       linux-kernel@vger.kernel.org, linux-ia64@vger.kernel.org
Subject: Re: [PATCH] Introduce PCI <-> CPU address conversion [1/2]
Message-ID: <20041014135323.GO16153@parcelfarce.linux.theplanet.co.uk>
References: <20041014124737.GM16153@parcelfarce.linux.theplanet.co.uk> <20041014125348.GA9633@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041014125348.GA9633@infradead.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 14, 2004 at 01:53:48PM +0100, Christoph Hellwig wrote:
> I'd rather have this declared in every architectures asm/ header, so it's
> more explicit that it's an per-arch thing.  Also make it a static inline
> so we get typechecking.

I actually don't want typechecking.  Sometimes you have a device and
sometimes you have a bus.  You can get everything you want (sysdata)
from either, so there's no point in doing dev->bus when all you needed
was right there.

-- 
"Next the statesmen will invent cheap lies, putting the blame upon 
the nation that is attacked, and every man will be glad of those
conscience-soothing falsities, and will diligently study them, and refuse
to examine any refutations of them; and thus he will by and by convince 
himself that the war is just, and will thank God for the better sleep 
he enjoys after this process of grotesque self-deception." -- Mark Twain
