Return-Path: <linux-kernel-owner+w=401wt.eu-S964890AbWLMCRm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964890AbWLMCRm (ORCPT <rfc822;w@1wt.eu>);
	Tue, 12 Dec 2006 21:17:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964895AbWLMCRm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Dec 2006 21:17:42 -0500
Received: from mx1.redhat.com ([66.187.233.31]:48342 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S964890AbWLMCRl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Dec 2006 21:17:41 -0500
X-Greylist: delayed 419 seconds by postgrey-1.27 at vger.kernel.org; Tue, 12 Dec 2006 21:17:41 EST
Date: Tue, 12 Dec 2006 18:09:24 -0800
From: Pete Zaitcev <zaitcev@redhat.com>
To: zippel@linux-m68k.org
Cc: zaitcev@redhat.com, jbaron@redhat.com, linux-kernel@vger.kernel.org
Subject: Weird code in scripts/kconfig/Makefile
Message-Id: <20061212180924.c998f9a8.zaitcev@redhat.com>
Organization: Red Hat, Inc.
X-Mailer: Sylpheed version 2.2.10 (GTK+ 2.10.6; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Roman & All:

In 2.6.19 (and Linus' curent tree), I found the following:

          libpath=$$dir/lib; lib=qt; osdir=""; \
          $(HOSTCXX) -print-multi-os-directory > /dev/null 2>&1 && \
            osdir=x$$($(HOSTCXX) -print-multi-os-directory); \
          test -d $$libpath/$$osdir && libpath=$$libpath/$$osdir; \

What does the little 'x' do in front of $$(foo)? It looks suspiciously
like a typo to me.

I think Jason caught it, but I didn't see a correction sent out.

-- Pete
