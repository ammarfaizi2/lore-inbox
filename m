Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262256AbUFWPbP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262256AbUFWPbP (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Jun 2004 11:31:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264278AbUFWPbP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Jun 2004 11:31:15 -0400
Received: from [66.199.228.3] ([66.199.228.3]:23822 "EHLO xdr.com")
	by vger.kernel.org with ESMTP id S262256AbUFWPbO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Jun 2004 11:31:14 -0400
Date: Wed, 23 Jun 2004 08:31:12 -0700
From: David Ashley <dash@xdr.com>
Message-Id: <200406231531.i5NFVCuf018957@xdr.com>
To: linux-kernel@vger.kernel.org
Subject: Cached memory never gets released
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linux 2.4.23 on x86, 128M memory available
Free outputs this:
             total       used       free     shared    buffers     cached
Mem:        119204     109592       9612          0         60      92136
-/+ buffers/cache:      17396     101808
Swap:            0          0          0

The root filesystem is NFS, no hard drives involved.
When I run a simple program that just mallocs memory and fills it with
random data, the kernel kills the process after it has only allocated 8 or
9 megs. The 92136K of cached memory can't get released for some reason.
What is happening?

Thanks very much!
-Dave
