Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751183AbVHVVCe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751183AbVHVVCe (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Aug 2005 17:02:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751184AbVHVVCd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Aug 2005 17:02:33 -0400
Received: from smtp.osdl.org ([65.172.181.4]:13800 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751183AbVHVVCc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Aug 2005 17:02:32 -0400
Date: Mon, 22 Aug 2005 13:59:13 -0700
From: Chris Wright <chrisw@osdl.org>
To: Roman Zippel <zippel@linux-m68k.org>
Cc: Chris Wright <chrisw@osdl.org>, Adrian Bunk <bunk@stusta.de>,
       Andrew Morton <akpm@osdl.org>, linux-security-module@wirex.com,
       linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] SECURITY must depend on SYSFS
Message-ID: <20050822205913.GB7762@shell0.pdx.osdl.net>
References: <20050822162050.GC9927@stusta.de> <20050822173003.GS7762@shell0.pdx.osdl.net> <Pine.LNX.4.61.0508222245260.3743@scrub.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0508222245260.3743@scrub.home>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Roman Zippel (zippel@linux-m68k.org) wrote:
> What's wrong with a normal dependency?

Trying to enable when SYSFS under fs->pseudo->fs but security is under
security-> is just confusing, with no obvious (user perspective)
dependency.

> Please don't abuse select, use it only if you really have to.

OK, depends will be fine, esp. since it's just effecting CONFIG_EMBEDDED.

thanks,
-chris
