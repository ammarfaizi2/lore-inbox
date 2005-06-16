Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261271AbVFPRfA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261271AbVFPRfA (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Jun 2005 13:35:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261778AbVFPRe7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Jun 2005 13:34:59 -0400
Received: from fmr21.intel.com ([143.183.121.13]:47283 "EHLO
	scsfmr001.sc.intel.com") by vger.kernel.org with ESMTP
	id S261271AbVFPRe5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Jun 2005 13:34:57 -0400
Date: Thu, 16 Jun 2005 10:33:41 -0700
From: Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>
To: Simon Richard Grint <rgrint@compsoc.man.ac.uk>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       Rajesh Shah <rajesh.shah@intel.com>
Subject: Re: arch/i386/boot/video.S hang
Message-ID: <20050616103340.A4951@unix-os.sc.intel.com>
References: <20050615220554.GA1911@srg.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20050615220554.GA1911@srg.demon.co.uk>; from rgrint@compsoc.man.ac.uk on Wed, Jun 15, 2005 at 11:05:54PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 15, 2005 at 11:05:54PM +0100, Simon Richard Grint wrote:
> 
> I'm trying to upgrade an old AMD K6-2 machine (aladdin bios/gigabyte GA-5AX
> motherboard, latest version of the bios) to 2.6.11. Unfortunately kernels later 
> than 2.6.9 hang very early in the boot process just after the vga= mode selection, 
> but before the kernel announces "uncompressing linux".
> 
> I have narrowed the problem down to the store_edid function in
> arch/i386/boot/video.S where the edid block is obtained and stored before
> entering protected mode.  The exact patch which seems to cause me problems
> is http://www.ussg.iu.edu/hypermail/linux/kernel/0409.3/1786.html
> 
> Storing the edid block at 0x140 causes this machine to hang, whereas backing
> this patch out and instead using 0x440 (or even 0x160) seems to work fine.
> 
> Is this problem just because of an old and buggy bios or is there another
> reason?
> 

What boot loader are you using. grub/lilo?

Does it work with CONFIG_VIDEO_SELECT disabled in your kernel CONFIG?

Thanks,
Venki
