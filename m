Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932148AbWGaGQf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932148AbWGaGQf (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Jul 2006 02:16:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932168AbWGaGQf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Jul 2006 02:16:35 -0400
Received: from mx1.redhat.com ([66.187.233.31]:55731 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S932148AbWGaGQe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Jul 2006 02:16:34 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
From: Roland McGrath <roland@redhat.com>
To: Arjan van de Ven <arjan@infradead.org>
X-Fcc: ~/Mail/linus
Cc: Hubert Tonneau <hubert.tonneau@fullpliant.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [Fwd: Re: Linux v2.6.18-rc3]
In-Reply-To: Arjan van de Ven's message of  Sunday, 30 July 2006 11:16:13 +0200 <1154250973.2941.8.camel@laptopd505.fenrus.org>
Emacs: or perhaps you'd prefer Russian Roulette, after all?
Message-Id: <20060731061629.F30BA180050@magilla.sf.frob.com>
Date: Sun, 30 Jul 2006 23:16:29 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > Inconsistency detected by ld.so: rtld.c: 1192: ld_main:
> > Assertion '(void *) ph->p_vaddr == _rtld_local_._dl_sysinfo_dso' failed !

This error suggests an older glibc that is not able to handle a relocatable
vDSO image.  A glibc not so ancient won't have that problem.

Chances are you just need to turn on CONFIG_COMPAT_VDSO.  As that option's
documentation says, it's required if you're using a glibc before 2.3.3.


Thanks,
Roland
