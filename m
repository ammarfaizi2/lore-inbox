Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262160AbVEERim@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262160AbVEERim (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 May 2005 13:38:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262162AbVEERil
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 May 2005 13:38:41 -0400
Received: from hera.cwi.nl ([192.16.191.8]:37256 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id S262160AbVEERig (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 May 2005 13:38:36 -0400
Date: Thu, 5 May 2005 19:38:23 +0200
From: Andries Brouwer <Andries.Brouwer@cwi.nl>
To: Chris Wright <chrisw@osdl.org>
Cc: James Dingwall <james.dingwall@cramer.com>,
       "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>,
       stable@kernel.org, Andries.Brouwer@cwi.nl
Subject: Re: Bug: 2.6.11.8 msdos.c
Message-ID: <20050505173823.GE2366@apps.cwi.nl>
References: <3E116F19B784CD47A7CE7F923A436499014C8E35@s2.cramer.co.uk> <20050505165446.GS18917@shell0.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050505165446.GS18917@shell0.pdx.osdl.net>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 05, 2005 at 09:54:46AM -0700, Chris Wright wrote:

> * James Dingwall (james.dingwall@cramer.com) wrote:
> > Using vanilla 2.6.11.8 I get a "Cannot open initial console" on boot,
> > 2.6.11.7 was fine.  I have removed the patches to fs/partitions/msdos.c and
> > this has fixed my problem.  I've read the discussion on this patch but it
> > doesn't indicate that this problem may occur so there is no suggested
> > solution.  I have attached my .config and my partition layout is below

The solution is to change the type of your /dev/hda[59] to something nonzero.

> > # fdisk -l /dev/hda
> > 
> > Disk /dev/hda: 30.0 GB, 30020272128 bytes
> > 255 heads, 63 sectors/track, 3649 cylinders
> > Units = cylinders of 16065 * 512 = 8225280 bytes
> > 
> >    Device Boot      Start         End      Blocks   Id  System
> > /dev/hda1   *           1        1797    14434371   83  Linux
> > /dev/hda2            1798        3649    14876190    5  Extended
> > /dev/hda5            1798        1860      506016    0  Empty
> > /dev/hda6            1861        1892      257008+  83  Linux
> > /dev/hda7            1893        1924      257008+  83  Linux
> > /dev/hda8            1925        2049     1004031   82  Linux swap / Solaris
> > /dev/hda9            2050        2112      506016    0  Empty
> > /dev/hda10           2113        2611     4008186   83  Linux
> > /dev/hda11           2612        2861     2008093+  83  Linux
