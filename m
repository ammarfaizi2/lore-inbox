Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261973AbSJIXxr>; Wed, 9 Oct 2002 19:53:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261984AbSJIXxq>; Wed, 9 Oct 2002 19:53:46 -0400
Received: from adsl-64-166-241-227.dsl.snfc21.pacbell.net ([64.166.241.227]:4257
	"EHLO www.hockin.org") by vger.kernel.org with ESMTP
	id <S261973AbSJIXxp>; Wed, 9 Oct 2002 19:53:45 -0400
From: Tim Hockin <thockin@hockin.org>
Message-Id: <200210092359.g99NxJh05873@www.hockin.org>
Subject: Re: [PATCH] 2.5.41 s390 (8/8): 16 bit uid/gids.
To: davem@redhat.com (David S. Miller)
Date: Wed, 9 Oct 2002 16:59:19 -0700 (PDT)
Cc: torvalds@transmeta.com, thockin@hockin.org, schwidefsky@de.ibm.com,
       linux-kernel@vger.kernel.org
In-Reply-To: <20021009.163853.11929697.davem@redhat.com> from "David S. Miller" at Oct 09, 2002 04:38:53 PM
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> So maybe what you're saying is some "asm/uid16.h" that
> conditionalizes?


It doesn't need to be asm/ - it can all be generic.  You just have
<linux/uid16_convert.h> be the unconditional macro definitions.
<linux/highuid.h> can conditionally include that.  Only downside is that you
have to define the NOP version of the macros in highuid.h, but it's not like
these are growing or evolving.

I'm fine with that or manually defining CONFIG_UID16 - it is really for
special cases.  I just loathe duplicated code :)

Tim
