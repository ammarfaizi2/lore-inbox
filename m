Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269800AbUJNCWP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269800AbUJNCWP (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Oct 2004 22:22:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269812AbUJNCWO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Oct 2004 22:22:14 -0400
Received: from brown.brainfood.com ([146.82.138.61]:9856 "EHLO
	gradall.private.brainfood.com") by vger.kernel.org with ESMTP
	id S269800AbUJNCWN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Oct 2004 22:22:13 -0400
Date: Wed, 13 Oct 2004 21:22:10 -0500 (CDT)
From: Adam Heath <doogie@debian.org>
X-X-Sender: adam@gradall.private.brainfood.com
To: Ingo Molnar <mingo@elte.hu>
cc: linux-kernel@vger.kernel.org
Subject: Re: [patch] Real-Time Preemption, -VP-2.6.9-rc4-mm1-U0
In-Reply-To: <20041014013147.GA32581@elte.hu>
Message-ID: <Pine.LNX.4.58.0410132119580.1244@gradall.private.brainfood.com>
References: <OF29AF5CB7.227D041F-ON86256F2A.0062D210@raytheon.com>
 <20041011215909.GA20686@elte.hu> <20041012091501.GA18562@elte.hu>
 <20041012123318.GA2102@elte.hu> <20041012195424.GA3961@elte.hu>
 <20041013061518.GA1083@elte.hu> <20041014002433.GA19399@elte.hu>
 <Pine.LNX.4.58.0410132015530.1244@gradall.private.brainfood.com>
 <20041014013147.GA32581@elte.hu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 14 Oct 2004, Ingo Molnar wrote:

>
> * Adam Heath <doogie@debian.org> wrote:
>
> > The bug that caused it to crash was in mm/highmem.c.
>
> could you disable HIGHMEM (or at least HIGHPTE) and try again? Some
> last-minute bug slipped into that code.

Well, it's a little better, but it still died.  Just took longer.

However, this time, my kern.log got corrupted.  I saw 2 scheduling while
atomic errors in dmesg(before it locked up), but only one in kern.log, and a
bunch of random data(using ext3 data=writeback).  Symptoms this time around
were laggy keyboard handling, zombie processes(this may have been caused by
the scheduling while atomic problem), and ctrl-c not working.

I'll try again tomorrow, and hopefully get more data.
