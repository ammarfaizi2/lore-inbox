Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262335AbUK3VfL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262335AbUK3VfL (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Nov 2004 16:35:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262345AbUK3VfL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Nov 2004 16:35:11 -0500
Received: from mail.dif.dk ([193.138.115.101]:12731 "EHLO mail.dif.dk")
	by vger.kernel.org with ESMTP id S262335AbUK3Vet (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Nov 2004 16:34:49 -0500
Date: Tue, 30 Nov 2004 22:44:37 +0100 (CET)
From: Jesper Juhl <juhl-lkml@dif.dk>
To: Roger Luethi <rl@hellgate.ch>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] net/via-rhine: convert MODULE_PARM to module_param
In-Reply-To: <20041130140309.GA6568@k3.hellgate.ch>
Message-ID: <Pine.LNX.4.61.0411302241260.3635@dragon.hygekrogen.localhost>
References: <Pine.LNX.4.61.0411300053190.3432@dragon.hygekrogen.localhost>
 <20041130140309.GA6568@k3.hellgate.ch>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 30 Nov 2004, Roger Luethi wrote:

> On Tue, 30 Nov 2004 00:58:58 +0100, Jesper Juhl wrote:
> > These warnings told me that it was time to move to module_param() :)
> > 
> > drivers/net/via-rhine.c:229: warning: `MODULE_PARM_' is deprecated (declared at include/linux/module.h:562)
> > drivers/net/via-rhine.c:230: warning: `MODULE_PARM_' is deprecated (declared at include/linux/module.h:562)
> > drivers/net/via-rhine.c:231: warning: `MODULE_PARM_' is deprecated (declared at include/linux/module.h:562)
> > 
> > So I made this small patch to do so.
> > Compile and boot tested on my box, and it seems to work just fine, the 
> > module works perfectly with my via-rhine card, and the parameters are 
> > exposed through sysfs as expected : 
> 
> IIRC Jeff has already queued such a patch for 2.6.11. 

Hmm, ok. I assume that's what's currently in -mm - I haven't been 
following -mm lately so I missed the fact that the driver in there had 
already moved to module_param().  There's one difference though, and I 
think it matters; my patch sets the permission bits so that the parameters 
get exposed in sysfs (which I think is very useful), the driver in -mm 
sets the perms to 0 (zero) so nothing is exposed in sysfs (less useful).

>Thanks, though.

You are very welcome.

 
-- 
Jesper Juhl


