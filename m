Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261683AbVBOLLJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261683AbVBOLLJ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Feb 2005 06:11:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261684AbVBOLLJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Feb 2005 06:11:09 -0500
Received: from news.suse.de ([195.135.220.2]:32937 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S261683AbVBOLLD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Feb 2005 06:11:03 -0500
Date: Tue, 15 Feb 2005 12:10:35 +0100
From: Andi Kleen <ak@suse.de>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Andi Kleen <ak@suse.de>, linux-kernel@vger.kernel.org, paulus@samba.org,
       anton@samba.org, davem@davemloft.net, ralf@linux-mips.org,
       tony.luck@intel.com, willy@debian.org, schwidefsky@de.ibm.com
Subject: Re: [PATCH] Consolidate compat_sys_waitid
Message-ID: <20050215111035.GD2623@wotan.suse.de>
References: <20050215140149.0b06c96b.sfr@canb.auug.org.au> <20050215095153.GB13952@wotan.suse.de> <20050215220614.68c4e11e.sfr@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050215220614.68c4e11e.sfr@canb.auug.org.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 15, 2005 at 10:06:14PM +1100, Stephen Rothwell wrote:
> Hi Andi,
> 
> On Tue, 15 Feb 2005 10:51:53 +0100 Andi Kleen <ak@suse.de> wrote:
> >
> > I don't think this will work for sparc64/s390/UML etc.
> > They cannot access kernel data inside KERNEL_DS. You would need to use
> > compat_alloc_user_space() for ru
> 
> .. and, presumably, for info as well.  Interestingly, this code
> came directly from sparc64 ...

Sorry, I misread the code. In this case it's actually ok.

The only thing that doesn't work is mixing the pointers (e.g. accessing
user mode pointers inside KERNEL_DS) 

So the patch is fine.

-Andi
