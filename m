Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261213AbVC0R2m@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261213AbVC0R2m (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Mar 2005 12:28:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261233AbVC0R2m
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Mar 2005 12:28:42 -0500
Received: from colin2.muc.de ([193.149.48.15]:48912 "HELO colin2.muc.de")
	by vger.kernel.org with SMTP id S261213AbVC0R2k (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Mar 2005 12:28:40 -0500
Date: 27 Mar 2005 19:28:39 +0200
Date: Sun, 27 Mar 2005 19:28:39 +0200
From: Andi Kleen <ak@muc.de>
To: Christophe Saout <christophe@saout.de>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Fix preemption off of irq context on x86-64 with PREEMPT_BKL
Message-ID: <20050327172839.GD18506@muc.de>
References: <20050324044114.5aa5b166.akpm@osdl.org> <1111778785.14840.13.camel@leto.cs.pocnet.net> <1111882746.32348.6.camel@leto.cs.pocnet.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1111882746.32348.6.camel@leto.cs.pocnet.net>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 27, 2005 at 01:19:06AM +0100, Christophe Saout wrote:
> Hi,
> 
> > x86_64-fix-config_preempt.patch
> >   x86_64: Fix CONFIG_PREEMPT
> 
> This patch causes another bug to show up some lines below with
> CONFIG_PREEMPT_BKL. schedule releases the BKL which it shouldn't do.
> 
> Call preempt_schedule_irq instead (like for i386). This seems to fix the
> easily reproducible filesystem errors I've seen (with reiserfs, which
> heavily relies on the BKL).

I would not apply this one for now. It needs checking if the
patch that requires this change does not require more changes.

-Andi


