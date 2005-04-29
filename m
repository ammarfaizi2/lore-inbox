Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262369AbVD2BXI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262369AbVD2BXI (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Apr 2005 21:23:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262368AbVD2BXI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Apr 2005 21:23:08 -0400
Received: from ozlabs.org ([203.10.76.45]:14786 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S262366AbVD2BXE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Apr 2005 21:23:04 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17009.36192.760349.729626@cargo.ozlabs.ibm.com>
Date: Fri, 29 Apr 2005 11:26:56 +1000
From: Paul Mackerras <paulus@samba.org>
To: Trond Myklebust <trond.myklebust@fys.uio.no>
Cc: Russell King <rmk+lkml@arm.linux.org.uk>,
       Benjamin LaHaise <bcrl@kvack.org>, linux-arch@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: [RFC] unify semaphore implementations
In-Reply-To: <1114735358.9738.36.camel@lade.trondhjem.org>
References: <20050428182926.GC16545@kvack.org>
	<20050428234005.A19778@flint.arm.linux.org.uk>
	<1114735358.9738.36.camel@lade.trondhjem.org>
X-Mailer: VM 7.19 under Emacs 21.4.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Trond Myklebust writes:

> It started from a desire to extend the existing implementations to
> support new features such as asynchronous notification. Currently that
> sort of thing is impossible unless your developer-super-powers include
> the ability to herd 24 different subsystem maintainers into working
> together on a solution.

Well, maybe the slow paths could be unified somewhat, and then these
extra features could be added in the slow paths.  I would support
that.  I certainly don't support replacing the current optimized
fast-path implementations with a lowest-common-denominator thing like
Ben was proposing.

Paul.
