Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262046AbVGZVcB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262046AbVGZVcB (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Jul 2005 17:32:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262078AbVGZV3n
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Jul 2005 17:29:43 -0400
Received: from smtp.osdl.org ([65.172.181.4]:34235 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262058AbVGZV32 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Jul 2005 17:29:28 -0400
Date: Tue, 26 Jul 2005 14:31:21 -0700
From: Andrew Morton <akpm@osdl.org>
To: tony.luck@intel.com
Cc: cramerj@intel.com, john.ronciak@intel.com, ganesh.venkatesan@intel.com,
       pavel@ucw.cz, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] e1000: no need for reboot notifier
Message-Id: <20050726143121.41027a19.akpm@osdl.org>
In-Reply-To: <200507262125.j6QLPQ18005509@agluck-lia64.sc.intel.com>
References: <200507262125.j6QLPQ18005509@agluck-lia64.sc.intel.com>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

tony.luck@intel.com wrote:
>
> sys_reboot() now calls device_suspend(), so it is no longer necessary for
> the e1000 driver to register a reboot notifier [in fact doing so results
> in e1000_suspend() getting called twice].

Does this fix the ia64 reboot, or do we still have the mpt-fusion problem?
