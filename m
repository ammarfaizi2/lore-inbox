Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261558AbVF0Kaq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261558AbVF0Kaq (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Jun 2005 06:30:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261431AbVF0Kaq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Jun 2005 06:30:46 -0400
Received: from ozlabs.org ([203.10.76.45]:8361 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S262133AbVF0KaQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Jun 2005 06:30:16 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17087.54576.343873.481072@cargo.ozlabs.ibm.com>
Date: Mon, 27 Jun 2005 20:30:08 +1000
From: Paul Mackerras <paulus@samba.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Dave Airlie <airlied@linux.ie>, torvalds@osdl.org,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       "David S. Miller" <davem@davemloft.net>
Subject: Re: [git patch] DRM 32/64 ioctl patch..
In-Reply-To: <200506270811.32758.arnd@arndb.de>
References: <Pine.LNX.4.58.0506261313390.3269@skynet>
	<200506270811.32758.arnd@arndb.de>
X-Mailer: VM 7.19 under Emacs 21.4.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Arnd Bergmann writes:

> Are you sure that comment still applies? I can't find any reference
> to set_fs in the drm code and compat_alloc_user_space() based handlers
> do not have the problem.

No, the comment is out of date; I changed the code to use
compat_alloc_user_space().

> (void __user *) arg should really be compat_ptr(arg). In theory,
> this is only necessary on s390, which does not implement drm,
> but we just do it the right way so other people don't copy
> the incorrect code.

Good point.

Paul.
