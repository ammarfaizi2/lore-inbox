Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750757AbWJOMru@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750757AbWJOMru (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 Oct 2006 08:47:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750754AbWJOMru
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 Oct 2006 08:47:50 -0400
Received: from mailer.gwdg.de ([134.76.10.26]:55973 "EHLO mailer.gwdg.de")
	by vger.kernel.org with ESMTP id S1750748AbWJOMrt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 Oct 2006 08:47:49 -0400
Date: Sun, 15 Oct 2006 14:36:08 +0200 (MEST)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Josef Sipek <jsipek@fsl.cs.sunysb.edu>
cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       torvalds@osdl.org, hch@infradead.org, viro@ftp.linux.org.uk,
       linux-fsdevel@vger.kernel.org, penberg@cs.helsinki.fi,
       ezk@cs.sunysb.edu, mhalcrow@us.ibm.com
Subject: Re: [PATCH 1 of 2] Stackfs: Introduce stackfs_copy_{attr,inode}_*
In-Reply-To: <20061013200705.GB31928@filer.fsl.cs.sunysb.edu>
Message-ID: <Pine.LNX.4.61.0610151433170.28406@yvahk01.tjqt.qr>
References: <patchbomb.1160738328@thor.fsl.cs.sunysb.edu>
 <ceb6edcac7047367ca16.1160738329@thor.fsl.cs.sunysb.edu>
 <20061013122706.56970df2.akpm@osdl.org> <20061013200705.GB31928@filer.fsl.cs.sunysb.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Report: Content analysis: 0.0 points, 6.0 required
	_SUMMARY_
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>> Many of these functions are too large to be inlined.  Suggest they be
>> placed in fs/fs-stack.c (or whatever we call it).

fs/stack.c would probably be enough -- fs/fs-stack.c is like
include/linux/reiserfs_fs.h

>Ack. As a rule of thumb, for functions like these (laundry list of
>assignments), what's a good threshold?

3 or 4 I guess. Might want to take a look at other static-inline functions.


	-`J'
-- 
