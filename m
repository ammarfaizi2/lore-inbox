Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261482AbVGGNUb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261482AbVGGNUb (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Jul 2005 09:20:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261475AbVGGNU0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Jul 2005 09:20:26 -0400
Received: from mx1.suse.de ([195.135.220.2]:10698 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S261484AbVGGNTL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Jul 2005 09:19:11 -0400
Date: Thu, 7 Jul 2005 15:19:06 +0200
From: Andi Kleen <ak@suse.de>
To: Prasanna S Panchamukhi <prasanna@in.ibm.com>
Cc: akpm@osdl.org, Andi Kleen <ak@suse.de>,
       "David S. Miller" <davem@davemloft.net>, systemtap@sources.redhat.com,
       linux-kernel@vger.kernel.org
Subject: Re: [2/6 PATCH] Kprobes : Prevent possible race conditions i386 changes
Message-ID: <20050707131906.GY21330@wotan.suse.de>
References: <20050707101015.GE12106@in.ibm.com> <20050707101119.GF12106@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050707101119.GF12106@in.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> -fastcall void do_page_fault(struct pt_regs *regs, unsigned long error_code)
> +fastcall void __kprobes do_page_fault(struct pt_regs *regs,
> +				      unsigned long error_code)

That's not enough. You would need to change entry.S too.

Same on x86-64. And how about general protection fault?

-Andi
