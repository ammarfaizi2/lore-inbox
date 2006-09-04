Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932420AbWIDHNM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932420AbWIDHNM (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Sep 2006 03:13:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932419AbWIDHNM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Sep 2006 03:13:12 -0400
Received: from mailer.gwdg.de ([134.76.10.26]:59825 "EHLO mailer.gwdg.de")
	by vger.kernel.org with ESMTP id S932415AbWIDHNJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Sep 2006 03:13:09 -0400
Date: Mon, 4 Sep 2006 09:09:15 +0200 (MEST)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Josef Sipek <jsipek@cs.sunysb.edu>
cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
       hch@infradead.org, akpm@osdl.org, viro@ftp.linux.org.uk
Subject: Re: [PATCH 08/22][RFC] Unionfs: Directory manipulation helper
 functions
In-Reply-To: <20060901014708.GI5788@fsl.cs.sunysb.edu>
Message-ID: <Pine.LNX.4.61.0609040907110.9108@yvahk01.tjqt.qr>
References: <20060901013512.GA5788@fsl.cs.sunysb.edu> <20060901014708.GI5788@fsl.cs.sunysb.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Report: Content analysis: 0.0 points, 6.0 required
	_SUMMARY_
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>+/* This filldir function makes sure only whiteouts exist within a directory. */
>+static int readdir_util_callback(void *dirent, const char *name, int namelen,
>+				 loff_t offset, ino_t ino, unsigned int d_type)
>+{
>+	int err = 0;
>+	struct unionfs_rdutil_callback *buf =
>+	    (struct unionfs_rdutil_callback *)dirent;

Nocast.

>+	if ((namelen > UNIONFS_WHLEN) && !strncmp(name, UNIONFS_WHPFX, UNIONFS_WHLEN)) {
()
Also elsewhere.

>+	if (0 <= bopaque && bopaque < bend)

Turn it. Constant values are usually wanted on the right side.

	bopaque >= 0



Jan Engelhardt
-- 

-- 
VGER BF report: H 1.55431e-15
