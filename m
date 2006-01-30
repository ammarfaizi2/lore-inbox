Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932375AbWA3QtO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932375AbWA3QtO (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Jan 2006 11:49:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932327AbWA3QtO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Jan 2006 11:49:14 -0500
Received: from fmmailgate05.web.de ([217.72.192.243]:6822 "EHLO
	fmmailgate05.web.de") by vger.kernel.org with ESMTP id S932373AbWA3QtO
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Jan 2006 11:49:14 -0500
Date: Mon, 30 Jan 2006 17:49:10 +0100
Message-Id: <972671705@web.de>
MIME-Version: 1.0
From: devzero@web.de
To: linux-kernel@vger.kernel.org
Cc: a1426z@gawab.com
Subject: Re: [PATCH 2.6.15-git9a] aoe [1/1]: do not stop retransmit timer when device goes down
Organization: http://freemail.web.de/
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

>Why is the userland vblade server slower than the userland nbd-server?

maybe it yet is`t optimized for speed !?
nbd probably is more mature, too.

as of writing this, maybe the userspace vblade is meant for demonstration/testing/learning purpose. you wouldn`t buy a etherblade from coraid just for testing AoE - would you?

but, anyway - there is a second vblade implementation (independent from coraid) at  http://lpk.com.price.ru/~lelik/AoE/

this one is done as a LKM and should be faster.
give it a try !

regards
roland

ps:
i did successfully boot a linux system with AoE-root (just like NFS-root) today ! 



Ed L. Cashin wrote:
> On Thu, Jan 26, 2006 at 01:04:37AM +0300, Al Boldi wrote:
> > Ed L. Cashin wrote:
> > > This patch is a bugfix that follows and depends on the
> > > eight aoe driver patches sent January 19th.
> >
> > Will they also fix this?
> > Or is this an md bug?
>
> No, this patch fixes a bug that would cause an AoE device to be
> totally unusable, so I think mdadm or mkraid would get an error that
> the device was not available before it tried to make a new md device.
>
> > It only happens with aoe.
>
> It looks like in setting up the raid, sysfs_create_link probably has
> this going off:
>
>         BUG_ON(!kobj || !kobj->dentry || !name);
>
> > Also, why is aoe slower than nbd?
>
> It wasn't when I tried it.  The userland vblade is slow.  Maybe that's
> affecting your results?

Why is the userland vblade server slower than the userland nbd-server?

Thanks!

--
Al


http://lpk.com.price.ru/~lelik/AoE/
______________________________________________________________
Verschicken Sie romantische, coole und witzige Bilder per SMS!
Jetzt bei WEB.DE FreeMail: http://f.web.de/?mc=021193

