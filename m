Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261218AbTI3Ieu (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Sep 2003 04:34:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261223AbTI3Iet
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Sep 2003 04:34:49 -0400
Received: from pizda.ninka.net ([216.101.162.242]:9222 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id S261218AbTI3Ieq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Sep 2003 04:34:46 -0400
Date: Tue, 30 Sep 2003 01:30:25 -0700
From: "David S. Miller" <davem@redhat.com>
To: David Woodhouse <dwmw2@infradead.org>
Cc: bunk@fs.tum.de, acme@conectiva.com.br, netdev@oss.sgi.com,
       pekkas@netcore.fi, lksctp-developers@lists.sourceforge.net,
       linux-kernel@vger.kernel.org
Subject: Re: RFC: [2.6 patch] disallow modular IPv6
Message-Id: <20030930013025.697c786e.davem@redhat.com>
In-Reply-To: <1064910398.21551.41.camel@hades.cambridge.redhat.com>
References: <20030928225941.GW15338@fs.tum.de>
	<20030928231842.GE1039@conectiva.com.br>
	<20030928232403.GX15338@fs.tum.de>
	<20030929220916.19c9c90d.davem@redhat.com>
	<1064903562.6154.160.camel@imladris.demon.co.uk>
	<20030930000302.3e1bf8bb.davem@redhat.com>
	<1064907572.21551.31.camel@hades.cambridge.redhat.com>
	<20030930010855.095c2c35.davem@redhat.com>
	<1064910398.21551.41.camel@hades.cambridge.redhat.com>
X-Mailer: Sylpheed version 0.9.2 (GTK+ 1.2.6; sparc-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 30 Sep 2003 09:26:38 +0100
David Woodhouse <dwmw2@infradead.org> wrote:

> Why would he run 'make'? He'll only run 'make modules' since he only
> enabled one extra module, and then he expects to be able to load it
> without a reboot.

If 'make modules' doesn't check if the config change has hit a
dependency that requires the core kernel image to be rebuilt, we need
to fix that.  'make modules' depends upon the kernel image.

At the very least, it should refuse to build the modules and tell the
user what he needs to do first.

All you've shown me is a bug in the build system, not a fundamental
issue with module enables creating changes to the main kernel image.
