Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1031597AbWLEVhF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1031597AbWLEVhF (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Dec 2006 16:37:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1031651AbWLEVhF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Dec 2006 16:37:05 -0500
Received: from mailer.gwdg.de ([134.76.10.26]:44778 "EHLO mailer.gwdg.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1031627AbWLEVhB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Dec 2006 16:37:01 -0500
Date: Tue, 5 Dec 2006 22:29:53 +0100 (MET)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: "Josef 'Jeff' Sipek" <jsipek@cs.sunysb.edu>
cc: linux-kernel@vger.kernel.org, torvalds@osdl.org, akpm@osdl.org,
       hch@infradead.org, viro@ftp.linux.org.uk, linux-fsdevel@vger.kernel.org,
       mhalcrow@us.ibm.com
Subject: Re: [PATCH 22/35] Unionfs: Lookup helper functions
In-Reply-To: <1165235471242-git-send-email-jsipek@cs.sunysb.edu>
Message-ID: <Pine.LNX.4.61.0612052228550.18570@yvahk01.tjqt.qr>
References: <1165235468365-git-send-email-jsipek@cs.sunysb.edu>
 <1165235471242-git-send-email-jsipek@cs.sunysb.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Report: Content analysis: 0.0 points, 6.0 required
	_SUMMARY_
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>+/* allocate new dentry private data, free old one if necessary */
>+int new_dentry_private_data(struct dentry *dentry)
>+{
>[...]
>+
>+	spin_unlock(&dentry->d_lock);
>+	return 0;
>+	/* */
>+
>+out_free:
>+	kfree(info->lower_paths);
>+
>+out:
>+	free_dentry_private_data(info);
>+	dentry->d_fsdata = NULL;
>+	spin_unlock(&dentry->d_lock);
>+	return -ENOMEM;
>+}

Whereever I go, ... care to explain the /* */? If it was just a marker
logically belonging to the syntactic sugar, it's missing in the other source
files too.


	-`J'
-- 
