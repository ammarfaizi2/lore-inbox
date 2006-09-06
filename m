Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751213AbWIFG5S@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751213AbWIFG5S (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Sep 2006 02:57:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751227AbWIFG5S
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Sep 2006 02:57:18 -0400
Received: from emailer.gwdg.de ([134.76.10.24]:9693 "EHLO emailer.gwdg.de")
	by vger.kernel.org with ESMTP id S1751213AbWIFG5R (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Sep 2006 02:57:17 -0400
Date: Wed, 6 Sep 2006 08:54:43 +0200 (MEST)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Andreas Gruenbacher <agruen@suse.de>
cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       James Morris <jmorris@namei.org>, Kay Sievers <kay.sievers@vrfy.org>
Subject: Re: Generic infrastructure for acls
In-Reply-To: <20060901221457.803728153@winden.suse.de>
Message-ID: <Pine.LNX.4.61.0609060842570.10504@yvahk01.tjqt.qr>
References: <20060901221421.968954146@winden.suse.de> <20060901221457.803728153@winden.suse.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Report: Content analysis: 0.0 points, 6.0 required
	_SUMMARY_
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



>+generic_acl_set(struct inode *inode, struct generic_acl_operations *ops,
>+		int type, const void *value, size_t size)
>+{
>+	struct posix_acl *acl = NULL;
>+	int error;
>+
>+	if (S_ISLNK(inode->i_mode))
>+		return -EOPNOTSUPP;
>+	if ((current->fsuid != inode->i_uid) && !capable(CAP_FOWNER))

>+			if (error > 0) {
>+				ops->setacl(inode, ACL_TYPE_ACCESS, clone);
>+			}

redundant () {}



Jan Engelhardt
-- 
