Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265964AbUA1XH7 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jan 2004 18:07:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266039AbUA1XH7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jan 2004 18:07:59 -0500
Received: from post.tau.ac.il ([132.66.16.11]:61073 "EHLO post.tau.ac.il")
	by vger.kernel.org with ESMTP id S265964AbUA1XH4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jan 2004 18:07:56 -0500
Date: Thu, 29 Jan 2004 01:06:09 +0200
From: Micha Feigin <michf@post.tau.ac.il>
To: linux-kernel@vger.kernel.org
Subject: Re: Is there a way to keep the 2.6 kjournald from writing to idle disks? (to allow spin-downs)
Message-ID: <20040128230609.GE3975@luna.mooo.com>
Mail-Followup-To: linux-kernel@vger.kernel.org
References: <Pine.LNX.3.96.1040127133932.11664B-100000@gatekeeper.tmr.com> <4016B3F0.1060804@samwel.tk> <4017B98C.2040603@isg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4017B98C.2040603@isg.de>
User-Agent: Mutt/1.5.5.1+cvs20040105i
X-AntiVirus: checked by Vexira MailArmor (version: 2.0.1.16; VAE: 6.23.0.3; VDF: 6.23.0.51; host: localhost)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 28, 2004 at 02:30:52PM +0100, Lutz Vieweg wrote:
> Bart Samwel wrote:
> 
> >>Well, it's the o.p. system, not mine, but I don't see how noatime will
> >>help him, the atime shouldn't change unless he's doing disk access, and
> >>if he's doing disk access the disk will spin up anyway.
> 
> That's what I thought, too... and I really killed everything that I could
> imagine accessing the disk... but...
> 
> >If something really is accessing the drive, noatime might still help as 
> >long as the accesses are from the cache.
> 
> ... that really helped! I'm kind of surprised, since I didn't use noatime
> before the update, and I still don't know of any process that might do
> the reading, but since mounting / with noatime helped, I'm happy for now.
> 
> My curiosity isn't completely gone, though, so maybe one day I'll try to
> find out who-is-trying-to-read-what, "find -atime ..." didn't reveal the 
> secret
> yet.
> 

It might help you find the culprit. There is a laptopmode patch
for 2.6. If you echo a number n larger then 1 into
/proc/sys/vm/laptopmode it will dump the first n disk accesses to the
console (The docs that come with the patch have the complete
description).

> Regards,
> 
> Lutz Vieweg
> 
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 
