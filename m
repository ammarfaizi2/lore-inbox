Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262198AbVEXVeF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262198AbVEXVeF (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 May 2005 17:34:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262195AbVEXVeF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 May 2005 17:34:05 -0400
Received: from pfepb.post.tele.dk ([195.41.46.236]:50581 "EHLO
	pfepb.post.tele.dk") by vger.kernel.org with ESMTP id S262198AbVEXVeC
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 May 2005 17:34:02 -0400
To: linux-kernel@vger.kernel.org
Path: not-for-mail
From: Henrik Storner <henrik-kernel@hswn.dk>
Newsgroups: linux.kernel
Subject: Re: surprisingly slow accept/connect cycle time
Date: Tue, 24 May 2005 21:34:00 +0000 (UTC)
Organization: Linux Users Inc.
Message-ID: <d706k8$kam$1@voodoo.hswn.dk>
References: <17043.37997.993745.877259@newbie.ardi.com>
NNTP-Posting-Host: osiris.hswn.dk
X-Trace: voodoo.hswn.dk 1116970440 20822 172.16.10.100 (24 May 2005 21:34:00 GMT)
X-Complaints-To: usenet@voodoo.hswn.dk
NNTP-Posting-Date: Tue, 24 May 2005 21:34:00 +0000 (UTC)
User-Agent: nn/6.6.5+RFC1522
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In <17043.37997.993745.877259@newbie.ardi.com> "Clifford T. Matthews" <ctm@ardi.com> writes:

>While writing some test code, I was surprised to find a couple
>processes running very slowly.  The attached program illustrates this.
>The program forks and the child attempts to accept 1000 connections.
>The parent attempts to connect 1000 times.  This often takes minutes
>to run, on 2.4 kernels and 2.6 kernels (including 2.6.12-rc4).

Have you tried using non-blocking sockets ?

I've been doing some network programming myself lately, and my apps 
have no problem handling a sustained load of 40 connections/second -
which should handle your testcase in 25 seconds. And I'm quite sure it
will be less, because it has handled peak loads of several hundred
connections per second.

But my program uses non-blocking sockets exclusively.


Henrik

