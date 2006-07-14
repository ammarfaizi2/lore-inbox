Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422713AbWGNSzy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422713AbWGNSzy (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Jul 2006 14:55:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161293AbWGNSzx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Jul 2006 14:55:53 -0400
Received: from canuck.infradead.org ([205.233.218.70]:19591 "EHLO
	canuck.infradead.org") by vger.kernel.org with ESMTP
	id S1161292AbWGNSzw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Jul 2006 14:55:52 -0400
Subject: Re: 2.6.18 Headers - Long
From: David Woodhouse <dwmw2@infradead.org>
To: Jim Gifford <maillist@jg555.com>
Cc: LKML <linux-kernel@vger.kernel.org>, ralf@linux-mips.org
In-Reply-To: <44B6FEDE.4040505@jg555.com>
References: <44B443D2.4070600@jg555.com>
	 <1152836749.31372.36.camel@shinybook.infradead.org>
	 <44B6FEDE.4040505@jg555.com>
Content-Type: text/plain
Date: Fri, 14 Jul 2006 19:55:32 +0100
Message-Id: <1152903332.3191.87.camel@pmac.infradead.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.6.dwmw2.1) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by canuck.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-07-13 at 19:18 -0700, Jim Gifford wrote:
>     asm-ia64/page.h - Config variables
>     asm-sparc/page.h - Config variables
>    asm-sparc64/page.h - Config variables

Yeah, just as with MIPS, the bits which are affected by CONFIG variables
just shouldn't be outside the __KERNEL__ ifdef at all -- they shouldn't
be seen.

>     asm-powerpc/page.h - Config variables 

Er, asm-powerpc/page.h is empty after unifdef, which is entirely
correect. In fact asm/page.h is one of the files which should probably
be removed from user visibility entirely. There's nothing there which
userspace should see, in general.

-- 
dwmw2

