Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267403AbTAWWQy>; Thu, 23 Jan 2003 17:16:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267439AbTAWWQy>; Thu, 23 Jan 2003 17:16:54 -0500
Received: from bjl1.asuk.net.64.29.81.in-addr.arpa ([81.29.64.88]:14297 "EHLO
	bjl1.asuk.net") by vger.kernel.org with ESMTP id <S267441AbTAWWQv>;
	Thu, 23 Jan 2003 17:16:51 -0500
Date: Thu, 23 Jan 2003 22:26:00 +0000
From: Jamie Lokier <jamie@shareable.org>
To: Ingo Oeser <ingo.oeser@informatik.tu-chemnitz.de>
Cc: Kevin Lawton <kevinlawton2001@yahoo.com>, linux-kernel@vger.kernel.org
Subject: Re: Simple patches for Linux as a guest OS in a plex86 VM (please consider)
Message-ID: <20030123222600.GB8581@bjl1.asuk.net>
References: <20030122182341.66324.qmail@web80309.mail.yahoo.com> <20030123192829.A628@nightmaster.csn.tu-chemnitz.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030123192829.A628@nightmaster.csn.tu-chemnitz.de>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Oeser wrote:
> Yes, what you do is nice, but generates much code. What about
> this for pushfl:
> [11 lines of asm]

What about:

	.macro	pushfl
	call __pushfl
	.endm

	.macro  popfl
	call __popfl
	.endm

There, nice and small.

-- Jamie
