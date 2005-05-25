Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261517AbVEYSBE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261517AbVEYSBE (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 May 2005 14:01:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261500AbVEYSBB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 May 2005 14:01:01 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:29147 "EHLO
	parcelfarce.linux.theplanet.co.uk") by vger.kernel.org with ESMTP
	id S261517AbVEYSAj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 May 2005 14:00:39 -0400
Date: Wed, 25 May 2005 19:01:06 +0100
From: Matthew Wilcox <matthew@wil.cx>
To: James Bottomley <James.Bottomley@SteelEye.com>
Cc: Hannes Reinecke <hare@suse.de>,
       SCSI Mailing List <linux-scsi@vger.kernel.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       "Moore, Eric Dean" <Eric.Moore@lsil.com>
Subject: Re: [PATCH] Fix reference counting for failed SCSI devices
Message-ID: <20050525180106.GB14929@parcelfarce.linux.theplanet.co.uk>
References: <4292F631.9090300@suse.de> <1116975478.7710.28.camel@mulgrave> <4294201D.4070304@suse.de> <1117024043.5071.6.camel@mulgrave> <429473A1.6010402@suse.de> <1117033088.4956.5.camel@mulgrave> <429496C2.3020706@suse.de> <1117043489.5210.4.camel@mulgrave>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1117043489.5210.4.camel@mulgrave>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 25, 2005 at 01:51:29PM -0400, James Bottomley wrote:
> Large segments of the aic79xx driver are identical to the aic7xxx driver
> except that all the functions being ahd_ instead of ahc_, so you should
> just be able to mirror quite a lot of the aic7xxx updates.  However, you
> need to include a large number of rather nasty u320 parameters in the
> SPI transport Class (and make sure they're coupled correctly) to get
> domain validation to work ... the transport class has also only been
> tested on speeds up to u160, so going to u320 will be a first for it
> too...

I wonder if LSI have any preliminary work in that area for the Fusion
driver.  Eric?

-- 
"Next the statesmen will invent cheap lies, putting the blame upon 
the nation that is attacked, and every man will be glad of those
conscience-soothing falsities, and will diligently study them, and refuse
to examine any refutations of them; and thus he will by and by convince 
himself that the war is just, and will thank God for the better sleep 
he enjoys after this process of grotesque self-deception." -- Mark Twain
