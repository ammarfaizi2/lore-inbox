Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266511AbUHOHKi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266511AbUHOHKi (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 Aug 2004 03:10:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266514AbUHOHKi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 Aug 2004 03:10:38 -0400
Received: from pfepc.post.tele.dk ([195.41.46.237]:19848 "EHLO
	pfepc.post.tele.dk") by vger.kernel.org with ESMTP id S266511AbUHOHKf
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 Aug 2004 03:10:35 -0400
Date: Sun, 15 Aug 2004 09:13:05 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: "Randy.Dunlap" <rddunlap@osdl.org>, Andrew Morton <akpm@osdl.org>
Cc: lkml <linux-kernel@vger.kernel.org>, akpm <akpm@osdl.org>
Subject: Re: [PATCH] kconfig.debug for 2.6.8
Message-ID: <20040815071304.GA7182@mars.ravnborg.org>
Mail-Followup-To: "Randy.Dunlap" <rddunlap@osdl.org>,
	Andrew Morton <akpm@osdl.org>, lkml <linux-kernel@vger.kernel.org>
References: <20040814110522.4879ddd4.rddunlap@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040814110522.4879ddd4.rddunlap@osdl.org>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 14, 2004 at 11:05:22AM -0700, Randy.Dunlap wrote:
> 
> Here's the Kconfig.debug patch updated for 2.6.8:
> 
>   http://developer.osdl.org/rddunlap/kconfig/kconfig-debug-268.patch

Hi Andrew.

Any good way we can bring this patch forward?
Currently it causes 9 rejects in -mm, and I understand why you are not
inclined to fix that up.

I can see clashes with at least LOCKMETER, SCHEDSTATS and KGDB in -mm.

Would it be better to divide it in smaller parts?
o lib/Kconfig.debug
o i386 specific changes
o ia64 specific changes
o architectures that do not cause rejects in -mm + -vanilla
o etc.

The rejects may still be present, but make it easier to pick what
applies, and drop the rest for now.

Along the lines of Kconfig.drivers - but hopefully introduced a bit faster.

        Sam
