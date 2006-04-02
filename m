Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932330AbWDBLKF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932330AbWDBLKF (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 2 Apr 2006 07:10:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932329AbWDBLKF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 2 Apr 2006 07:10:05 -0400
Received: from ns.suse.de ([195.135.220.2]:8375 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S932326AbWDBLKE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 2 Apr 2006 07:10:04 -0400
Date: Sun, 2 Apr 2006 13:10:02 +0200
From: Olaf Hering <olh@suse.de>
To: John Mylchreest <johnm@gentoo.org>
Cc: linux-kernel@vger.kernel.org, stable@kernel.org, paulus@samba.org
Subject: Re: [PATCH 1/1] POWERPC: Fix ppc32 compile with gcc+SSP in 2.6.16
Message-ID: <20060402111002.GA30017@suse.de>
References: <20060401224849.GH16917@getafix.willow.local> <20060402085850.GA28857@suse.de> <20060402102259.GM16917@getafix.willow.local> <20060402102815.GA29717@suse.de> <20060402105859.GN16917@getafix.willow.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20060402105859.GN16917@getafix.willow.local>
X-DOS: I got your 640K Real Mode Right Here Buddy!
X-Homeland-Security: You are not supposed to read this line! You are a terrorist!
User-Agent: Mutt und vi sind doch schneller als Notes (und GroupWise)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 On Sun, Apr 02, John Mylchreest wrote:

> On Sun, Apr 02, 2006 at 12:28:15PM +0200, Olaf Hering <olh@suse.de> wrote:
> >  On Sun, Apr 02, John Mylchreest wrote:
> > 
> > >   BOOTLD  arch/powerpc/boot/zImage.vmode
> > >   arch/powerpc/boot/prom.o(.text+0x19c): In function `call_prom':
> > >   : undefined reference to `__stack_smash_handler'
> > 
> > Any this strange "security feature" is disabled by defining __KERNEL__?
> 
> That correct, yes. SSP is actually used by quite a lot of vendors, and
> shouldn't be used outside of userland. Typically speaking it isn't, but
> in this case its being leaked.

Either way, file a bugreport upstream to remove the dep on __KERNEL__ in
the gcc patch.

A patch which adds -fno-dumb-feature to CFLAGS may be acceptable.
