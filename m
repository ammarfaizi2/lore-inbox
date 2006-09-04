Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932442AbWIDH2p@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932442AbWIDH2p (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Sep 2006 03:28:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932437AbWIDH2p
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Sep 2006 03:28:45 -0400
Received: from emailer.gwdg.de ([134.76.10.24]:58008 "EHLO emailer.gwdg.de")
	by vger.kernel.org with ESMTP id S932434AbWIDH2n (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Sep 2006 03:28:43 -0400
Date: Mon, 4 Sep 2006 09:24:42 +0200 (MEST)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Josef Sipek <jsipek@cs.sunysb.edu>
cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
       hch@infradead.org, akpm@osdl.org, viro@ftp.linux.org.uk
Subject: Re: [PATCH 11/22][RFC] Unionfs: Lookup helper functions
In-Reply-To: <20060901015016.GL5788@fsl.cs.sunysb.edu>
Message-ID: <Pine.LNX.4.61.0609040918350.9108@yvahk01.tjqt.qr>
References: <20060901013512.GA5788@fsl.cs.sunysb.edu> <20060901015016.GL5788@fsl.cs.sunysb.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Report: Content analysis: 0.0 points, 6.0 required
	_SUMMARY_
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>+		if ((bopaque != -1) && (bopaque < bend))

>+	/* If we've only got negative dentries, then use the leftmost one. */
>+	if (lookupmode == INTERPOSE_REVAL) {
>+		if (dentry->d_inode) {
>+			itopd(dentry->d_inode)->uii_stale = 1;
>+		}
>+		goto out;
>+	}
>+		if (!newsize || ((oldsize < newsize) && (newsize > minsize))) {

Some places where -() and -{}

>+static int is_opaque_dir(struct dentry *dentry, int bindex)
>+{
>+	int err = 0;
>+	/* This is an opaque dir iff wh_hidden_dentry is positive */
>+	err = !!wh_hidden_dentry->d_inode;
>+out:
>+	return err;
>+}

This smells like a bool function. If so, don't call it "err" (since boolean
functions do not return "errors").



Jan Engelhardt
-- 

-- 
VGER BF report: H 8.44923e-11
