Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261735AbVDTRho@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261735AbVDTRho (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Apr 2005 13:37:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261762AbVDTRhn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Apr 2005 13:37:43 -0400
Received: from fire.osdl.org ([65.172.181.4]:22217 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261735AbVDTRh1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Apr 2005 13:37:27 -0400
Date: Wed, 20 Apr 2005 10:37:23 -0700
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: Ed L Cashin <ecashin@coraid.com>
Cc: linux-kernel@vger.kernel.org, ecashin@coraid.com, greg@kroah.com
Subject: Re: [PATCH 2.6.12-rc2] aoe [5/6]: add firmware version to info in
 sysfs
Message-Id: <20050420103723.52598eb8.rddunlap@osdl.org>
In-Reply-To: <87d5spnzsz.fsf@coraid.com>
References: <874qe1pejv.fsf@coraid.com>
	<87d5spnzsz.fsf@coraid.com>
Organization: OSDL
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
X-Face: SvC&!/v_Hr`MvpQ*|}uez16KH[#EmO2Tn~(r-y+&Jb}?Zhn}c:Eee&zq`cMb_[5`tT(22ms
 (.P84,bq_GBdk@Kgplnrbj;Y`9IF`Q4;Iys|#3\?*[:ixU(UR.7qJT665DxUP%K}kC0j5,UI+"y-Sw
 mn?l6JGvyI^f~2sSJ8vd7s[/CDY]apD`a;s1Wf)K[,.|-yOLmBl0<axLBACB5o^ZAs#&m?e""k/2vP
 E#eG?=1oJ6}suhI%5o#svQ(LvGa=r
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


| add firmware version to info in sysfs
| 
| +static struct disk_attribute disk_attr_fwver = {
| +	.attr = {.name = "fwver", .mode = S_IRUGO },
| +	.show = aoedisk_show_fwver
| +};
| @@ -64,6 +76,7 @@ aoedisk_rm_sysfs(struct aoedev *d)
|  	sysfs_remove_link(&d->gd->kobj, "state");
|  	sysfs_remove_link(&d->gd->kobj, "mac");
|  	sysfs_remove_link(&d->gd->kobj, "netif");
| +	sysfs_remove_link(&d->gd->kobj, "fwver");


It's a good thing that you spelled out "firmware version"
for me.
Just seeing 'fwver' provided these comments from others:


n vwls s bd  (well, it does have 'e'; maybe it shouldn't :)
friends fwver
fw is firewire


so something like 'firmware-version' would be appreciated
(for the sysfs filename).

Thanks,
---
~Randy
