Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263968AbSKIBXI>; Fri, 8 Nov 2002 20:23:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263997AbSKIBXI>; Fri, 8 Nov 2002 20:23:08 -0500
Received: from quechua.inka.de ([193.197.184.2]:36238 "EHLO mail.inka.de")
	by vger.kernel.org with ESMTP id <S263968AbSKIBXH>;
	Fri, 8 Nov 2002 20:23:07 -0500
From: Bernd Eckenfels <ecki-news2002-09@lina.inka.de>
To: linux-kernel@vger.kernel.org
Subject: Re: [BUG] Failed writes marked clean?
In-Reply-To: <20021108233530.GA23888@think.thunk.org>
X-Newsgroups: ka.lists.linux.kernel
User-Agent: tin/1.5.8-20010221 ("Blue Water") (UNIX) (Linux/2.0.39 (i686))
Message-Id: <E18AKRc-000398-00@sites.inka.de>
Date: Sat, 9 Nov 2002 02:29:52 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <20021108233530.GA23888@think.thunk.org> you wrote:
> The next question is whether to do this in userspace or in the kernel.

An idea would be to lock/mark the block in the buffer, so it wont be used by
kernel. And then userspace can read out the locked buffers and decide what
to do (like writing to it). Especially good would it be, if user space can
get all details about the expected content (like inode/redir/dentry/data
block of file x).

Greetings
Bernd
