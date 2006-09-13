Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750850AbWIMRxX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750850AbWIMRxX (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Sep 2006 13:53:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750847AbWIMRxX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Sep 2006 13:53:23 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:48518 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1750839AbWIMRxW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Sep 2006 13:53:22 -0400
Subject: Re: OT: calling kernel syscall manually
From: David Woodhouse <dwmw2@infradead.org>
To: guest01 <guest01@gmail.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <45083731.7040904@gmail.com>
References: <4506A295.6010206@gmail.com>
	 <1158068045.9189.93.camel@hades.cambridge.redhat.com>
	 <450717A5.90509@cfl.rr.com> <1158101019.18619.113.camel@pmac.infradead.org>
	 <45083731.7040904@gmail.com>
Content-Type: text/plain
Date: Wed, 13 Sep 2006 18:52:37 +0100
Message-Id: <1158169957.18619.199.camel@pmac.infradead.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.3 (2.6.3-1.fc5.5.dwmw2.1) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-09-13 at 18:52 +0200, guest01 wrote:
> So these macros are no longer available in the latest kernel versions?
> Ok, if that's true, I will use the example with the inline assembler
> code and write a few lines, that these "macros" are no longer supported.

Yes, as part of the cleanups which accompanied the new 'make
headers_install' target for creating sanitised kernel headers, all of
the _syscallX() stuff was removed from user visibility.

Unfortunately, Linus subsequently applied a patch which was sent to him
privately without review on the mailing list, which reverted that fixup
and made _syscallX() visible in userspace again on a couple of
architectures. That regressions should hopefully be fixed again before
2.6.18 is finally released though -- and in fact we're probably going to
kill off _all_ use of _syscallX(), even in the kernel, before 2.6.19.

-- 
dwmw2

