Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281857AbRKWBZo>; Thu, 22 Nov 2001 20:25:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281856AbRKWBZe>; Thu, 22 Nov 2001 20:25:34 -0500
Received: from ns01.netrox.net ([64.118.231.130]:61382 "EHLO smtp01.netrox.net")
	by vger.kernel.org with ESMTP id <S281854AbRKWBZZ>;
	Thu, 22 Nov 2001 20:25:25 -0500
Subject: Re: [patch] sched_[set|get]_affinity() syscall, 2.4.15-pre9
From: Robert Love <rml@tech9.net>
To: Andreas Dilger <adilger@turbolabs.com>
Cc: Ryan Cumming <bodnar42@phalynx.dhs.org>, linux-kernel@vger.kernel.org,
        mingo@elte.hu
In-Reply-To: <20011122181125.S1308@lynx.no>
In-Reply-To: <Pine.LNX.4.33.0111220951240.2446-300000@localhost.localdomain>
	<1006472754.1336.0.camel@icbm> <E16744i-0004zQ-00@localhost>
	<1006476685.1331.9.camel@icbm>  <20011122181125.S1308@lynx.no>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/0.99.1+cvs.2001.11.14.08.58 (Preview Release)
Date: 22 Nov 2001 20:16:45 -0500
Message-Id: <1006478207.1632.16.camel@icbm>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2001-11-22 at 20:11, Andreas Dilger wrote:

> Rather use something else, like CAP_SYS_NICE.  It ties in with the idea
> of scheduling, and doesn't further abuse the CAP_SYS_ADMIN capability.
> CAP_SYS_ADMIN, while it has a good name, has become the catch-all of
> capabilities, and if you have it, it is nearly the keys to the kingdom,
> just like root.

Ah, forgot about CAP_SYS_NICE ... indeed, a better idea.  I suppose if
people want it a CAP_SYS_CPU_AFFINITY could do, but this is a simple and
rare enough task that we are better off sticking it under something
else.

	Robert Love

