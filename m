Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932119AbWGRKKD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932119AbWGRKKD (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Jul 2006 06:10:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932128AbWGRKKD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Jul 2006 06:10:03 -0400
Received: from [216.208.38.107] ([216.208.38.107]:42112 "EHLO
	OTTLS.pngxnet.com") by vger.kernel.org with ESMTP id S932119AbWGRKKB
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Jul 2006 06:10:01 -0400
Subject: Re: [RFC PATCH 15/33] move segment checks to subarch
From: Arjan van de Ven <arjan@infradead.org>
To: Chris Wright <chrisw@sous-sol.org>
Cc: linux-kernel@vger.kernel.org, virtualization@lists.osdl.org,
       xen-devel@lists.xensource.com, Jeremy Fitzhardinge <jeremy@goop.org>,
       Andi Kleen <ak@suse.de>, Andrew Morton <akpm@osdl.org>,
       Rusty Russell <rusty@rustcorp.com.au>, Zachary Amsden <zach@vmware.com>,
       Ian Pratt <ian.pratt@xensource.com>,
       Christian Limpach <Christian.Limpach@cl.cam.ac.uk>
In-Reply-To: <20060718091952.263186000@sous-sol.org>
References: <20060718091807.467468000@sous-sol.org>
	 <20060718091952.263186000@sous-sol.org>
Content-Type: text/plain
Organization: Intel International BV
Date: Tue, 18 Jul 2006 12:09:04 +0200
Message-Id: <1153217344.3038.31.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-07-18 at 00:00 -0700, Chris Wright wrote:
> plain text document attachment (i386-segments)
> We allow for the fact that the guest kernel may not run in ring 0.
> This requires some abstraction in a few places when setting %cs or
> checking privilege level (user vs kernel).

> -	regs.xcs = __KERNEL_CS;
> +	regs.xcs = get_kernel_cs();

Hi,

wouldn't this patch be simpler if __KERNEL_CS just became the macro that
currently is get_kernel_cs() for the XEN case? then code like this
doesn't need changing at all...

Greetings,
   Arjan van de Ven

