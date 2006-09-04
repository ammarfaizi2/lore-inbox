Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932462AbWIDHnZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932462AbWIDHnZ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Sep 2006 03:43:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932461AbWIDHnZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Sep 2006 03:43:25 -0400
Received: from emailer.gwdg.de ([134.76.10.24]:38283 "EHLO emailer.gwdg.de")
	by vger.kernel.org with ESMTP id S932456AbWIDHnX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Sep 2006 03:43:23 -0400
Date: Mon, 4 Sep 2006 09:39:29 +0200 (MEST)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Josef Sipek <jsipek@cs.sunysb.edu>
cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
       hch@infradead.org, akpm@osdl.org, viro@ftp.linux.org.uk
Subject: Re: [PATCH 16/22][RFC] Unionfs: Handling of stale inodes
In-Reply-To: <20060901015645.GQ5788@fsl.cs.sunysb.edu>
Message-ID: <Pine.LNX.4.61.0609040937120.9108@yvahk01.tjqt.qr>
References: <20060901013512.GA5788@fsl.cs.sunysb.edu> <20060901015645.GQ5788@fsl.cs.sunysb.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Report: Content analysis: 0.0 points, 6.0 required
	0.0 UPPERCASE_25_50        message body is 25-50% uppercase
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>+static void *stale_follow_link(struct dentry *dent, struct nameidata *nd)
>+{
>+	int err = vfs_follow_link(nd, ERR_PTR(-ESTALE));
>+	return ERR_PTR(err);
>+}

{
	return ERR_PTR(vfs_follow_link(nd, ERR_PTR(-ESTALE)));
}?

>+#define ESTALE_ERROR ((void *) (return_ESTALE))

#define ESTALE_ERROR ((void *)return_ESTALE)

That really looks BSDish, violating the number of args ;-)


Jan Engelhardt
-- 

-- 
VGER BF report: H 0
