Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267939AbUHUVsj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267939AbUHUVsj (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 21 Aug 2004 17:48:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267929AbUHUVsU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 21 Aug 2004 17:48:20 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:60328 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S267922AbUHUVrf
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 21 Aug 2004 17:47:35 -0400
Date: Sat, 21 Aug 2004 22:47:33 +0100
From: Matthew Wilcox <willy@debian.org>
To: James Bottomley <James.Bottomley@SteelEye.com>
Cc: Patrick Mansfield <patmans@us.ibm.com>,
       Mikael Pettersson <mikpe@csd.uu.se>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       SCSI Mailing List <linux-scsi@vger.kernel.org>
Subject: Re: 2.6.8.1-mm3
Message-ID: <20040821214733.GE9660@parcelfarce.linux.theplanet.co.uk>
References: <200408211838.i7LIcUdl025108@harpo.it.uu.se> <20040821191417.GA3402@beaverton.ibm.com> <1093116298.2092.388.camel@mulgrave>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1093116298.2092.388.camel@mulgrave>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 21, 2004 at 03:24:56PM -0400, James Bottomley wrote:
> Either we could provide a helper routine to do it and convert all the
> internal uses over, or we could define a new ioctl that is correctly
> unique, something like
> 
> #define SCSI_TEST_UNIT_READY	_IOR('S', 8, int)
> or perhaps just 0x5388
> 
> and convert the internal users over to it.
> 
> Opinions?

I prefer the former, something like

int scsi_test_unit_ready(struct scsi_device *sdev);

-- 
"Next the statesmen will invent cheap lies, putting the blame upon 
the nation that is attacked, and every man will be glad of those
conscience-soothing falsities, and will diligently study them, and refuse
to examine any refutations of them; and thus he will by and by convince 
himself that the war is just, and will thank God for the better sleep 
he enjoys after this process of grotesque self-deception." -- Mark Twain
