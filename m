Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261693AbUJaXap@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261693AbUJaXap (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 31 Oct 2004 18:30:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261692AbUJaXap
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 31 Oct 2004 18:30:45 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:51209 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261694AbUJaXa0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 31 Oct 2004 18:30:26 -0500
Date: Mon, 1 Nov 2004 00:29:54 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Ben Collins <bcollins@debian.org>
Cc: linux1394-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: RFC: [2.6 patch] ieee1394 cleanup
Message-ID: <20041031232954.GG2495@stusta.de>
References: <20041031213250.GD2495@stusta.de> <20041031212858.GC9684@phunnypharm.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041031212858.GC9684@phunnypharm.org>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 31, 2004 at 04:28:58PM -0500, Ben Collins wrote:

> Need to leave the csr1212 files alone. csr1212.[ch] is used for userspace
> and kernelspace, and I don't want to have two versions.

But in this case, these functions don't have to be EXPORT_SYMBOL'ed?

And besides this, they are global functions meaning that although they 
are never used inside the kernel, they need space for every user of 
FireWire.

What about wrapping them inside #ifndef __KERNEL__ ?

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

