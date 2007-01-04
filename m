Return-Path: <linux-kernel-owner+w=401wt.eu-S1030225AbXADVEZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030225AbXADVEZ (ORCPT <rfc822;w@1wt.eu>);
	Thu, 4 Jan 2007 16:04:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030220AbXADVEZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Jan 2007 16:04:25 -0500
Received: from mx1.redhat.com ([66.187.233.31]:54107 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1030225AbXADVEZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Jan 2007 16:04:25 -0500
Message-ID: <459D6BD1.7050406@redhat.com>
Date: Thu, 04 Jan 2007 15:04:17 -0600
From: Eric Sandeen <sandeen@redhat.com>
User-Agent: Thunderbird 1.5.0.8 (X11/20061107)
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: Al Viro <viro@ftp.linux.org.uk>, Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Al Viro <viro@zeniv.linux.org.uk>
Subject: Re: [UPDATED PATCH] fix memory corruption from misinterpreted bad_inode_ops
 return values
References: <459C4038.6020902@redhat.com>	<20070103162643.5c479836.akpm@osdl.org>	<459D3E8E.7000405@redhat.com>	<20070104102659.8c61d510.akpm@osdl.org>	<459D4897.4020408@redhat.com>	<20070104105430.1de994a7.akpm@osdl.org>	<Pine.LNX.4.64.0701041104021.3661@woody.osdl.org>	<20070104191451.GW17561@ftp.linux.org.uk>	<Pine.LNX.4.64.0701041127350.3661@woody.osdl.org>	<20070104202412.GY17561@ftp.linux.org.uk> <20070104130028.39aa44b8.akpm@osdl.org>
In-Reply-To: <20070104130028.39aa44b8.akpm@osdl.org>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> On Thu, 4 Jan 2007 20:24:12 +0000
> Al Viro <viro@ftp.linux.org.uk> wrote:
> 
>> So my main issue with fs/bad_inode.c is not even cast per se; it's that
>> cast is to void *.
> 
> But Eric's latest patch is OK in that regard, isn't it?  It might confuse
> parsers (in fixable ways), but it is type-correct and has no casts.  (Well,
> it kinda has an link-time cast).

Even if it is, I'm starting to wonder if all this tricksiness is really
worth it for 400 bytes or so.  :)

-Eric
