Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261493AbVEJFQI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261493AbVEJFQI (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 May 2005 01:16:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261546AbVEJFQI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 May 2005 01:16:08 -0400
Received: from fmr24.intel.com ([143.183.121.16]:28637 "EHLO
	scsfmr004.sc.intel.com") by vger.kernel.org with ESMTP
	id S261493AbVEJFQF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 May 2005 01:16:05 -0400
Date: Mon, 9 May 2005 22:15:57 -0700
From: tony.luck@intel.com
Message-Id: <200505100515.j4A5FvR16856@unix-os.sc.intel.com>
To: Jeff Garzik <jgarzik@pobox.com>
CC: torvalds@osdl.org, lkml <linux-kernel@vger.kernel.org>,
       Yoav Zach <yoav.zach@intel.com>
Subject: Re: [PATCH]: Don't force O_LARGEFILE for 32 bit processes on ia64 - 2.6.12-rc3
In-Reply-To: <42801232.8000009@pobox.com>
References: <20050509214710.419.qmail@web50610.mail.yahoo.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Garzik wrote:
> O_LARGEFILE works great on my 32-bit platform.
> 
> Is this an ABI bug?  O_LARGEFILE should be OK for 32-bit processes.

That's fine if the 32-bit process wants to have O_LARGEFILE ... but not
all of them do ... some 32-bit binaries are compiled without O_LARGEFILE
support, and will be surprised to have it given to them.

This is particularly an issue on ia64, where 32-bit processes may be
emulated in s/w ... by a 64-bit process.

-Tony
