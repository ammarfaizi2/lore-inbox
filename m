Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262274AbUCLQeE (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Mar 2004 11:34:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262287AbUCLQeE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Mar 2004 11:34:04 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:2230 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S262274AbUCLQeA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Mar 2004 11:34:00 -0500
To: linux-kernel@vger.kernel.org
CC: Eric Brower <ebrower@usa.net>
Subject: Re: [PATCH] ethtool.h should use userspace-accessible types
References: <40511868.4060109@usa.net>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 12 Mar 2004 09:25:16 -0700
In-Reply-To: <40511868.4060109@usa.net>
Message-ID: <m17jxqf2xf.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Eric Brower <ebrower@usa.net> writes:

> Attached is a patch to 2.4's ethtool.h to use appropriate, userspace-accessible
> data types (__u8 and friends, rather than u8 and friends).

Why there is no #ifdef __KERNEL__ in this header to make it userspace
safe.

> I've also posted a patch against ethtool-1.8 to the sf.net gkernel site that
> cleans-up ethtool-copy.h and the rest in the same manner.

In user space the types from stdint.h likely should be used.  So __u8
and friends looks wrong there as well.

Eric
