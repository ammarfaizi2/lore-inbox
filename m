Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261158AbVCZQNK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261158AbVCZQNK (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 26 Mar 2005 11:13:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261159AbVCZQNK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 26 Mar 2005 11:13:10 -0500
Received: from av2-1-sn3.vrr.skanova.net ([81.228.9.107]:52887 "EHLO
	av2-1-sn3.vrr.skanova.net") by vger.kernel.org with ESMTP
	id S261158AbVCZQNG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 26 Mar 2005 11:13:06 -0500
To: Linh Dang <dang.linh@gmail.com>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Hack to get dvd-burning at 8x (instead of 3x) with ide-cd (2.6.11)
References: <3b2b3200503230954346e0665@mail.gmail.com>
From: Peter Osterlund <petero2@telia.com>
Date: 26 Mar 2005 17:12:48 +0100
In-Reply-To: <3b2b3200503230954346e0665@mail.gmail.com>
Message-ID: <m3psxm1j3z.fsf@telia.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linh Dang <dang.linh@gmail.com> writes:

> I'd like to receive  comments/guide-lines about a hack I made to the
> 2.6.11 kernel to improve DVD-burning speed (using growisofs.)
> 
> The basic idea is the 16-pages pipe between mkisofs and growisofs is
> too small for DVD burning (typical 4GB of data.)
> 
> In the hack, pipe_new will simply check for, if privileges permitted,
> the enviroment variable
> PIPE_MAX_ORDER to see if a (much) longer pipe is requested.
> 
> This hack enable me to burn DVD at 8X (instead of 3X) on my old
> P3-450MHz (with growisofs and mkisofs running at SCHED_FIFO.)

This problem is likely caused by limited filesystem and/or hard disk
performance, not a slow CPU. You don't need a kernel patch to get a
bigger buffer though. See:

        http://article.gmane.org/gmane.comp.audio.cd-record/2253

-- 
Peter Osterlund - petero2@telia.com
http://web.telia.com/~u89404340
