Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751227AbWIFHEv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751227AbWIFHEv (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Sep 2006 03:04:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751509AbWIFHEv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Sep 2006 03:04:51 -0400
Received: from emailer.gwdg.de ([134.76.10.24]:11148 "EHLO emailer.gwdg.de")
	by vger.kernel.org with ESMTP id S1751227AbWIFHEu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Sep 2006 03:04:50 -0400
Date: Wed, 6 Sep 2006 09:02:17 +0200 (MEST)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Andreas Gruenbacher <agruen@suse.de>
cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       James Morris <jmorris@namei.org>, Kay Sievers <kay.sievers@vrfy.org>
Subject: Re: Access Control Lists for tmpfs
In-Reply-To: <20060901221458.148480972@winden.suse.de>
Message-ID: <Pine.LNX.4.61.0609060855060.10504@yvahk01.tjqt.qr>
References: <20060901221421.968954146@winden.suse.de> <20060901221458.148480972@winden.suse.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Report: Content analysis: 0.0 points, 6.0 required
	_SUMMARY_
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>+static int
>+shmem_get_acl_access(struct inode *inode, const char *name, void *buffer,
>+		     size_t size)
>+{
>+	if (strcmp(name, "") != 0)
>+		return -EINVAL;

An interesting thing (tested in userspace):

  strcmp(somestring, "")

will only evaluate to *sometring=='\0' if I add -static to CFLAGS.



Jan Engelhardt
-- 
