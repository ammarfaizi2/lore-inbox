Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270707AbTHJWAK (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 10 Aug 2003 18:00:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270715AbTHJWAK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Aug 2003 18:00:10 -0400
Received: from cable98.usuarios.retecal.es ([212.22.32.98]:31725 "EHLO
	hell.lnx.es") by vger.kernel.org with ESMTP id S270707AbTHJWAF
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Aug 2003 18:00:05 -0400
Date: Sun, 10 Aug 2003 23:59:57 +0200
From: Manuel Estrada Sainz <ranty@debian.org>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] [2.6.0-test3] request_firmware related problems.
Message-ID: <20030810215957.GA12244@ranty.pantax.net>
Reply-To: ranty@debian.org
References: <20030810210646.GA6746@ranty.pantax.net> <20030810142928.4b734e8d.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030810142928.4b734e8d.akpm@osdl.org>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 10, 2003 at 02:29:28PM -0700, Andrew Morton wrote:
> Manuel Estrada Sainz <ranty@debian.org> wrote:
> >
> >  Please apply the following patches.
> 
> Please, send just one patch per email, each one having its own changelog
> info.  There's just no way anyone's patch import tools can handle a single
> changelog and multiple attachments.  It is painful.

 Sorry, I'll do it in a few minutes.
 
> >   - request_firmware_own-workqueue.diff:
> >  	-  In it's current form request_firmware_async() sleeps way too
> >  	   long on the system's shared workqueue, which makes it
> >  	   unresponsive until the firmware load finishes, gets canceled
> >  	   or times out.
> 
> Does this mean that we have another gaggle of kernel threads for all the
> time the system is up?

 I guess so.

> It might be better to create a custom kernel thread on-demand, or kill off
> the workqueue when its job has completed.

 OK, I'll wait on this one, and think about it, after all, it just fixes
 annoying behavior, not real breakness.

 Thanks for the quick reply

 	Manuel

-- 
--- Manuel Estrada Sainz <ranty@debian.org>
                         <ranty@bigfoot.com>
			 <ranty@users.sourceforge.net>
------------------------ <manuel.estrada@hispalinux.es> -------------------
Let us have the serenity to accept the things we cannot change, courage to
change the things we can, and wisdom to know the difference.
