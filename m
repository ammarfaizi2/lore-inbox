Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422957AbWJQKzR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422957AbWJQKzR (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Oct 2006 06:55:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422935AbWJQKzR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Oct 2006 06:55:17 -0400
Received: from emailer.gwdg.de ([134.76.10.24]:31718 "EHLO emailer.gwdg.de")
	by vger.kernel.org with ESMTP id S1422852AbWJQKzO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Oct 2006 06:55:14 -0400
Date: Tue, 17 Oct 2006 12:40:31 +0200 (MEST)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Josef Jeff Sipek <jsipek@cs.sunysb.edu>
cc: Andrew James Wade <andrew.j.wade@gmail.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>,
       hch@infradead.org, Al Viro <viro@ftp.linux.org.uk>,
       linux-fsdevel@vger.kernel.org, Pekka Enberg <penberg@cs.helsinki.fi>,
       ezk@cs.sunysb.edu, mhalcrow@us.ibm.com
Subject: Re: [PATCH 1 of 2] fsstack: Introduce fsstack_copy_{attr,inode}_*
In-Reply-To: <fe7c146c6457a4b288ab.1161060147@thor.fsl.cs.sunysb.edu>
Message-ID: <Pine.LNX.4.61.0610171237220.22888@yvahk01.tjqt.qr>
References: <fe7c146c6457a4b288ab.1161060147@thor.fsl.cs.sunysb.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Report: Content analysis: 0.0 points, 6.0 required
	_SUMMARY_
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>To: null@josefsipek.net

(Superb idea to prekill any Cc, re-adding them)

>+void __fsstack_copy_attr_all(struct inode *dest,
>+			     const struct inode *src,
>+			     int (*get_nlinks)(struct inode *))
>+{
>[big]
>+}
>+
>+/* externs for fs/stack.c */
>+extern void __fsstack_copy_attr_all(struct inode *dest,
>+				    const struct inode *src,
>+				    int (*get_nlinks)(struct inode *));
>+
>+static inline void fsstack_copy_attr_all(struct inode *dest,
>+					 const struct inode *src)
>+{
>+	__fsstack_copy_attr_all(dest, src, NULL);
>+}

Do we really need this indirection? Can't __fsstack_copy_attr_all be 
named fsstack_copy_attr_all instead?


	-`J'
-- 
