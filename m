Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263159AbUFFJwN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263159AbUFFJwN (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Jun 2004 05:52:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263185AbUFFJwN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Jun 2004 05:52:13 -0400
Received: from quechua.inka.de ([193.197.184.2]:47765 "EHLO mail.inka.de")
	by vger.kernel.org with ESMTP id S263159AbUFFJwL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Jun 2004 05:52:11 -0400
From: Bernd Eckenfels <ecki-news2004-05@lina.inka.de>
To: linux-kernel@vger.kernel.org
Subject: Re: clone() <-> getpid() bug in 2.6?
Organization: Deban GNU/Linux Homesite
In-Reply-To: <Pine.LNX.4.58.0406052244290.7010@ppc970.osdl.org>
X-Newsgroups: ka.lists.linux.kernel
User-Agent: tin/1.7.4-20040225 ("Benbecula") (UNIX) (Linux/2.6.5 (i686))
Message-Id: <E1BWuK1-0003PT-00@calista.eckenfels.6bone.ka-ip.net>
Date: Sun, 06 Jun 2004 11:52:09 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <Pine.LNX.4.58.0406052244290.7010@ppc970.osdl.org> you wrote:
> It literally does things like
> 
>        random = now() + (getpid() << 16);

It does that  for the unique  filenames and id stamps (maildir format and
message ids). But it should be easy to replace this with a cached getpid
result, if this is realy a performance problem. On a traditional unix system
pid and timestamp should be locally unique for non threaded applications.

> Anyway, you did find something that used more than a handful of getpid() 
> calls, but no, it doesn't qualify as performance-critical, and even 
> despite it's peyote-induced (or hey, some people are just crazy on their 
> own) getpid() usage, it's not a reason to have a buggy glibc.

I wonder if it easyly would be possible to cache the getpid() result in some
thread local segment. Is there any, which is present for all clone flags?
Not tha I care much about this unneeded glibc optimizsation, but more out of
curiousity about the new threadind functionality.

Greetings
Bernd
-- 
eckes privat - http://www.eckes.org/
Project Freefire - http://www.freefire.org/
