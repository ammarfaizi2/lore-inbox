Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261551AbVFHTUI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261551AbVFHTUI (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Jun 2005 15:20:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261555AbVFHTUH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Jun 2005 15:20:07 -0400
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:25319
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S261551AbVFHTUD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Jun 2005 15:20:03 -0400
Date: Wed, 08 Jun 2005 12:19:50 -0700 (PDT)
Message-Id: <20050608.121950.104038734.davem@davemloft.net>
To: arnd@arndb.de
Cc: torvalds@osdl.org, paulus@samba.org, akpm@osdl.org, anton@samba.org,
       linux-kernel@vger.kernel.org, jk@blackdown.de
Subject: Re: [PATCH] ppc64: Fix PER_LINUX32 behaviour
From: "David S. Miller" <davem@davemloft.net>
In-Reply-To: <200506082049.51707.arnd@arndb.de>
References: <17062.56723.535978.961340@cargo.ozlabs.ibm.com>
	<Pine.LNX.4.58.0506081022030.2286@ppc970.osdl.org>
	<200506082049.51707.arnd@arndb.de>
X-Mailer: Mew version 3.3 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>
Date: Wed, 8 Jun 2005 20:49:48 +0200

> With the LINUX32 personality, you can build 32 bit binaries through
> autoconf, rpmbuild, or the kernel without pretending to be
> cross-compiling. It may not be the best solution, but people seem to
> rely on it and the patch brings ppc64 in line with how it works on
> the other architectures.

I totally agree, this has a large precedence on many platforms
and there are even gcc frontends that check the uname output
to decide what code model to output by default.
