Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964881AbVL1Tnr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964881AbVL1Tnr (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Dec 2005 14:43:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964891AbVL1Tnr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Dec 2005 14:43:47 -0500
Received: from 213-140-2-70.ip.fastwebnet.it ([213.140.2.70]:36583 "EHLO
	aa003msg.fastwebnet.it") by vger.kernel.org with ESMTP
	id S964881AbVL1Tnr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Dec 2005 14:43:47 -0500
Date: Wed, 28 Dec 2005 20:45:12 +0100
From: Paolo Ornati <ornati@fastwebnet.it>
To: Peter Williams <pwil3058@bigpond.net.au>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Con Kolivas <kernel@kolivas.org>, Ingo Molnar <mingo@elte.hu>
Subject: Re: [SCHED] Totally WRONG prority calculation with specific
 test-case (since 2.6.10-bk12)
Message-ID: <20051228204512.592a7fa8@localhost>
In-Reply-To: <43B29540.1030904@bigpond.net.au>
References: <20051227190918.65c2abac@localhost>
	<20051227224846.6edcff88@localhost>
	<43B1D551.5050503@bigpond.net.au>
	<20051228112058.2c0c1137@localhost>
	<43B29540.1030904@bigpond.net.au>
X-Mailer: Sylpheed-Claws 2.0.0-rc1 (GTK+ 2.6.10; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 29 Dec 2005 00:38:08 +1100
Peter Williams <pwil3058@bigpond.net.au> wrote:

> Thanks for this data.  It will enable me to make some mods to the 
> spa_xxx and zaphod schedulers.

Ok, but keep in mind that these numbers are just "snapshots". With
almost all schedulers the priority of the CPU-eater transcode and other
processes fluctuate a bit (an exception here is nicksched, that gives
priority 40 to transcode and never change it).

It seems also that small variation of the priority can affect seriously
my DD test case running time (expecially, I think, with schedulers that
give to "transcode" a better-or-equal priority than "dd" -->
ingosched/staircaise).

This is another mail in witch you weren't in CC that explains it better:

http://www.ussg.iu.edu/hypermail/linux/kernel/0512.3/0647.html

-- 
	Paolo Ornati
	Linux 2.6.15-rc7-plugsched on x86_64
