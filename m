Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932250AbWBQGAW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932250AbWBQGAW (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Feb 2006 01:00:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932267AbWBQGAW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Feb 2006 01:00:22 -0500
Received: from ozlabs.org ([203.10.76.45]:51602 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S932250AbWBQGAV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Feb 2006 01:00:21 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17397.26134.234593.858037@cargo.ozlabs.ibm.com>
Date: Fri, 17 Feb 2006 16:58:46 +1100
From: Paul Mackerras <paulus@samba.org>
To: Andrew Morton <akpm@osdl.org>
Cc: Kyle McMartin <kyle@parisc-linux.org>, torvalds@osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Generic is_compat_task helper
In-Reply-To: <20060216214939.78aebcbb.akpm@osdl.org>
References: <20060217025242.GM13492@quicksilver.road.mcmartin.ca>
	<20060216214939.78aebcbb.akpm@osdl.org>
X-Mailer: VM 7.19 under Emacs 21.4.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton writes:

> What continues to bug me about this (in a high-level hand-wavy sort of way)
> is that this is an attribute of the mm_struct, not of the task_struct.

It's not only an attribute of the mm_struct; compat-ness doesn't just
imply a restricted address space, it implies a different setting of
the processor when the task is running, a different set of system
calls, different interpretation of syscall arguments, etc.

Paul.
