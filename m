Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932444AbWIDHcm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932444AbWIDHcm (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Sep 2006 03:32:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932445AbWIDHcm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Sep 2006 03:32:42 -0400
Received: from emailer.gwdg.de ([134.76.10.24]:4279 "EHLO emailer.gwdg.de")
	by vger.kernel.org with ESMTP id S932444AbWIDHcl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Sep 2006 03:32:41 -0400
Date: Mon, 4 Sep 2006 09:28:47 +0200 (MEST)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Josef Sipek <jsipek@cs.sunysb.edu>
cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
       hch@infradead.org, akpm@osdl.org, viro@ftp.linux.org.uk
Subject: Re: [PATCH 12/22][RFC] Unionfs: Main module functions
In-Reply-To: <20060901015136.GM5788@fsl.cs.sunysb.edu>
Message-ID: <Pine.LNX.4.61.0609040924500.9108@yvahk01.tjqt.qr>
References: <20060901013512.GA5788@fsl.cs.sunysb.edu> <20060901015136.GM5788@fsl.cs.sunysb.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Report: Content analysis: 0.0 points, 6.0 required
	_SUMMARY_
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>+/* checks if two hidden_dentries have overlapping branches */
>+int is_branch_overlap(struct dentry *dent1, struct dentry *dent2)
>+{
>+	struct dentry *dent = NULL;
>+
>+	dent = dent1;
>+	while ((dent != dent2) && (dent->d_parent != dent)) {
>+		dent = dent->d_parent;
>+	}
>+	if (dent == dent2) {
>+		return 1;
>+	}
>+
>+	dent = dent2;
>+	while ((dent != dent1) && (dent->d_parent != dent)) {
>+		dent = dent->d_parent;
>+	}
>+	if (dent == dent1) {
>+		return 1;
>+	}
>+
>+	return 0;
>+}
-()-{} Also elsewhere.

>+	struct dentry *dent1 = NULL;
>+	struct dentry *dent2 = NULL;

Is it necessary to set these to NULL?

>+		for (i = 0; i < branches; i++) {
>+			if (hidden_root_info->udi_dentry[i])
>+				dput(hidden_root_info->udi_dentry[i]);
>+		}


>+MODULE_AUTHOR("Filesystems and Storage Lab, Stony Brook University"
>+		" (http://www.fsl.cs.sunysb.edu/)");

Should probably have at least one human person in the list.


Jan Engelhardt
-- 

-- 
VGER BF report: H 4.15867e-12
