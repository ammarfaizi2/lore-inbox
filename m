Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261639AbVDEJLi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261639AbVDEJLi (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Apr 2005 05:11:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261640AbVDEJLh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Apr 2005 05:11:37 -0400
Received: from ozlabs.org ([203.10.76.45]:59804 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S261639AbVDEJL1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Apr 2005 05:11:27 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16978.22078.532831.667378@cargo.ozlabs.ibm.com>
Date: Tue, 5 Apr 2005 19:11:26 +1000
From: Paul Mackerras <paulus@samba.org>
To: Christoph Hellwig <hch@infradead.org>
Cc: Andrew Morton <akpm@osdl.org>, Dave Airlie <airlied@linux.ie>,
       linux-kernel@vger.kernel.org
Subject: Re: 2.6.12-rc2-mm1
In-Reply-To: <20050405074405.GE26208@infradead.org>
References: <20050405000524.592fc125.akpm@osdl.org>
	<20050405074405.GE26208@infradead.org>
X-Mailer: VM 7.19 under Emacs 21.4.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Hellwig writes:

> Those DRI callers aren't in mainline but introduced in bk-drm.patch,
> looks like the DRI folks need beating with a big stick..

Settle down Christoph, the compat_ioctl method is less than 3 months
old, has only been in one official 2.6.x release, and isn't documented
at all in the Documentation directory AFAICS.  Don't be so impatient.

Anyway, I did the 32-bit ioctl conversion stuff for the DRM.  I'll
look at changing it to use compat_ioctl.  The big question of course
is whether the DRM code will work correctly without the BKL held.

Paul.
