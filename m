Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264982AbSJPJLR>; Wed, 16 Oct 2002 05:11:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264983AbSJPJLR>; Wed, 16 Oct 2002 05:11:17 -0400
Received: from zero.aec.at ([193.170.194.10]:41477 "EHLO zero.aec.at")
	by vger.kernel.org with ESMTP id <S264982AbSJPJLR>;
	Wed, 16 Oct 2002 05:11:17 -0400
To: Jakub Jelinek <jakub@redhat.com>
Cc: mingo@elte.hu, linux-kernel@vger.kernel.org
Subject: Re: [patch] mmap-speedup-2.5.42-C3
References: <m3bs5vl79h.fsf@averell.firstfloor.org>
	<Pine.LNX.4.44.0210160957150.4018-100000@localhost.localdomain>
	<20021016040754.C5659@devserv.devel.redhat.com>
From: Andi Kleen <ak@muc.de>
Date: 16 Oct 2002 11:16:57 +0200
In-Reply-To: <20021016040754.C5659@devserv.devel.redhat.com>
Message-ID: <m3u1jmpwty.fsf@averell.firstfloor.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jakub Jelinek <jakub@redhat.com> writes:

You can argue against it, but it doesn't change the fact that 
get_unmapped_area is a significant user of CPU on a KDE startup. You
can do the oprofile yourself if you don't believe me. And where else should 
it come from other than from mapping shared libraries ?

This includes X server startup, but at least my X has a much shorter
/proc/*/maps than a KDE program, so I don't think X is a significant
consumer of vmas.

-Andi
