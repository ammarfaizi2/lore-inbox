Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262612AbVBBQea@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262612AbVBBQea (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Feb 2005 11:34:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262295AbVBBQd4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Feb 2005 11:33:56 -0500
Received: from canuck.infradead.org ([205.233.218.70]:1289 "EHLO
	canuck.infradead.org") by vger.kernel.org with ESMTP
	id S262586AbVBBQZv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Feb 2005 11:25:51 -0500
Subject: Re: [PATCH 2.6.11-rc2] Move <linux/prio_tree.h> down in
	<linux/fs.h>
From: David Woodhouse <dwmw2@infradead.org>
To: Tom Rini <trini@kernel.crashing.org>
Cc: Andrew Morton <akpm@osdl.org>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20050201160642.GA15359@smtp.west.cox.net>
References: <20050201160642.GA15359@smtp.west.cox.net>
Content-Type: text/plain
Date: Wed, 02 Feb 2005 16:21:23 +0000
Message-Id: <1107361283.12383.0.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-3.dwmw2.1) 
Content-Transfer-Encoding: 7bit
X-Spam-Score: 0.0 (/)
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by canuck.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-02-01 at 09:06 -0700, Tom Rini wrote:
> <linux/prio_tree.h> is unsafe for inclusion by userland apps, but it
> is in the userland-exposed portion of <linux/fs.h>.  It's only needed
> in the __KERNEL__ protected portion of the file, so move the #include
> down to there.

You accidentally posted this patch to the kernel list, not to the
maintainers of the libc-kernelheaders package. And you might as well
just remove the offending #include rather than moving it to a section of
the file which is never used.

-- 
dwmw2

