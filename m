Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268551AbTBWUFO>; Sun, 23 Feb 2003 15:05:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268553AbTBWUFO>; Sun, 23 Feb 2003 15:05:14 -0500
Received: from 5-077.ctame701-1.telepar.net.br ([200.193.163.77]:16348 "EHLO
	5-077.ctame701-1.telepar.net.br") by vger.kernel.org with ESMTP
	id <S268551AbTBWUFM>; Sun, 23 Feb 2003 15:05:12 -0500
Date: Sun, 23 Feb 2003 17:14:47 -0300 (BRT)
From: Rik van Riel <riel@imladris.surriel.com>
To: David Mansfield <lkml@dm.cobite.com>
cc: linux-kernel@vger.kernel.org,
       Marc-Christian Petersen <m.c.p@wolk-project.de>
Subject: Re: oom killer and its superior braindamage in 2.4
In-Reply-To: <Pine.LNX.4.44.0302231301400.23778-100000@admin>
Message-ID: <Pine.LNX.4.50L.0302231711500.2206-100000@imladris.surriel.com>
References: <Pine.LNX.4.44.0302231301400.23778-100000@admin>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 23 Feb 2003, David Mansfield wrote:

> If you read my post, the bug is that the kernel CANNOT kill that
> process?  Why?  If it's really a bad process, shouldn't it be the one
> that gets killed?

> This is my question, and I don't see how the patch addresses it.

And you won't see one, either.  You cannot change the
semantics of uninterruptible sleep, nor can the OOM
killer change other device driver things.

This means the OOM killer has little choice but to
"hope for the best" and pick another process if the
first process chosen can't exit.

If you think you can fix all drivers to work fine
when tasks suddenly disappear, I guess you might
wnat to create such a patch ...

regards,

Rik
-- 
Engineers don't grow up, they grow sideways.
http://www.surriel.com/		http://kernelnewbies.org/
