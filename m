Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265655AbTF3J0y (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Jun 2003 05:26:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265801AbTF3J0y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Jun 2003 05:26:54 -0400
Received: from lindsey.linux-systeme.com ([80.190.48.67]:17427 "EHLO
	mx00.linux-systeme.com") by vger.kernel.org with ESMTP
	id S265655AbTF3J0x (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Jun 2003 05:26:53 -0400
From: Marc-Christian Petersen <m.c.p@wolk-project.de>
Organization: Working Overloaded Linux Kernel
To: Con Kolivas <kernel@kolivas.org>, linux-kernel@vger.kernel.org
Subject: Re: patch-O1int-0306281420 for 2.5.73 interactivity
Date: Mon, 30 Jun 2003 11:39:50 +0200
User-Agent: KMail/1.5.2
Cc: Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>,
       Zwane Mwaikambo <zwane@linuxpower.ca>, Andrew Morton <akpm@digeo.com>,
       Mike Galbraith <efault@gmx.de>
References: <200306281516.12975.kernel@kolivas.org> <200306291457.40524.kernel@kolivas.org> <200306301535.49732.kernel@kolivas.org>
In-Reply-To: <200306301535.49732.kernel@kolivas.org>
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200306301135.37960.m.c.p@wolk-project.de>
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 30 June 2003 07:35, Con Kolivas wrote:

Hi Con,

> A patch to reduce audio skipping and X jerking under load.
> It's looking seriously like I'm talking to myelf here, but just in case
> there are lurkers testing this patch, there's a big bug that made it think
> jiffy wraparound was occurring so interactive tasks weren't receiving the
> boost they deserved. Here is a patch with the fix in.
> How to use if you're still thinking of testing:
> Use with Hz 1000, and use the granularity patch I posted as well for
> smoothing X off.
using 2.5.73-mm2, 1000HZ, patch-O1int-0306301522, patch-granularity-0306271314

"make -j16 bzImage modules" of a 2.5.73-mm2 tree makes XMMS skip easily, X is 
not very smooth, mouse jumps, X is sometimes not accepting anything for 5-10 
seconds every 1-2 minutes, everything freezes, also XMMS, Kmail freezes, an 
Xterm needs ~40 seconds to open. If the machine is totally idle, Kmail 
freezes also for ~5 seconds. Tried running X with 0, -1 and -11 w/o much 
difference.

I still like Felipe's O(1) patch.

Machine: Celeron 1,3GHz, 512MB RAM, 512MB SWAP, IDE (UDMA100), ext3fs, X4.3, 
WindowMaker.

Please, can we invite Ingo to this thread? I think it is now _really_ the time 
to get this fixed up :)

ciao, Marc

