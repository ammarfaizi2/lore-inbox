Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262211AbTEAD1m (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Apr 2003 23:27:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262222AbTEAD1m
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Apr 2003 23:27:42 -0400
Received: from [12.47.58.20] ([12.47.58.20]:47243 "EHLO pao-ex01.pao.digeo.com")
	by vger.kernel.org with ESMTP id S262211AbTEAD1l (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Apr 2003 23:27:41 -0400
Date: Wed, 30 Apr 2003 20:40:46 -0700
From: Andrew Morton <akpm@digeo.com>
To: Ben Collins <bcollins@debian.org>
Cc: torvalds@transmeta.com, pavel@ucw.cz, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Fix NULL handler for compat_ioctl
Message-Id: <20030430204046.13fffc7d.akpm@digeo.com>
In-Reply-To: <20030501025955.GA622@phunnypharm.org>
References: <20030501013427.GA516@phunnypharm.org>
	<20030430194124.03fb29db.akpm@digeo.com>
	<20030501025955.GA622@phunnypharm.org>
X-Mailer: Sylpheed version 0.8.11 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 01 May 2003 03:39:55.0908 (UTC) FILETIME=[551D0440:01C30F93]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ben Collins <bcollins@debian.org> wrote:
>
> > - sys_ioctl takes three args, but this vector is going to be called with
> >   four.  That's making assumptions about arg passing conventions which may
> >   not be true.
> > 
> > - sys_ioctl() is asmlinkage, but the caller of this vector doesn't know
> >   that.  Arguments may get put in the wrong place.
> 
> Out of all the register_ioctl32_conversion functions that were
> consolidated with this patch, only s390 and x86_64 did not already use
> this same convention. linux/ioctl32.h already documents (and has always
> been that way) this feature.

Yup. I'm not surprised that it works.  But ick.

> Maybe you feel better about this patch instead?

Infinitely ;)


