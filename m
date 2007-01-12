Return-Path: <linux-kernel-owner+w=401wt.eu-S1161165AbXALXeA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161165AbXALXeA (ORCPT <rfc822;w@1wt.eu>);
	Fri, 12 Jan 2007 18:34:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161168AbXALXeA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Jan 2007 18:34:00 -0500
Received: from www.osadl.org ([213.239.205.134]:46113 "EHLO mail.tglx.de"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1161165AbXALXd7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Jan 2007 18:33:59 -0500
Subject: Re: [kvm-devel] kvm & dyntick
From: Thomas Gleixner <tglx@linutronix.de>
Reply-To: tglx@linutronix.de
To: Dor Laor <dor.laor@qumranet.com>
Cc: Ingo Molnar <mingo@elte.hu>, Avi Kivity <avik@qumranet.com>,
       kvm-devel <kvm-devel@lists.sourceforge.net>,
       linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <64F9B87B6B770947A9F8391472E0321609F7A0E2@ehost011-8.exch011.intermedia.net>
References: <45A66106.5030608@qumranet.com> <20070112062006.GA32714@elte.hu>
	 <20070112101931.GA11635@elte.hu>
	 <64F9B87B6B770947A9F8391472E0321609F7A0E2@ehost011-8.exch011.intermedia.net>
Content-Type: text/plain
Date: Sat, 13 Jan 2007 00:39:59 +0100
Message-Id: <1168645199.2941.32.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2007-01-12 at 15:25 -0800, Dor Laor wrote:
> This is great news for PV guests.
> 
> Never-the-less we still need to improve our full virtualized guest
> support. 

Full virtualized guests, which have their own dyntick support, are fine
as long as we provide local apic emulation for them.

If a guest does not have that, it will use the periodic mode. There is
no way to circumvent this. We do not know, whether the guest relies on
that periodic interrupt or not.

	tglx


