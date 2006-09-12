Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030220AbWILOtW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030220AbWILOtW (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Sep 2006 10:49:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030219AbWILOtV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Sep 2006 10:49:21 -0400
Received: from zeus.pimb.org ([80.68.88.21]:38162 "EHLO zeus.pimb.org")
	by vger.kernel.org with ESMTP id S1030220AbWILOtU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Sep 2006 10:49:20 -0400
Date: Tue, 12 Sep 2006 16:04:34 +0100
From: Jody Belka <lists-lkml@pimb.org>
To: linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@osdl.org>
Subject: Re: Linux 2.6.18-rc6
Message-ID: <20060912150433.GB2808@pimb.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040523i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Upgrading to this causes my copy of hal (0.5.3-0ubuntu14) to fail to start.
Bisecting tracked it down to the following commit. Reverting just this patch
against 2.6.18-rc6 gets things working again.


9bde7497e0b54178c317fac47a18be7f948dd471 is first bad commit
commit 9bde7497e0b54178c317fac47a18be7f948dd471
Author: Greg Kroah-Hartman <gregkh@suse.de>
Date:   Wed Jun 14 12:14:34 2006 -0700

    [PATCH] USB: make endpoints real struct devices

    This will allow for us to give endpoints a major/minor to create a
    "usbfs2-like" way to access endpoints directly from userspace in an
    easier manner than the current usbfs provides us.

    Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>


-- 
Jody Belka
knew (at) pimb (dot) org

ps. Please CC, as i'm not subscribed to the list. Thanks.


