Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264382AbTH2Dki (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Aug 2003 23:40:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264388AbTH2Dki
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Aug 2003 23:40:38 -0400
Received: from adsl-66-127-195-58.dsl.snfc21.pacbell.net ([66.127.195.58]:2285
	"EHLO panda.mostang.com") by vger.kernel.org with ESMTP
	id S264382AbTH2Dkh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Aug 2003 23:40:37 -0400
To: "Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCHSET][2.6-test4][0/6]Support for HPET based timer - Take 2
References: <pEGJ.73p.5@gated-at.bofh.it>
From: David Mosberger-Tang <David.Mosberger@acm.org>
Date: 28 Aug 2003 20:40:35 -0700
In-Reply-To: <pEGJ.73p.5@gated-at.bofh.it>
Message-ID: <ugk78xb07g.fsf@panda.mostang.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> On Fri, 29 Aug 2003 01:50:09 +0200, "Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com> said:

  Venkatesh> Resending the patch. A major change from previous version
  Venkatesh> is elimination of fixmap for HPET. Based on Andrew
  Venkatesh> Morton's suggestion, we have a new hook in init/main.c
  Venkatesh> for late_time_init(), at which time we can use ioremap,
  Venkatesh> in place of fixmap.  Impact on other archs:
  Venkatesh> Calibrate_delay() (and hence loops_per_jiffy calculation)
  Venkatesh> has moved down in main.c, from after time_init() to after
  Venkatesh> kmem_cache_init().

  Venkatesh> All comments/feedbacks welcome.

How much is really architecture-specific?  HPET isn't x86-only so
sooner or later, we'll have to move it out of arch/i386 anyhow.

	--david
