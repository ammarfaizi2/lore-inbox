Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310221AbSCFV5G>; Wed, 6 Mar 2002 16:57:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310219AbSCFV4q>; Wed, 6 Mar 2002 16:56:46 -0500
Received: from age.cs.columbia.edu ([128.59.22.100]:45839 "EHLO
	age.cs.columbia.edu") by vger.kernel.org with ESMTP
	id <S310217AbSCFV4f>; Wed, 6 Mar 2002 16:56:35 -0500
Date: Wed, 6 Mar 2002 16:56:29 -0500 (EST)
From: Ion Badulescu <ionut@cs.columbia.edu>
To: Jeff Garzik <jgarzik@mandrakesoft.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] starfire net driver update for 2.4.19pre2
In-Reply-To: <3C868E4F.53C91E8C@mandrakesoft.com>
Message-ID: <Pine.LNX.4.44.0203061652050.31906-100000@age.cs.columbia.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 6 Mar 2002, Jeff Garzik wrote:

> There is a bugfix, which I will make locally before submitting:
> PCI_COMMAND_INVALIDATE should be enabled -after- messing with
> PCI_CACHE_LINE_SIZE.

I didn't find anything in the starfire chipset's documentation about this, 
so is there a deeper reason for this ordering? As far as I know, most if 
not all x86 PCI chipsets silently map MWI to MW, so it should only matter 
for non-x86 plaforms, right?

And, in general, are there any other tricks one can do to speed up the PCI 
transactions on non-x86 platforms? I'm still getting occasional overruns 
on sparc64 (card receiving packets faster than it can push them over PCI), 
which is somewhat disturbing..

Thanks,
Ion

-- 
  It is better to keep your mouth shut and be thought a fool,
            than to open it and remove all doubt.

