Return-Path: <linux-kernel-owner+w=401wt.eu-S1030214AbXADVAm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030214AbXADVAm (ORCPT <rfc822;w@1wt.eu>);
	Thu, 4 Jan 2007 16:00:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030225AbXADVAl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Jan 2007 16:00:41 -0500
Received: from smtp0.osdl.org ([65.172.181.24]:52240 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1030214AbXADVAl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Jan 2007 16:00:41 -0500
Date: Thu, 4 Jan 2007 13:00:28 -0800
From: Andrew Morton <akpm@osdl.org>
To: Al Viro <viro@ftp.linux.org.uk>
Cc: Linus Torvalds <torvalds@osdl.org>, Eric Sandeen <sandeen@redhat.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Al Viro <viro@zeniv.linux.org.uk>
Subject: Re: [UPDATED PATCH] fix memory corruption from misinterpreted
 bad_inode_ops return values
Message-Id: <20070104130028.39aa44b8.akpm@osdl.org>
In-Reply-To: <20070104202412.GY17561@ftp.linux.org.uk>
References: <459C4038.6020902@redhat.com>
	<20070103162643.5c479836.akpm@osdl.org>
	<459D3E8E.7000405@redhat.com>
	<20070104102659.8c61d510.akpm@osdl.org>
	<459D4897.4020408@redhat.com>
	<20070104105430.1de994a7.akpm@osdl.org>
	<Pine.LNX.4.64.0701041104021.3661@woody.osdl.org>
	<20070104191451.GW17561@ftp.linux.org.uk>
	<Pine.LNX.4.64.0701041127350.3661@woody.osdl.org>
	<20070104202412.GY17561@ftp.linux.org.uk>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 4 Jan 2007 20:24:12 +0000
Al Viro <viro@ftp.linux.org.uk> wrote:

> So my main issue with fs/bad_inode.c is not even cast per se; it's that
> cast is to void *.

But Eric's latest patch is OK in that regard, isn't it?  It might confuse
parsers (in fixable ways), but it is type-correct and has no casts.  (Well,
it kinda has an link-time cast).
