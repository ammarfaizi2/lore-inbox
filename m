Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263199AbTE3Ai5 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 May 2003 20:38:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263212AbTE3Ai5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 May 2003 20:38:57 -0400
Received: from abraham.CS.Berkeley.EDU ([128.32.37.170]:50448 "EHLO
	mx2.cypherpunks.ca") by vger.kernel.org with ESMTP id S263199AbTE3Aiz
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 May 2003 20:38:55 -0400
To: linux-kernel@vger.kernel.org
Path: not-for-mail
From: daw@mozart.cs.berkeley.edu (David Wagner)
Newsgroups: isaac.lists.linux-kernel
Subject: Re: [RFC][2.5] generic_usercopy() function (resend, forgot the patches)
Date: 30 May 2003 00:25:54 GMT
Organization: University of California, Berkeley
Distribution: isaac
Message-ID: <bb68ei$gk7$1@abraham.cs.berkeley.edu>
References: <3ECDEBC5.5030608@convergence.de>
NNTP-Posting-Host: mozart.cs.berkeley.edu
X-Trace: abraham.cs.berkeley.edu 1054254354 17031 128.32.153.211 (30 May 2003 00:25:54 GMT)
X-Complaints-To: news@abraham.cs.berkeley.edu
NNTP-Posting-Date: 30 May 2003 00:25:54 GMT
X-Newsreader: trn 4.0-test74 (May 26, 2000)
Originator: daw@mozart.cs.berkeley.edu (David Wagner)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Michael Hunold  wrote:
> /*
>- * helper function -- handles userspace copying for ioctl arguments
>- */
>-int
>-video_usercopy(struct inode *inode, struct file *file,
>-	       unsigned int cmd, unsigned long arg,
>-	       int (*func)(struct inode *inode, struct file *file,
>-			   unsigned int cmd, void *arg))
>-{
...
>-		if (copy_from_user(parg, (void *)arg, _IOC_SIZE(cmd)))
...
>-	err = func(inode, file, cmd, parg);
...

What about doubly-indirected pointers?  i.e., arg is a pointer
to a structure that itself contains a pointer?  Can this happen?
