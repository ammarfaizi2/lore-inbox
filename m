Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261247AbVFHOYM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261247AbVFHOYM (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Jun 2005 10:24:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261259AbVFHOYL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Jun 2005 10:24:11 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:13806 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S261247AbVFHOXZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Jun 2005 10:23:25 -0400
Date: Wed, 8 Jun 2005 16:23:10 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Jeff Garzik <jgarzik@pobox.com>, Netdev list <netdev@oss.sgi.com>,
       kernel list <linux-kernel@vger.kernel.org>,
       "James P. Ketrenos" <ipw2100-admin@linux.intel.com>
Subject: ipw2100: firmware problem
Message-ID: <20050608142310.GA2339@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

I'm fighting with firmware problem: if ipw2100 is compiled into
kernel, it is loaded while kernel boots and firmware loader is not yet
available. That leads to uninitialized (=> useless) adapter.

What's the prefered way to solve this one? Only load firmware when
user does ifconfig eth1 up? [It is wifi, it looks like it would be
better to start firmware sooner so that it can associate to the
AP...].

Last initcall available in kernel is late_initcall; that's not late
enough for me. Is adding one more initcall that is started when
userland is available a solution?
								Pavel
