Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267368AbUJNUXT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267368AbUJNUXT (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Oct 2004 16:23:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267180AbUJNSrf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Oct 2004 14:47:35 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:10629 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S267189AbUJNSHt
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Oct 2004 14:07:49 -0400
Date: Thu, 14 Oct 2004 19:07:48 +0100
From: Matthew Wilcox <matthew@wil.cx>
To: Christoph Hellwig <hch@infradead.org>, Matthew Wilcox <matthew@wil.cx>,
       Greg KH <greg@kroah.com>, linux-pci@atrey.karlin.mff.cuni.cz,
       linux-kernel@vger.kernel.org, linux-ia64@vger.kernel.org
Subject: Re: [PATCH] Introduce PCI <-> CPU address conversion [1/2]
Message-ID: <20041014180748.GS16153@parcelfarce.linux.theplanet.co.uk>
References: <20041014124737.GM16153@parcelfarce.linux.theplanet.co.uk> <20041014125348.GA9633@infradead.org> <20041014135323.GO16153@parcelfarce.linux.theplanet.co.uk> <20041014180005.GA11954@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041014180005.GA11954@infradead.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 14, 2004 at 07:00:06PM +0100, Christoph Hellwig wrote:
> For some architectures the sysdata is different for bus vs device, so
> yes, we do want strict typechecking.

How interesting.  I was under the impression that dev->sysdata was always
a copy of the bus's.  If that's not guaranteed, then we're just going
to have to dereference the additional pointer and use the bus' sysdata.

-- 
"Next the statesmen will invent cheap lies, putting the blame upon 
the nation that is attacked, and every man will be glad of those
conscience-soothing falsities, and will diligently study them, and refuse
to examine any refutations of them; and thus he will by and by convince 
himself that the war is just, and will thank God for the better sleep 
he enjoys after this process of grotesque self-deception." -- Mark Twain
