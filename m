Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263893AbUGLW3y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263893AbUGLW3y (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Jul 2004 18:29:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263895AbUGLW3y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Jul 2004 18:29:54 -0400
Received: from quechua.inka.de ([193.197.184.2]:1175 "EHLO mail.inka.de")
	by vger.kernel.org with ESMTP id S263893AbUGLW3x (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Jul 2004 18:29:53 -0400
From: Bernd Eckenfels <ecki-news2004-05@lina.inka.de>
To: linux-kernel@vger.kernel.org
Subject: Re: XFS: how to NOT null files on fsck?
Organization: Deban GNU/Linux Homesite
In-Reply-To: <20040712195956.GA14105@taniwha.stupidest.org>
X-Newsgroups: ka.lists.linux.kernel
User-Agent: tin/1.7.5-20040615 ("Gighay") (UNIX) (Linux/2.6.5 (i686))
Message-Id: <E1Bk9J1-0007ve-00@calista.eckenfels.6bone.ka-ip.net>
Date: Tue, 13 Jul 2004 00:29:51 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <20040712195956.GA14105@taniwha.stupidest.org> you wrote:
> Data sits in the page-cache though, and if you loose power before
> that's flushed you will loose data.  This is why fsync is needed to be
> sure.

Yes right, I was confusing that with networked filesystems with
commit-on-close semantics.

Greetings
Bernd


BTW:
I was stracing java, and it is enough to do "fos.getFD().sync();
fos.close()" on FileOutputStrea to get a fsync(fd) followed by close(fd).
-- 
eckes privat - http://www.eckes.org/
Project Freefire - http://www.freefire.org/
