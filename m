Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751504AbWA0QN5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751504AbWA0QN5 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Jan 2006 11:13:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751502AbWA0QNz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Jan 2006 11:13:55 -0500
Received: from [212.76.81.158] ([212.76.81.158]:4625 "EHLO raad.intranet")
	by vger.kernel.org with ESMTP id S1751495AbWA0QNx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Jan 2006 11:13:53 -0500
From: Al Boldi <a1426z@gawab.com>
To: "Ed L. Cashin" <ecashin@coraid.com>
Subject: Re: [PATCH 2.6.15-git9a] aoe [1/1]: do not stop retransmit timer when device goes down
Date: Fri, 27 Jan 2006 19:12:52 +0300
User-Agent: KMail/1.5
Cc: linux-kernel@vger.kernel.org, linux-raid@vger.kernel.org,
       netdev@vger.kernel.org
References: <200601260104.37649.a1426z@gawab.com>
In-Reply-To: <200601260104.37649.a1426z@gawab.com>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200601271912.53109.a1426z@gawab.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

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

