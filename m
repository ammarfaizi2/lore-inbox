Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S275055AbTHGBSq (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Aug 2003 21:18:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S275057AbTHGBSp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Aug 2003 21:18:45 -0400
Received: from sngrel7.hp.com ([192.6.86.111]:23279 "EHLO sngrel7.hp.com")
	by vger.kernel.org with ESMTP id S275055AbTHGBSo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Aug 2003 21:18:44 -0400
From: Martin Pool <mbp@sourcefrog.net>
Subject: Re: [patch] [Kconfig] disable GEN_RTC on ia-64
Date: Thu, 07 Aug 2003 11:18:25 +1000
User-Agent: Pan/0.14.0 (I'm Being Nibbled to Death by Cats!)
Message-Id: <pan.2003.08.07.01.18.20.270606@sourcefrog.net>
References: <20030806074312.GT22302@vexed.ozlabs.hp.com> <20030806163753.GB579@ip68-0-152-218.tc.ph.cox.net>
To: Tom Rini <trini@kernel.crashing.org>, linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 06 Aug 2003 09:37:53 -0700, Tom Rini wrote:

> I think that this is the wrong approach.  genrtc allows the platform to
> specify how the rtc is to be accessed.  Therefore, efirtc.c could quite
> probably be removed in favor of genrtc.c, if the proper read/write
> functions are provided, and if genrtc gets alarm code, which is something
> others (rmk at least) have asked for.

Yes, since EFI is the only method for this platform it should probably
be the platform's only implementation of genrtc.

At the moment it is a bit confusing because "generic RTC" sounds like
something that ought to work on any platform, when of course it does
not.  So if the changes to genrtc would be large, perhaps it would be
better to just fix Kconfig for now...

Do you think a patch to refactor efirtc into genrtc would be accepted?

-- 
Martin


