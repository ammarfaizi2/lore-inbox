Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263775AbUFCOId@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263775AbUFCOId (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Jun 2004 10:08:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263807AbUFCOId
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Jun 2004 10:08:33 -0400
Received: from unthought.net ([212.97.129.88]:56006 "EHLO unthought.net")
	by vger.kernel.org with ESMTP id S263775AbUFCOIb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Jun 2004 10:08:31 -0400
Date: Thu, 3 Jun 2004 16:08:30 +0200
From: Jakob Oestergaard <jakob@unthought.net>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Michael De Nil <michael@flex-it.be>, linux-kernel@vger.kernel.org
Subject: Re: Promise PDC20378 Raid Accelerator
Message-ID: <20040603140829.GB30687@unthought.net>
Mail-Followup-To: Jakob Oestergaard <jakob@unthought.net>,
	Jeff Garzik <jgarzik@pobox.com>, Michael De Nil <michael@flex-it.be>,
	linux-kernel@vger.kernel.org
References: <Pine.LNX.4.56.0406012040380.6191@lisa.flex-it.be> <40BD1032.604@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <40BD1032.604@pobox.com>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 01, 2004 at 07:24:34PM -0400, Jeff Garzik wrote:
> Michael De Nil wrote:
> >Can someone tell me if I will be able to run 2 SATA discs on a raid1 with
> >this chip, and if yes, what driver you would prefer? I am a litle bit
> >afraid for using non-stable drivers... ;)
> 
> 
> The all-open-source solution...  Linux "md" raid, and Linux SATA drivers :)

One caveat: you *may* have to create "one disk RAID-0" arrays of your
disks (which is equivalent to the single disk), in order to make the
SATA controller boot from the disk.  So, with two disks, you would
create two RAID-0 arrays, each containing one disk.  Silly really, but
at least I had to do this with the Promise TX4.

Other than that; Standard Linux SATA drivers + Software RAID + LVM2 is a
beautiful all-open-source solution for cheap flexible and reliable
storage  -  my mom is using that   ;)

-- 

 / jakob

