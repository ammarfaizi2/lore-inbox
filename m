Return-Path: <linux-kernel-owner+w=401wt.eu-S1755010AbXACIQv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755010AbXACIQv (ORCPT <rfc822;w@1wt.eu>);
	Wed, 3 Jan 2007 03:16:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755012AbXACIQv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Jan 2007 03:16:51 -0500
Received: from smtp.osdl.org ([65.172.181.25]:52079 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755006AbXACIQu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Jan 2007 03:16:50 -0500
Date: Wed, 3 Jan 2007 00:16:35 -0800
From: Andrew Morton <akpm@osdl.org>
To: Ravikiran G Thirumalai <kiran@scalex86.org>
Cc: linux-kernel@vger.kernel.org, Andi Kleen <ak@suse.de>,
       "Shai Fultheim (Shai@scalex86.org)" <shai@scalex86.org>,
       pravin b shelar <pravin.shelar@calsoftinc.com>,
       "Benzi Galili (Benzi@ScaleMP.com)" <benzi@scalemp.com>
Subject: Re: [rfc] [patch 1/2] spin_lock_irq: Enable interrupts while
 spinning -- preperatory patch
Message-Id: <20070103001635.ecbd74e5.akpm@osdl.org>
In-Reply-To: <20070103075923.GA3789@localhost.localdomain>
References: <20070103075923.GA3789@localhost.localdomain>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.17; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2 Jan 2007 23:59:23 -0800
Ravikiran G Thirumalai <kiran@scalex86.org> wrote:

> The following patches do just that. The first patch is preparatory in nature
> and the second one changes the  x86_64 implementation of spin_lock_irq.
> Patch passed overnight runs of kernbench and dbench on 4 way x86_64 smp.

The end result of this is, I think, that i386 enables irqs while spinning
in spin_lock_irqsave() but not while spinning in spin_lock_irq().  And
x86_64 does the opposite.

Odd, isn't it?
