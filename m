Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261645AbVDEKF7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261645AbVDEKF7 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Apr 2005 06:05:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261707AbVDEKCq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Apr 2005 06:02:46 -0400
Received: from ozlabs.org ([203.10.76.45]:39581 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S261645AbVDEJ6b (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Apr 2005 05:58:31 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16978.24904.483963.622026@cargo.ozlabs.ibm.com>
Date: Tue, 5 Apr 2005 19:58:32 +1000
From: Paul Mackerras <paulus@samba.org>
To: Christoph Hellwig <hch@infradead.org>
Cc: Dave Airlie <airlied@gmail.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: 2.6.12-rc2-mm1
In-Reply-To: <20050405095445.GA29246@infradead.org>
References: <20050405000524.592fc125.akpm@osdl.org>
	<20050405074405.GE26208@infradead.org>
	<21d7e99705040502073dfa5e5@mail.gmail.com>
	<16978.22617.338768.775203@cargo.ozlabs.ibm.com>
	<20050405093020.GA28620@infradead.org>
	<16978.24070.786761.641930@cargo.ozlabs.ibm.com>
	<20050405094535.GA29095@infradead.org>
	<16978.24509.527688.799274@cargo.ozlabs.ibm.com>
	<20050405095445.GA29246@infradead.org>
X-Mailer: VM 7.19 under Emacs 21.4.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Hellwig writes:

> E.g. on my ia64 box CONFIG_COMPAT is set because I have support compiled
> in for running i386 apps.  But I don't want dri to hand out 32bit handles
> everywhere just because of that, because I most certainly won't be running
> i386 OpenGL apps.

The handle for a _DRM_SHM area is almost completely arbitrary, why do
you care whether it fits in 32 bits or not?  All that matters is that
you can take the handle you get and use it as the offset in an mmap
call.  The CONFIG_COMPAT changes don't break 64-bit clients.

Paul.
